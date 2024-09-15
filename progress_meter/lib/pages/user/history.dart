// pages/history.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/services/callback.dart';
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
  final List<Map<String, dynamic>> historyData = [];
  final List<Map<String, dynamic>> standUpsData = [];

  @override
  Widget build(BuildContext context) {
    //Member member = Provider.of<MemberProvider>(context,listen: true).currenMember!;
    final assignedTasks =
        Provider.of<AssignedProvider>(context, listen: true).currenMember!;
    final notAssignedTasks =
        Provider.of<SelfTasksProvider>(context, listen: true).currenMember!;
    final member =
        Provider.of<MemberProvider>(context, listen: true).currenMember!;
    TabController tabController = TabController(length: 2, vsync: this);
    //final notAssignedTaks = Provider.of<SelfTasksProvider>(context,listen: true).currenMember!;
    if (assignedTasks.getCompletedTasks.isNotEmpty) {
      historyData.addAll(assignedTasks.getCompletedTasks);
    }

    if (assignedTasks.getOverdueTasks.isNotEmpty) {
      historyData.addAll(assignedTasks.getOverdueTasks);
    }
    if (notAssignedTasks.memberSelftasks!.isNotEmpty) {
      standUpsData.addAll(notAssignedTasks.memberSelftasks!);
    }

    // if (historyData.isEmpty) {

    //   return Scaffold(
    //       appBar: AppBar(
    //         title: Text("History"),
    //         centerTitle: true,
    //         bottom: TabBar(
    //           controller: tabController,
    //           tabs: [
    //             Tab(
    //               text: "Tasks",
    //             ),
    //             Tab(
    //               text: "Standups",
    //             ),
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(controller: tabController, children: [
    //         SafeArea(child: EmptyHistoryScreen()),
    //         SafeArea(child: EmptyHistoryScreen()),
    //       ]));
    // }

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
            child: (historyData.isEmpty)
                ? EmptyHistoryScreen()
                : SingleChildScrollView(
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
                                return InkWell(
                                  splashColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onTap: () async {
                                    List<Map<String, dynamic>> reportList = [];
                                    // await fetchAllReports(
                                    //     memberId!, taskid!);
                                    callBottomSheet(
                                        context: context,
                                        title: "Report Summary",
                                        content: SizedBox(
                                          // height: 0.7*MediaQuery.of(context).size.height,
                                          child: ListView.separated(
                                            itemCount: reportList.length,
                                            itemBuilder: (context, index) {
                                              dynamic data = reportList[index];
                                              return ListTile(
                                                title: Text(
                                                    data.reports.toString()),
                                                subtitle: Text(data.date.toString()),
                                                horizontalTitleGap: 5,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                thickness: 1,
                                                height: 1,
                                              );
                                            },
                                          ),
                                        ));
                                  },
                                  child: historyCard(
                                      task: historyItem['title'],
                                      status: historyItem['status'],
                                      memberId:
                                          member.memberInfo!['uniquecode'],
                                      taskid: historyItem['taskid'],
                                      date: historyItem['datecompleted'],
                                      context: context),
                                );
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
              child: (standUpsData.isEmpty)
                  ? EmptyHistoryScreen()
                  : Container(
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
                              itemCount: standUpsData.length,
                              itemBuilder: (context, index) {
                                final historyItem = standUpsData[index];
                                return historyCard(
                                    task: historyItem['title'],
                                    status: 'Completed',
                                    date: historyItem['time'],
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
