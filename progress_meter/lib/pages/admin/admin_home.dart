import 'package:flutter/material.dart';
import 'package:progress_meter/pages/admin/dashboard.dart';
import 'package:progress_meter/pages/admin/employee.dart';
import 'package:progress_meter/pages/admin/task.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int selectIndex = 0;
  List<Widget> page = [
    AdminDashboardPage(),
    TaskPage(),
    EmployeePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[selectIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.home_outlined),
            ),
            label: "Dashboard",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Badge(
              label: Text("!"),
              child: Icon(Icons.task_outlined),
            ),
            selectedIcon: Icon(Icons.task_rounded),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Badge(
              // label: Text("!"),
              isLabelVisible: false,
              child: Icon(Icons.groups),
            ),
            selectedIcon: Icon(Icons.groups_outlined),
            label: "Employees",
          ),
        ],
        elevation: 10,
        selectedIndex: selectIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectIndex = value;
          });
        },
      ),
    );
  }
}
