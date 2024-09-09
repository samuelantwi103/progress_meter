// pages/home.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:progress_meter/pages/dashboard.dart';
import 'package:progress_meter/pages/history.dart';
import 'package:progress_meter/pages/profile.dart';
import 'package:progress_meter/pages/standup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;
  List<Widget> page = [
    DashboardPage(),
    StandupsPage(),
    ProfilePage(),
    HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: page[selectIndex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.feed_outlined),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
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

