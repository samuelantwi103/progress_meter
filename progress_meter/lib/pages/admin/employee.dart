import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/form.dart';
import 'package:progress_meter/components/segmented_section.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:provider/provider.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final _formKey = GlobalKey<FormState>();

  // Variables to track expanded or collapsed state
  bool showMoreTasks = false;
  bool showMoreEmployees = false;
  int taskLength = 0;

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
    final admin =Provider.of<AdminProvider>(context, listen: true).currenMember!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Employee Productivity',
                //     style: Theme.of(context).textTheme.titleLarge,
                //   ),
                // ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: admin.employees!.length,
                  itemBuilder: (context, index) {
                    return adminTaskIndicator(admin.employees![index], context);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callDialog(
              context: context,
              content: AddEmployeeForm(
                formKey: _formKey,
              ),
              title: "Add an employee",
              onConfirm: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Employee Added!')),
                  );
                  Navigator.pop(context); // Close dialog on success
                }
              });
        },
        // label: Text("Add Task"),
        child: Icon(Icons.person_add_alt),
      ),
    );
  }
}
