// pages/history.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Dummy data for performance history
  final List<Map<String, dynamic>> historyData = [
    {
      "date": "09/09/2024",
      "task": "Complete App UI Design",
      "status": "Completed",
    },
    {
      "date": "08/09/2024",
      "task": "Fix bugs in API integration",
      "status": "In Progress",
    },
    {
      "date": "07/09/2024",
      "task": "Write unit tests",
      "status": "Pending",
    },
    {
      "date": "06/09/2024",
      "task": "Standup report submitted",
      "status": "Completed",
    },
    {
      "date": "05/09/2024",
      "task": "Refactor authentication flow",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "History",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyData.length,
                    itemBuilder: (context, index) {
                      final historyItem = historyData[index];
                      return historyCard(
                          task: historyItem['task'],
                          status: historyItem['status'],
                          date: historyItem['date'],
                          context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
