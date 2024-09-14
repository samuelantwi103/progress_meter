import 'package:flutter/material.dart';
import 'package:progress_meter/services/callback.dart';

class DropdownButtonHome extends StatefulWidget {
  DropdownButtonHome({
    super.key,
    required this.menuItems,
    required this.isCompleted,
  });
  final List<String> menuItems;
  bool isCompleted;

  @override
  State<DropdownButtonHome> createState() => _DropdownButtonHomeState();
}

class _DropdownButtonHomeState extends State<DropdownButtonHome> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // width: 50,
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surfaceContainer, // Background color
        borderRadius: BorderRadius.circular(100), // Rounded corners
        boxShadow: [
          BoxShadow(
            // spreadRadius: 100,
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4, // Adds a subtle shadow effect
          ),
        ],
      ),

      child: DropdownButtonHideUnderline(
        // Hides the underline
        child: DropdownButton<String>(
          // menuWidth: 100,
          elevation: 12,
          isDense: true,
          itemHeight: 50,
          // dropdownColor: Colors.white, // Background color of dropdown
          hint: Text(
            'Update',
            style: TextStyle(
              // color: Colors.white, // White text for the hint
              fontWeight: FontWeight.bold,
            ),
          ),

          value: selectedItem,
          style: TextStyle(
            color: Colors.black,
          ),
          items: widget.menuItems.map(
            (String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    // color: Colors.white, // White text for the hint
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedItem = value;
              if (selectedItem == "Completed") {
                // callDialog(
                //   context: context,
                //   // setState: setState,
                //   content: Text("Are you sure you have completed this task"),
                //   isCompleted: widget.isCompleted,
                // );
              }
            });
          },
        ),
      ),
    );
  }
}
