// pages/standup.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:progress_meter/components/form.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class StandupsPage extends StatefulWidget {
  const StandupsPage({super.key});

  @override
  State<StandupsPage> createState() => _StandupsPageState();
}

class _StandupsPageState extends State<StandupsPage> {
 
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = convertDateTimeToString(currentDate);
    Member member = Provider.of<MemberProvider>(context,listen: true).currenMember!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Daily Standup Report",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500, minWidth: 300),
                  child: StandupForm(memberId:member.memberInfo!['uniquecode']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
