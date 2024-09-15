import 'package:flutter/material.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:provider/provider.dart';


// Standup Form UI
class StandupForm extends StatefulWidget {
  const StandupForm({super.key, required this.memberId});

  final String memberId;

  @override
  State<StandupForm> createState() => _StandupFormState();
}

class _StandupFormState extends State<StandupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _standupController = TextEditingController();
  // final List<String> _taskStatuses = [
  //   "In Progress",
  //   "Completed",
  //   // "Pending",
  // ];
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    SelfTasksProvider selfPro = Provider.of<SelfTasksProvider>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Task Description
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                  filled: true,
                  alignLabelWithHint: true),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

// Tas?onst SizedBox(height: 16),

            // Stand-Up Report
            TextFormField(
              controller: _standupController,
              decoration: InputDecoration(
                labelText: 'Comments or Challenges',
                border: OutlineInputBorder(),
                filled: true,
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Any comments or challenges?';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: (){
                  
                  submitStandupForm(
                  _formKey,
                  _titleController,
                  _descriptionController,
                  _standupController,
                  _selectedStatus,
                  widget.memberId,
                  selfPro,
                  (fn) {
                    setState(() {});
                  },
                );},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
