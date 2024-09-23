// pages/history.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late TabController tabController;
    final ScrollController scrollController = ScrollController();

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
    AssignedTasks assignedTasks = Provider.of<AssignedProvider>(context, listen: true).currenMember!;
    SelfTasks notAssignedTasks = Provider.of<SelfTasksProvider>(context, listen: true).currenMember!;
    final member = Provider.of<MemberProvider>(context, listen: true).currenMember!;
    TabController tabController = TabController(length: 2, vsync: this);
    //final notAssignedTaks = Provider.of<SelfTasksProvider>(context,listen: true).currenMember!;
    try{     
      
      if (assignedTasks.getCompletedTasks.isNotEmpty) {
          historyData.addAll(assignedTasks.getCompletedTasks);
        //  historyData.reversed.toList();
        }  

   
    }
    catch(e, stack){
      debugPrint('error fetching completed tasks: $e');
      debugPrint('the stack trace is: $stack');
    }

    try{     
      
      if (assignedTasks.getOverdueTasks.isNotEmpty) {
      historyData.addAll(assignedTasks.getOverdueTasks);
      // historyData.reversed.toList();
    } 

   
    }
    catch(e){
      debugPrint('error fetching member overdue tasks: $e');
    }
    
     try{     
      
      if (notAssignedTasks.memberSelftasks!.isNotEmpty) {
      standUpsData.addAll(notAssignedTasks.memberSelftasks!);
      // standUpsData.reversed.toList();
    } 

   
    }
    catch(e, stack){
      debugPrint('error feching member self tasks: $e');
      debugPrint('the stack trace is: $stack');
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
            child: (historyData.isEmpty)
                ? EmptyHistoryScreen()
                : SingleChildScrollView(
                    child: Container(
                      height: 0.7*MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
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
                                    generalLoading(context);
                                    List<Map<String, dynamic>> reportList = await fetchAllReports(member.memberInfo!['uniquecode'], historyData[index]['taskId']);
                                    debugPrint('===============\n$reportList');
                                    Navigator.pop(context);
                                     
                                    callBottomSheet(
                                      scrollController: scrollController,
                                        context: context,
                                        title: "Report Summary",
                                        content: SizedBox(
                                          // height: 0.7*MediaQuery.of(context).size.height,
                                          child: ListView.separated(
                                            itemCount: reportList.length,
                                            itemBuilder: (context, index) {
                                              dynamic data = reportList[index];
                                              
                                              return ListTile(
                                                title: Text(data['report']),
                                                subtitle: Text(formatDateString(data['date'])),
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
                                  child: Column(
                                    children: [
                                      historyCard(
                                          task: historyItem['title'],
                                          description: historyItem['description'],
                                          status: historyItem['status'],
                                          memberId:
                                              member.memberInfo!['uniquecode'],
                                          taskid: historyItem['taskId'],
                                          date: historyItem['datecompleted'],
                                          context: context),
                                          
                                    ],
                                  ),
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
                      height: 0.7*MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: standUpsData.length,
                              itemBuilder: (context, index) {
                                final historyItem = standUpsData[index];
                                return Column(
                                  children: [
                                    historyCard(
                                        task: historyItem['title'],
                                        description: historyItem['description'],
                                        status: 'Completed',
                                        date: historyItem['time'],
                                        context: context),
                                        if (index == standUpsData.length - 1)
                                          SizedBox(
                                            height: 10,
                                          )
                                  ],
                                );
                                    
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
