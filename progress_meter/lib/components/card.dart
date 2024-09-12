// components/card.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/services/callback.dart';

class CardHome extends StatefulWidget {
  const CardHome({
    super.key,
    required this.title,
    required this.description,
    required this.dateAssigned,
    required this.dateDue,
    required this.status,
  });
  final String title;
  final String description;
  final String dateAssigned;
  final String dateDue;
  final String status;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Badge(
        label: Padding(
          padding: EdgeInsets.all(1),
          child: Icon(
            getStatusIcon(widget.status),
            color: getStatusColor(widget.status),
          ),
        ),
        alignment: Alignment(0.8, -0.8),
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: 500,
            ),
            // minwidth: 300,
            child: Card(
              elevation: 3, // Elevation for subtle shadow in M3
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners as per M3
              ),
              surfaceTintColor:
                  Theme.of(context).colorScheme.surfaceTint, // M3 color scheme
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                    16, 12, 12, 16), // M3 consistent padding
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligning content to the left
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Proper M3 color
                          ),
                    ),
                    const SizedBox(
                        height: 8), // Spacing between title and description

                    // Description
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4), // Spacing between rows

                            // Assigned date
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Assigned: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: widget.dateAssigned,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                              ),
                            ),

                            // Due date
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Due: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: widget.dateDue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isCompleted = !isCompleted;
                              });
                            },
                            child: Text(isCompleted ? 'Update' : 'Update'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

// HTask Status Breakdown Card
Widget taskStatusCard({
  required BuildContext context,
  required String title,
  required int count,
  required Color color,
}) {
  return Card(
    // elevation: 10,
    // color: color.withOpacity(0.1),
    child: Container(
      width: 90,
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$count",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: color),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

Widget historyCard({
  required String task,
  required String status,
  required String date,
  required BuildContext context,
}) {
  return Card.filled(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: getStatusColor(status),
          child: Icon(
            getStatusIcon(status),
          ),
        ),
        title: Text(
          task,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          date,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getStatusColor(status),
          ),
        ),
      ));
}
