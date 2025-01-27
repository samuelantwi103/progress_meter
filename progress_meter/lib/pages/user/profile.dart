// pages/profile.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/loading_bar.dart';
import 'package:progress_meter/pages/login.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:progress_meter/services/transitions.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy user data

  @override
  Widget build(BuildContext context) {
    Member member =
        Provider.of<MemberProvider>(context, listen: true).currenMember!;
    final assignedTasks =
        Provider.of<AssignedProvider>(context, listen: true).currenMember!;
    final notAssignedTaks =
        Provider.of<SelfTasksProvider>(context, listen: true).currenMember!;
    int totalTasks =assignedTasks.memberAssignedtasks!=null? assignedTasks.memberAssignedtasks!.length:0;
    int completedTasks =assignedTasks.getCompletedTasks != null? assignedTasks.getCompletedTasks.length:0;
    int inProgressTasks =assignedTasks.getProgressTasks != null? assignedTasks.getProgressTasks.length:0;
    int pendingTasks =assignedTasks.getOverdueTasks != null? assignedTasks.getOverdueTasks.length:0;
    int completedStandUps =notAssignedTaks.memberSelftasks != null? notAssignedTaks.memberSelftasks!.length:0;
    int completeOverdue = completedTasks + pendingTasks;

    //final double progressPercentage = completedTasks / totalTasks;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar.medium(
            title: Text("Profile"),

            // centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.light_mode),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, logoutTransition(LoginPage()));
                },
                icon: Icon(Icons.logout_outlined),
                label: Text("Logout"),
              ),
            ],
          ),

          // Body
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxWidth: 400,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset(
                            "assets/son_logo.png",
                            height: 0.1*MediaQuery.of(context).size.height,
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        
                        SizedBox(
                          width: 0.5*MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${member.memberInfo!['firstname']}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                '${member.memberInfo!['middlename']} ${member.memberInfo!['lastname']}',
                                style:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member.memberInfo!['uniquecode'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Task progress bar
                    Text(
                      "Personal Performance",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    SizedBox(height: 5),
                    LoadingBar(
                        percentage: (completeOverdue == 0)? 0: double.parse(
                            (member.memberInfo!['completedscores'] /
                                    (completeOverdue))
                                .toStringAsFixed(2))),
                    SizedBox(height: 10),
                    // Task progress bar
                    Text(
                      "Overall Performance",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    SizedBox(height: 5),
                    LoadingBar(percentage: 12),
                    SizedBox(height: 40),

                    // Task breakdown section
                    Text(
                      "Task Breakdown",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          // Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // children: [
                          taskStatusCard(
                            context: context,
                            title: "All",
                            count: totalTasks,
                            color: Colors.black,
                          ),
                          taskStatusCard(
                            context: context,
                            title: "Completed",
                            count: completedTasks,
                            color: Colors.green,
                          ),
                          taskStatusCard(
                            context: context,
                            title: "In Progress",
                            count: inProgressTasks,
                            color: Colors.orange,
                          ),
                          taskStatusCard(
                            context: context,
                            title: "Overdue",
                            count: pendingTasks,
                            color: Colors.red,
                          ),
                          // ],
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Stand-up summary
                    Text(
                      "Stand-Ups Completed",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: completedStandUps.toStringAsFixed(0),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              TextSpan(
                                text: " out of ",
                              ),
                              TextSpan(
                                text: '${getDaysInCurrentMonth()}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                          // style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "stand-ups completed for this month 🥳",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
