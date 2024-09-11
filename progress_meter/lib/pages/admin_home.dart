import 'package:flutter/material.dart';
import 'package:progress_meter/pages/admin.dart';
import 'package:progress_meter/pages/dashboard.dart';
import 'package:progress_meter/pages/history.dart';
import 'package:progress_meter/pages/profile.dart';
import 'package:progress_meter/pages/standup.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int selectIndex = 0;
  List<Widget> page = [
    DashboardPage(),
    StandupsPage(),
    ProfilePage(),
    HistoryPage(),
    AdminPage(),
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
            label: "Home",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Badge(
              label: Text("!"),
              child: Icon(Icons.task_outlined),
            ),
            selectedIcon: Icon(Icons.task_rounded),
            label: "Standups",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings_outlined),
            selectedIcon: Icon(Icons.admin_panel_settings_rounded),
            label: "Admin",
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