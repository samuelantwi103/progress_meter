import 'package:flutter/material.dart';
import 'package:progress_meter/components/pop_up_dialog.dart';
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
    
    submitStandUp(title, description, standupReport, memberId,selfPro);


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
  // required Function(void Function() fn) setState,
  bool isCompleted = false,
  required Widget content,

  // string
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return CustomBottomSheet(
          title: "Task Completed?",
          content: content,
          actionText: "Yes",
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
  required String memberId,taskId,
  required TextEditingController report,
  required AssignedProvider assignPro,
  
}) {
  showDialog(
    context: context,
    builder: (context) {
      return PopupDialog(
          title: title,
          message: content,
          report: report,
          assignPro: assignPro,
          taskId: taskId,
          memberId: memberId,
          onCancel: () {
            Navigator.pop(context);
          });
    },
  );
}
