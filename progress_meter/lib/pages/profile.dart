// pages/profile.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy user data
  final String userName = "Samuel Johnson";
  final String userEmail = "samuel.johnson@example.com";
  final int totalTasks = 10;
  final int completedTasks = 6;
  final int inProgressTasks = 3;
  final int pendingTasks = 1;
  final int completedStandUps = 15;

  @override
  Widget build(BuildContext context) {
    final double progressPercentage = completedTasks / totalTasks;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Center(
              child: Text("Profile"),
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Task progress bar
                Text(
                  "Overall Task Progress",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )
            )
        ],
      ),
    );
  }
}
