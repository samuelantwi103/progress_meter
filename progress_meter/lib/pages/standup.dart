// pages/standup.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class StandupsPage extends StatefulWidget {
  const StandupsPage({super.key});

  @override
  State<StandupsPage> createState() => _StandupsPageState();
}

class _StandupsPageState extends State<StandupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Standups Page"),
      ),
    );
  }
}