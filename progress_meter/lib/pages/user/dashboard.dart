// pages/dashboard.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    Member member =
        Provider.of<MemberProvider>(context, listen: true).currenMember!;

    DateTime currentDate = DateTime.now();
    String formattedDate = convertDateTimeToString(currentDate);

    AssignedProvider assPro =
        Provider.of<AssignedProvider>(context, listen: true);
    if (assPro.currenMember == null ||
        assPro.currenMember!.memberAssignedtasks == null) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Text(
                  "Welcome ${member.memberInfo!['firstname']},",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),

                // Task Assigned Section Title
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      "Tasks Assigned",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                Center(
                  child: Lottie.asset(
                    "assets/general_loading.json",
                    animate: true,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    final assignedTasks = assPro.currenMember;
    final List<Map<String, dynamic>> dummyData =
        assignedTasks!.memberAssignedtasks!;
    debugPrint('length of map: ${dummyData[0]}');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Text(
                "Welcome ${member.memberInfo!['firstname']},",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),

              // Task Assigned Section Title
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    "Tasks Assigned",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              if (dummyData.isNotEmpty ||
                  dummyData
                      .where((element) => element['status'] == 'Completed')
                      .isNotEmpty)
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dummyData.length,
                  itemBuilder: (context, index) {
                    final data = dummyData[index];
                    if (data["status"]! != "Completed") {
                      try{

                        debugPrint(data["status"]!);
                      debugPrint(member.memberInfo!['uniquecode']);
                      return Column(
                        children: [
                          CardHome(
                            title: data["title"]!,
                            description: data["description"]!,
                            dateAssigned: data["dateassigned"]!,
                            // overdue: data["overdue"]!,
                            dateDue: data["deadline"]!,
                            status: data["status"]!,
                            taskId: data["taskid"],
                            memberId: member.memberInfo!['uniquecode'],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );

                      }catch(e){
                        debugPrint('error: $e');

                      }
                      
                    } 
                    else {
                      return EmptyTaskScreen();
                    }
                  },
                )

              //=====else
              else
                Center(
                  child: Text('Empty...'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
