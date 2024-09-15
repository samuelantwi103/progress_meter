// pages/history.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this); // 2 Tabs
  }

  // Dummy data for performance history
  final List<Map<String, dynamic>> historyData = [
    // {
    //   "date": "09/09/2024",
    //   "task": "Complete App UI Design",
    //   "status": "Completed",
    // },
    // {
    //   "date": "08/09/2024",
    //   "task": "Fix bugs in API integration",
    //   "status": "In Progress",
    // },
    // {
    //   "date": "07/09/2024",
    //   "task": "Write unit tests",
    //   "status": "Overdue",
    // },
    // {
    //   "date": "06/09/2024",
    //   "task": "Standup report submitted",
    //   "status": "Completed",
    // },
    // {
    //   "date": "05/09/2024",
    //   "task": "Refactor authentication flow",
    //   "status": "Completed",
    // },
  ];

  @override
  Widget build(BuildContext context) {
    //Member member = Provider.of<MemberProvider>(context,listen: true).currenMember!;
    final assignedTasks =
        Provider.of<AssignedProvider>(context, listen: true).currenMember!;

    TabController tabController = TabController(length: 2, vsync: this);
    //final notAssignedTaks = Provider.of<SelfTasksProvider>(context,listen: true).currenMember!;
    if (assignedTasks.getCompletedTasks.isNotEmpty) {
      historyData.addAll(assignedTasks.getCompletedTasks);
    }

    if (assignedTasks.getOverdueTasks.isNotEmpty) {
      historyData.addAll(assignedTasks.getOverdueTasks);
    }

    if (historyData.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text("History"),
            centerTitle: true,
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(
                  text: "Tasks",
                ),
                Tab(
                  text: "Standups",
                ),
              ],
            ),
          ),
          body: TabBarView(controller: tabController, children: [
            SafeArea(child: EmptyHistoryScreen()),
            SafeArea(child: EmptyHistoryScreen()),
          ]));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "Tasks",
              ),
              Tab(
                text: "Standups",
              ),
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          // Tasks Section
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              task: historyItem['title'],
                              status: historyItem['status'],
                              date: historyItem['datecompleted'],
                              context: context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Standups Section
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              task: historyItem['title'],
                              status: historyItem['status'],
                              date: historyItem['datecompleted'],
                              context: context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
