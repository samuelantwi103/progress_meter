import 'package:flutter/material.dart';

class LoadingBar extends StatefulWidget {
  LoadingBar({
    super.key,
    required this.percentage,
    this.height = 15,
  });
 final double percentage;
 double height;

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: widget.percentage/100,
            minHeight: widget.height,
            // backgroundColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        const SizedBox(width: 10),
        Text("${(widget.percentage).toStringAsFixed(0)}%",
            style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
