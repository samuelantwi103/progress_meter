import 'package:flutter/material.dart';

// User Task Screen
class EmptyTaskScreen extends StatelessWidget {
  const EmptyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Great 😁\n"),
                TextSpan(text: "Don't have any tasks yet\n"),
                TextSpan(
                    text: "Work on some standups while you wait\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// User Task Screen
class EmptyReportScreen extends StatelessWidget {
  const EmptyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Uh oh 😬\n"),
                TextSpan(text: "No progress reports yet\n"),
                TextSpan(
                    text: "Attend to this task ASAP!\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Admin Task Screen
class EmptyOverdueTaskManagementScreen extends StatelessWidget {
  const EmptyOverdueTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Good job 🥳\n"),
                TextSpan(text: "No overdue tasks so far\n"),
                TextSpan(
                    text: "Check up on other tasks\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Admin Task Screen
class EmptyInProgressTaskManagementScreen extends StatelessWidget {
  const EmptyInProgressTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Great 😎\n"),
                TextSpan(text: "No tasks in the pipeline\n"),
                TextSpan(
                    text: "Create more tasks\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Admin Task Screen
class EmptyCompletedTaskManagementScreen extends StatelessWidget {
  const EmptyCompletedTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Sigh... 😪\n"),
                TextSpan(text: "No tasks completed yet\n"),
                TextSpan(
                    text: "Let's get things done\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Admin Task Screen
class EmptyTaskManagementScreen extends StatelessWidget {
  const EmptyTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.6 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Hmmm... 🤔\n"),
                TextSpan(text: "Got some tasks on your mind?\n"),
                TextSpan(
                    text: "Create one to get things moving!\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// User History Screen
class EmptyHistoryScreen extends StatelessWidget {
  const EmptyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height: 0.8 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "Oops...\n"),
                TextSpan(text: "No history yet"),
                TextSpan(
                    text: "Your previous activities show here.\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Admin Employee Screen
class EmptyEmployeeScreen extends StatelessWidget {
  EmptyEmployeeScreen({
    super.key,
    this.subComponent = false, 
  });
  bool subComponent;
 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
        height:subComponent ? 0.4 * MediaQuery.of(context).size.height : 0.8 * MediaQuery.of(context).size.height,
        child: Center(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(text: "😪Oops...\n "),
                TextSpan(text: "No employee added yet\n"),
                TextSpan(
                    text: "Add one to get things started!\n",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
