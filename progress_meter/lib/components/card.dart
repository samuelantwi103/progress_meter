// components/card.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/dropdown_button.dart';
import 'package:progress_meter/components/loading_bar.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class CardHome extends StatefulWidget {
  const CardHome({
    super.key,
    required this.title,
    required this.description,
    required this.dateAssigned,
    required this.overdue,
    required this.dateDue,
    required this.status,
    required this.taskId,
    required this.memberId
  });
  final String title;
  final String description;
  final String dateAssigned;
  final String overdue;
  final String dateDue;
  final String status;
  final String taskId;
  final String memberId;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    AssignedProvider assignPro = Provider.of<AssignedProvider>(context,listen:false);
    TextEditingController reportText = TextEditingController();
    return Container(

      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Badge(
        label: Padding(
          padding: EdgeInsets.all(1),
          child: Icon(
            getStatusIcon(widget.status),
            color: getStatusColor(widget.status),
          ),
        ),
        alignment: Alignment(0.8, -0.8),
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: 500,
            ),
            // minwidth: 300,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    // const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // const SizedBox(height: 12),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Assigned: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text: formatDateString(widget.dateAssigned),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ),

                        // Due date
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Due: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text: formatDateString(widget.dateDue),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    LoadingBar(
                      percentage: calculateDateTimePercentage(widget.dateAssigned, widget.dateDue).toDouble(),
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!isCompleted || widget.status == "true")
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                callDialog(
                                  context: context,
                                  title: "Complete Task",
                                  content: Text(
                                      "Are you sure you have completed this task?"),
                                  taskId: widget.taskId,
                                  memberId: widget.memberId,
                                  assignPro: assignPro,
                                  report: TextEditingController(),
                                  // onConfirm: () {
                                  //   setState(() {
                                  //     isCompleted = true;
                                  //   });
                                  //   // Navigator.pop(context);
                                  // },
                                );
                              },
                              child: Text("Complete"),
                            ),
                            ElevatedButton(
                                // style: ButtonStyle(
                                //     elevation: WidgetStatePropertyAll(3)),
                                onPressed: () {
                                  callDialog(
                                    
                                    context: context,
                                    title: "Progress Report",
                                    content: Form(
                                      // key: ,
                                      child: TextFormField(
                                        controller: reportText,
                                        maxLines: 4,

                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            // borderRadius: BorderRadius.circular(50)
                                          ),
                                          alignLabelWithHint: true,
                                          filled: true,
                                            labelText: "Progress Report"),
                                            
                                      ),
                                    ),
                                    taskId: widget.taskId,
                                    memberId: widget.memberId,
                                    assignPro: assignPro,
                                    report: reportText
                                    
                                  );
                                },
                                child: Text("Report"))
                          ],
                        ),
                        // child: ElevatedButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       isCompleted = !isCompleted;
                        //     });
                        //   },
                        //   child: Text('Update'),
                        // ),
                      )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

// HTask Status Breakdown Card
Widget taskStatusCard({
  required BuildContext context,
  required String title,
  required int count,
  required Color color,
}) {
  return Card(
    // elevation: 10,
    // color: color.withOpacity(0.1),
    child: Container(
      // width: 90,
      padding: const EdgeInsets.all(4.0),
      constraints: BoxConstraints(minWidth: 120, minHeight: 120
          // maxWidth: 200,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$count",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: color),
          ),
          // const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          // const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

Widget historyCard({
  required String task,
  required String status,
  required String date,
  required BuildContext context,
}) {
  return Card.filled(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: getStatusColor(status),
          child: Icon(
            getStatusIcon(status),
          ),
        ),
        title: Text(
          task,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          date,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getStatusColor(status),
          ),
        ),
      ));
}

// Helper method to create overview cards
Widget overviewCard(
    String title, String value, Color color, BuildContext context) {
  return Container(
    width: 180,
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

// Helper method to create a Task Card
Widget adminDashTask(Map<String, dynamic> task, BuildContext context) {
  return Badge(
    label: Padding(
      padding: EdgeInsets.all(1),
      child: Icon(
        getStatusIcon(task["status"]),
        color: getStatusColor(task["status"]),
      ),
    ),
    alignment: Alignment(0.8, -0.6),
    backgroundColor: Colors.transparent,
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(
              task["title"]!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8),

            // Task status
            // Text(
            //   "Status: ${task["status"]}",
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
            // SizedBox(height: 4),

            // Assigned Employee
            Text(
              "Assigned to: ${task["employee"]}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 4),

            // Assigned and Due Dates
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Assigned: ${task["assignedDate"]}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Due: ${task["dueDate"]}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper method to create Employee Productivity Ranking Card with LinearProgressIndicator
Widget adminTaskIndicator(Map<String, dynamic> employee, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Employee name
      Text(
        employee["name"],
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      // SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: employee["performance"],
              minHeight: 15,
              // backgroundColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          const SizedBox(width: 10),
          Text("${(100 * employee["performance"]).toStringAsFixed(0)}%",
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
      Divider()
    ],
  );
}
