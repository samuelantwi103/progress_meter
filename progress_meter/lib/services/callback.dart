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
