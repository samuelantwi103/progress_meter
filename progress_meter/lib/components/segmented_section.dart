import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';

/// A segmented button section that displays a list of tasks.
///
/// This widget creates a section with segmented buttons to filter tasks
/// based on different statuses (e.g., Pending, In Progress, Completed). 
/// The body displays a list of task cards based on the selected filter.
///
/// [segmentButtons] A list of button labels to appear as the segmented buttons.
/// [tasks] The list of tasks (as maps) to be displayed based on the selected filter.
/// [showMoreTasks] A flag that controls whether more tasks should be shown in the list.
/// [showMoreEmployees] A flag that controls whether more employee-related data should be shown.
class TaskSegmentedSection extends StatefulWidget {
  TaskSegmentedSection({
    super.key,
    required this.segmentButtons,
    required this.tasks,
  });

  /// A list of tasks represented as a map of task data, including the title, status, and employee information.
  List<Map<String, dynamic>> tasks;

  /// A list of button labels that will appear as segmented buttons.
  List<String> segmentButtons;
  

  @override
  State<TaskSegmentedSection> createState() => _TaskSegmentedSectionState();
}

class _TaskSegmentedSectionState extends State<TaskSegmentedSection> {
  bool showMoreTasks = false;
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.segmentButtons[0];
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tasks.isEmpty){
      return Container(
        child: Text("No Tasks yet. Create one"),
      );
    }
    return Column(
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
        ListView.builder(
          shrinkWrap: true, // To avoid infinite height error
          physics: NeverScrollableScrollPhysics(),
          itemCount: showMoreTasks
              ? widget.tasks
                  .where(
                    (task) =>
                        selectedFilter == widget.segmentButtons[0]  ||
                        task['status'] == selectedFilter,
                  )
                  .length
              : (widget.tasks
                          .where(
                            (task) =>
                                selectedFilter == widget.segmentButtons[0]  ||
                                task['status'] == selectedFilter,
                          )
                          .length <
                      3)
                  ? widget.tasks
                      .where(
                        (task) =>
                            selectedFilter == widget.segmentButtons[0]  ||
                            task['status'] == selectedFilter,
                      )
                      .length
                  : 3,
          itemBuilder: (context, index) {
            var filteredTasks = widget.tasks
                .where(
                  (task) =>
                      selectedFilter == widget.segmentButtons[0] ||
                      task['status'] == selectedFilter,
                )
                .toList();
            return adminDashTask(filteredTasks[index], context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              showMoreTasks = !showMoreTasks;
            });
          },
          child: Text(showMoreTasks ? 'Show Less' : 'Show more'),
        ),
      ],
    );
  }
}
