import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/segmented_section.dart';
import 'package:progress_meter/pages/login.dart';
import 'package:progress_meter/services/transitions.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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
    {
      "title": "Database Backup",
      "status": "Completed",
      "employee": "Jane Smith",
      "assignedDate": "2024-08-25",
      "dueDate": "2024-09-10"
    },
    {
      "title": "Fix login bug",
      "status": "Overdue",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
    {
      "title": "Fix login bug",
      "status": "Completed",
      "employee": "Mark Johnson",
      "assignedDate": "2024-09-05",
      "dueDate": "2024-09-12"
    },
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
  ];

  final List<Map<String, dynamic>> employees = [
    {
      "name": "John Doe",
      "overallperformance": 95,
      "personalperformance": 80,
    },
    {
      "name": "Jane Smith",
      "overallperformance": 88,
      "personalperformance": 35,
    },
    {
      "name": "Mark Johnson",
      "overallperformance": 75,
      "personalperformance": 65,
    },
    {
      "name": "Mark Johnson",
      "overallperformance": 40,
      "personalperformance": 75,
    },
    {
      "name": "Mark Johnson",
      "overallperformance": 50,
      "personalperformance": 60,
    },
    {
      "name": "Mark Johnson",
      "overallperformance": 40,
      "personalperformance": 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                logoutTransition(LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                // Section: Task Cards
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 10),

                // Overview Cards Section
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      overviewCard("All Tasks", "20", Colors.blue, context),
                      overviewCard("Overdue Tasks", "4", Colors.red, context),
                      overviewCard(
                          "Tasks in Progress", "12", Colors.orange, context),
                      overviewCard(
                          "Completed Tasks", "8", Colors.green, context),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Task Overview Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tasks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
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

                // Section: Employee Productivity
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Employee Productivity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: showMoreEmployees
                      ? employees.length
                      : (employees.length < 3)
                          ? employees.length
                          : 3,
                  itemBuilder: (context, index) {
                    return adminTaskIndicator(employees[index], context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showMoreEmployees =
                          !showMoreEmployees; // Toggle show more/less
                    });
                  },
                  child: Text(showMoreEmployees ? 'Show Less' : 'Show More'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
