import 'package:flutter/material.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/components/dialog.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';

// Standup Form Handler
Future<void> submitStandupForm(
  _formKey,
  TextEditingController titleController,
  TextEditingController descriptionController,
  TextEditingController standupController,
  String? selectedStatus,
  String memberId,
  SelfTasksProvider selfPro,
  void setState(void Function() fn),
) async {
  if (_formKey.currentState!.validate()) {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    final String standupReport = standupController.text.trim();
    final String status = selectedStatus ?? 'No Status Selected';

    submitStandUp(title, description, standupReport, memberId, selfPro);

    print("Title: $title");
    print("Description: $description");
    print("Status: $status");
    print("Stand-Up Report: $standupReport");

    // Clear the form after submission
    titleController.clear();
    descriptionController.clear();
    standupController.clear();
    setState(() {
      selectedStatus = null;
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

  // Validators
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateCode(String? value) {
    final codeRegex = RegExp(r'^[A-Za-z]{3}[A-Za-z0-9]{5}$');
    if (value == null || value.isEmpty) {
      return 'Code is required';
    } else if (!codeRegex.hasMatch(value)) {
      return 'Invalid code format (e.g., ABC-12E4F)';
    }
    return null;
  }

  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    } else if (value.length != 4 || !RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'PIN must be 4 digits';
    }
    return null;
  }


// Get Color based on status
Color getStatusColor(String status) {
  switch (status) {
    case "Completed":
      return Colors.green;
    case "In Progress":
      return Colors.orange;
    case "Overdue":
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
    case "Overdue":
      return Icons.pending;
    default:
      return Icons.help_outline;
  }
}

void callBottomSheet({
  required BuildContext context,
  required String title,
  String? actionText,
  bool isCompleted = false,
  required Widget content,

  // string
}) {
  showModalBottomSheet(
    showDragHandle: true,
    enableDrag: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return CustomBottomSheet(
          title: title,
          content: content,
          actionText: actionText,
          onAction: () {
            // setState(() {
            //   isCompleted =true;
            // });
          });
    },
  );
}

void callDialog({
  required BuildContext context,
  required Widget content,
  required String title,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return PopupDialog(
          title: title,
          message: content,
          onConfirm: onConfirm,
          onCancel: () {
            Navigator.pop(context);
          });
    },
  );
}
