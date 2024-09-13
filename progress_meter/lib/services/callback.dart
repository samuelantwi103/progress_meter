import 'package:flutter/material.dart';

// Standup Form Handler
void submitStandupForm(
  _formKey,
  TextEditingController _titleController,
  TextEditingController _descriptionController,
  TextEditingController _standupController,
  String? _selectedStatus,
  void setState(void Function() fn),
) {
  if (_formKey.currentState!.validate()) {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String standupReport = _standupController.text;
    final String status = _selectedStatus ?? 'No Status Selected';

    print("Title: $title");
    print("Description: $description");
    print("Status: $status");
    print("Stand-Up Report: $standupReport");

    // Clear the form after submission
    _titleController.clear();
    _descriptionController.clear();
    _standupController.clear();
    setState(() {
      _selectedStatus = null;
    });
  }
}

// Login Text Formatter
void formatLoginCode(TextEditingController controller) {
  String currentText = controller.text;

 currentText = currentText.replaceAll('-', '');

  // if (currentText.length > 3) {
  //   currentText = currentText.substring(0, 3) + '-' + currentText.substring(3);
  // }

  controller.value = controller.value.copyWith(
      text: currentText,
      selection: TextSelection.collapsed(offset: currentText.length));
}

// Get Color based on status
Color getStatusColor(String status) {
  switch (status) {
    case "Completed":
      return Colors.green;
    case "In Progress":
      return Colors.orange;
    case "Pending":
      return Colors.red;      
    default:
    return Colors.grey;
  }
}

// Get icon based on status
IconData getStatusIcon(String status) {
  switch (status) {
    case "Completed":
        return Icons.check_circle_outline;
      case "In Progress":
        return Icons.hourglass_bottom;
      case "Pending":
        return Icons.pending;
      default:
        return Icons.help_outline;
  }
}