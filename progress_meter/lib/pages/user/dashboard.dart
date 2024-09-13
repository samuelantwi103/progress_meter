// pages/dashboard.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {

    Member member = Provider.of<MemberProvider>(context,listen: true).currenMember!;
    String currentDate =
        "September 12, 2024";
    final List<Map<String, String>> dummyData = [
      {
        "title": "Complete App UI",
        "description":
            "Increase the font size of app content and include theme change feature. Change theme colors to blue.",
        "dateAssigned": "12/12/2024",
        "dateDue": "24/12/2024",
        "status": "In Progress"
      },
      {
        "title": "Implement Firebase Auth",
        "description":
            "Integrate Firebase for user authentication and sign-in.",
        "dateAssigned": "10/12/2024",
        "dateDue": "18/12/2024",
        "status": "Pending"
      },
      {
        "title": "Implement Firebase Auth",
        "description":
            "Integrate Firebase for user authentication and sign-in.",
        "dateAssigned": "10/12/2024",
        "dateDue": "18/12/2024",
        "status":"Completed"
      }
    ];


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
                    currentDate,
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

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  final data = dummyData[index];
                 return Column(
                    children: [
                      CardHome(
                        title: data["title"]!,
                        description:
                            data["description"]!,
                        dateAssigned: data["dateAssigned"]!,
                        dateDue: data["dateDue"]!,
                        status: data["status"]!,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
