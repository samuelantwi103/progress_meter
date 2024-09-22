// components/card.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/components/dropdown_button.dart';
import 'package:progress_meter/components/form.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/components/loading_bar.dart';
import 'package:progress_meter/pages/user/user_home.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:progress_meter/services/transitions.dart';
import 'package:provider/provider.dart';

class CardHome extends StatefulWidget {
  const CardHome(
      {super.key,
      required this.title,
      required this.description,
      required this.dateAssigned,
      // required this.overdue,
      required this.dateDue,
      required this.status,
      required this.taskId,
      required this.memberId});
  final String title;
  final String description;
  final String dateAssigned;
  // final String overdue;
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
    AssignedProvider assignPro =
        Provider.of<AssignedProvider>(context, listen: false);
    final member =
        Provider.of<MemberProvider>(context, listen: false).currenMember;
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
                      percentage: calculateDateTimePercentage(
                              widget.dateAssigned, widget.dateDue)
                          .toDouble(),
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!isCompleted || widget.status == "In Progress")
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
                                  onConfirm: () async {
                                    generalLoading(context);
                                    double score = (calculateDateTimePercentage(
                                                    widget.dateAssigned,
                                                    widget.dateDue)
                                                .toDouble() >
                                            50)
                                        ? 100 -
                                            calculateDateTimePercentage(
                                                    widget.dateAssigned,
                                                    widget.dateDue)
                                                .toDouble()
                                        : 50;
                                    int dayNumber = getDaysBetween(
                                        widget.dateAssigned, widget.dateDue);
                                    await markComplete(
                                        widget.taskId,
                                        widget.memberId,
                                        assignPro,
                                        member!,
                                        score,
                                        dayNumber,
                                        Provider.of<MemberProvider>(context,
                                            listen: false));
                                    TextEditingController().clear();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: Text("Complete"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  callDialog(
                                    context: context,
                                    title: "Progress Report",
                                    onConfirm: () async {
                                      generalLoading(context);
                                      await submitReport(
                                          widget.memberId,
                                          reportText.text.trim(),
                                          widget.taskId,
                                          assignPro);
                                      reportText.clear();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
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
                                          labelText: "Progress Report",
                                        ),
                                      ),
                                    ),
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
  required String description,
  required String status,
  required String date,
  required BuildContext context,
  String? taskid,
  String? memberId,
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: Theme.of(context).textTheme.bodyMedium
              // ?.copyWith(color: Colors.grey),
              ),
          Text(
            formatDateString(date),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),

      // trailing: Text(
      //   status,
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: getStatusColor(status),
      //   ),
      // ),
    ),
  );
}

// Helper method to create overview cards
Widget overviewCard(
  String title,
  String value,
  Color color,
  BuildContext context,
) {
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
Widget adminDashTask(
  Map<String, dynamic> task,
  BuildContext context,
  Admin admin, {
  void Function()? onTap,
}) {
  final formKeyAssign = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  Map<String, dynamic> employeeSelected = {};

  return Badge(
    label: Padding(
      padding: EdgeInsets.all(1),
      child: Icon(
        getStatusIcon(task["status"]),
        color: getStatusColor(task["status"]),
      ),
    ),
    alignment: Alignment(0.85, -0.8),
    backgroundColor: Colors.transparent,
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primaryContainer,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Task title
              Text(
                task["title"]!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 5),
              Text(task["description"]!,
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 8),

              // Assigned Employee
              (task["assignedto"] == null)
                  ? Text(
                      "Assigned to: N/A",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Assigned to: ${task["assignedto"]}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 4),

              // Assigned and Due Dates

              (task["dateassigned"] == null)
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Assigned:",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      Text(
                          "N/A",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Assigned:",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      Text(
                          "${formatDateString(task["dateassigned"])}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
              (task["deadline"] == null)
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Due:",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      Text(
                          "N/A",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Due:",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      Text(
                          "${formatDateString(task["deadline"])}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
              SizedBox(
                height: 10,
              ),
              if (task["assignedto"] != null)
                LoadingBar(
                  percentage: calculateDateTimePercentage(
                          task['dateassigned'], task['deadline'])
                      .toDouble(),
                  // height: 10,
                ),

              if (task["assignedto"] == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.tonal(
                      onPressed: () {
                        void getSelectedEmployee(
                            Map<String, dynamic> selected) {
                          employeeSelected = selected;
                        }

                        callDialog(
                            context: context,
                            content: AssignTaskForm(
                              formKey: formKeyAssign,
                              admin: admin,
                              employeeController: employeeController,
                              dateController: dateController,
                              employeeSelected: employeeSelected,
                              getSelectedEmployee: getSelectedEmployee,
                            ),
                            title: "Assign a task",
                            onConfirm: () async {
                              if (formKeyAssign.currentState!.validate()) {
                                // final List<Map<String, dynamic>> employeeList =
                                //     admin.employees!;
                                generalLoading(context);
                                task['dateassigned'] =
                                    DateTime.now().toString();
                                task['deadline'] = dateController.text.trim();
                                task['assignedto'] =
                                    '${employeeSelected['firstname']} ${employeeSelected['lastname']}';
                                admin.updateTask(task);
                                debugPrint('Oncall: $employeeSelected');
                                debugPrint('Task content: $task');
                                await assignTaskToMember(
                                    employeeSelected, task, context);
                                Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .setCurrentAdmin(admin);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Task assigned to ${employeeController.text}")));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Task due on ${dateController.text}")));
                              }
                            });
                      },
                      child: Text("Assign"),
                    ),
                    SizedBox(width: 10),
                    FilledButton.tonal(
                      onPressed: () {
                        callDialog(
                            context: context,
                            content: Text(
                                "Are you sure you want to delete this task?"),
                            title: "Delete task",
                            onConfirm: () async {
                              generalLoading(context);
                              await admin.deleteTask(task['taskId']);
                              Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .setCurrentAdmin(admin);
                              Navigator.pop(context);
                              Navigator.pop(context);

                            });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.5)),
                      ),
                      child: Text("Delete"),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    ),
  );
}

// Helper method to create Employee Productivity Ranking Card with LinearProgressIndicator
Widget adminTaskIndicator(
  Map<String, dynamic> employee,
  BuildContext context, {
  bool overview = false,
}) {
  return Card.outlined(
    elevation: 10,
    child: InkWell(
      onTap: () async {
        final assPro = Provider.of<AssignedProvider>(context,listen:false);
        final selfPro = Provider.of<SelfTasksProvider>(context,listen:false);
        final assigned = AssignedTasks();
        final selfTasks = SelfTasks();
        if(await fetchdata(context, employee['uniquecode'], employee['pin'].toString())){

            Navigator.pop(context);
            Navigator.push( context, createSlideScaleTransition(HomePage()));
            await fetchAssignedTasks(assigned, employee['uniquecode'], pin: employee['pin'].toString());
            await fetchSelfTasks(selfTasks, employee['uniquecode'], pin: employee['pin'].toString());
            assPro.setCurrentAssignedTasks(assigned);
            selfPro.setCurrentSelfTaks(selfTasks);
        }
        
        //Navigator.push(context, logoutTransition(HomePage()));
      },
      enableFeedback: true,
      splashColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employee name
            Text(
              employee["firstname"],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Overall:   ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: LoadingBar(
                        percentage:
                            employee["personalperformance"].toDouble())),
              ],
            ),
            if (!overview)
              Row(
                children: [
                  Text(
                    "Personal:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: LoadingBar(
                          percentage:
                              employee["overallperformance"].toDouble())),
                ],
              ),

            // Divider()
          ],
        ),
      ),
    ),
  );
}
