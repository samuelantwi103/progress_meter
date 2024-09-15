import 'package:flutter/material.dart';

// History Screen
class EmptyTaskScreen extends StatelessWidget {
  const EmptyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
      height: 0.8*MediaQuery.of(context).size.height,
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
                TextSpan(text: "Don't have any tasks yet"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// History Screen
class EmptyHistoryScreen extends StatelessWidget {
  const EmptyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        // color: Colors.amber,
      height: 0.8*MediaQuery.of(context).size.height,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
