import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

/// A segmented button section that displays a list of tasks.
///
/// This widget creates a section with segmented buttons to filter tasks
/// based on different statuses (e.g., Pending, In Progress, Completed).
/// The body displays a list of task cards based on the selected filter.
///
/// [segmentButtons] A list of button labels to appear as the segmented buttons.
/// [tasks] The list of tasks (as maps) to be displayed based on the selected filter.

class TaskSegmentedSection extends StatefulWidget {
  TaskSegmentedSection(
      {super.key,
      required this.segmentButtons,
      required this.tasks,
      required this.admin});

  /// A list of tasks represented as a map of task data, including the title, status, and employee information.
  List<Map<String, dynamic>> tasks;
  final Admin admin;

  /// A list of button labels that will appear as segmented buttons.
  List<String> segmentButtons;

  @override
  State<TaskSegmentedSection> createState() => _TaskSegmentedSectionState();
}

class _TaskSegmentedSectionState extends State<TaskSegmentedSection> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.segmentButtons[0];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return EmptyTaskManagementScreen();
    }
    return SizedBox(
      height: 0.75 * MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SegmentedButton(
              showSelectedIcon: false,
              segments: widget.segmentButtons.map(
                (button) {
                  return ButtonSegment<String>(
                    value: button,
                    label: Text(
                      button,
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
              ).toList(),
              selected: {selectedFilter},
              onSelectionChanged: (p0) {
                setState(() {
                  selectedFilter = p0.first;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true, // To avoid infinite height error
              // physics: NeverScrollableScrollPhysics(),
              itemCount: widget.tasks
                  .where(
                    (task) =>
                        selectedFilter == widget.segmentButtons[0] ||
                        task['status'] == selectedFilter,
                  )
                  .length,
              itemBuilder: (context, index) {
                var filteredTasks = widget.tasks
                    .where(
                      (task) =>
                          selectedFilter == widget.segmentButtons[0] ||
                          task['status'] == selectedFilter,
                    )
                    .toList()
                    .reversed
                    .toList();

                final ScrollController scrollController = ScrollController();

                return Column(
                  children: [
                    adminDashTask(
                      filteredTasks[index],
                      context,
                      widget.admin,
                      onTap: () async {
                        generalLoading(context);

                        List<Map<String, dynamic>> reportList = await fetchAdminTaskReports(widget.admin.adminInfo!['uniquecode'],filteredTasks[index]['taskId']);

                        Navigator.pop(context);
                        if (filteredTasks[index]["assignedto"] == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Assign an employee to this task")));
                        } else if (filteredTasks[index]["assignedto"] != null) {
                          callBottomSheet(
                              scrollController: scrollController,
                              context: context,
                              title: "Report Summary",
                              content: SizedBox(
                                // height: 0.7*MediaQuery.of(context).size.height,
                                child:reportList.isEmpty ? EmptyReportScreen():ListView.separated(
                                  itemCount: reportList.length,
                                  itemBuilder: (context, index) {
                                    dynamic data = reportList[index];
                                    // debugPrint(data);

                                    return ListTile(
                                      title: Text(data['report'].toString()),
                                      subtitle:
                                          Text(formatDateString(data['date'])),
                                      horizontalTitleGap: 5,
                                      trailing: Text("Not Null"),
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
                        }
                      },
                    ),
                    if (index ==
                        widget.tasks
                                .where(
                                  (task) =>
                                      selectedFilter ==
                                          widget.segmentButtons[0] ||
                                      task['status'] == selectedFilter,
                                )
                                .length -
                            1)
                      SizedBox(
                        height: 100,
                      )
                  ],
                );
              },
            ),
          ),
          // SizedBox(
          // height: 10,
          // ),
          if (selectedFilter == widget.segmentButtons[0] &&
              widget.tasks.isEmpty)
            EmptyTaskManagementScreen()
          else if (selectedFilter == widget.segmentButtons[1] &&
              widget.tasks
                  .where(
                    (task) => task['status'] == "Overdue",
                  )
                  .isEmpty)
            EmptyOverdueTaskManagementScreen()
          else if (selectedFilter == widget.segmentButtons[2] &&
              widget.tasks
                  .where(
                    (task) => task['status'] == "In Progress",
                  )
                  .isEmpty)
            EmptyInProgressTaskManagementScreen()
          else if (selectedFilter == widget.segmentButtons[3] &&
              widget.tasks
                  .where(
                    (task) => task['status'] == "Completed",
                  )
                  .isEmpty)
            EmptyCompletedTaskManagementScreen(),
          // else
          // SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }
}
