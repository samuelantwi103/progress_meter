import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/form.dart';
import 'package:progress_meter/components/segmented_section.dart';
import 'package:progress_meter/services/callback.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKeyAdd = GlobalKey<FormState>();
  // Variables to track expanded or collapsed state
  bool showMoreTasks = false;
  bool showMoreEmployees = false;
  int taskLength = 0;

// Current selected task filter
  String selectedFilter = 'All';
  // Sample task and employee data
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Update Dashboard UI",
      "status": "In Progress",
      "employee": "John Doe",
      "assignedDate": "2024-09-01",
      "dueDate": "2024-09-15"
    },
    // {
    //   "title": "Database Backup",
    //   "status": "Completed",
    //   "employee": "Jane Smith",
    //   "assignedDate": "2024-08-25",
    //   "dueDate": "2024-09-10"
    // },
    {
      "title": "Fix login bug",
      "status": "Overdue",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
    // {
    //   "title": "Fix login bug",
    //   "status": "Completed",
    //   "employee": "Mark Johnson",
    //   "assignedDate": "2024-09-05",
    //   "dueDate": "2024-09-12"
    // },
    {
      "title": "Fix login bug",
      "status": "Overdue",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
    {
      "title": "Fix login bug",
      "status": "In Progress",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
    {
      "title": "Fix login bug",
      "status": "In Progress",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
    {
      "title": "Fix login bug",
      "status": "In Progress",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                TaskSegmentedSection(
                  segmentButtons: [
                    "All",
                    "Overdue",
                    "In Progress",
                    "Completed",
                  ],
                  tasks: tasks,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callDialog(
              context: context,
              content: Form(child: AddTaskForm(formKey: _formKeyAdd)),
              title: "Add a task",
              onConfirm: () {
                if (_formKeyAdd.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Added!')),
                  );
                  Navigator.pop(context); // Close dialog on success
                }
              });
        },
        // label: Text("Add Task"),
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}
