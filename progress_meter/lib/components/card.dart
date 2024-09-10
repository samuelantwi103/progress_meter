// components/card.dart
import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  const CardHome({
    super.key,
    required this.title,
    required this.description,
    required this.dateAssigned,
    required this.dateDue,
  });
  final String title;
  final String description;
  final String dateAssigned;
  final String dateDue;

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
        child: ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 300,
        maxWidth: 500,
      ),
      // minwidth: 300,
      child: Card(
        elevation: 3, // Elevation for subtle shadow in M3
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners as per M3
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: widget.dateAssigned,
                                  style: Theme.of(context).textTheme.bodySmall),
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
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: widget.dateDue,
                                  style: Theme.of(context).textTheme.bodySmall),
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
                      child: Text(isCompleted ? 'Done' : 'Done'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
