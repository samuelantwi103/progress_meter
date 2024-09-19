import 'package:flutter/material.dart';
import 'package:progress_meter/components/date_field.dart';
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
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    SelfTasksProvider selfPro =
        Provider.of<SelfTasksProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                onPressed: () {
                  submitStandupForm(
                    _formKey,
                    context,
                    _titleController,
                    _descriptionController,
                    _standupController,
                    _selectedStatus,
                    widget.memberId,
                    selfPro,
                    (fn) {
                      setState(() {});
                    },
                  );
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Employee Form UI
class AddEmployeeForm extends StatefulWidget {
  final GlobalKey<FormState> formKey; // Pass the form key from parent

  const AddEmployeeForm({super.key, required this.formKey});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  // Controllers for the form fields
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey, // Use the passed form key
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // First Name Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: fnameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                filled: true,
                // fillColor: Colors.grey[200],
              ),
              validator: validateName,
            ),
            SizedBox(height: 10),

            // Middle Name Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: mnameController,
              decoration: InputDecoration(
                labelText: 'Middle Name',
                border: OutlineInputBorder(),
                filled: true,
                // fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),

            // Last Name Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: lnameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                filled: true,
                // fillColor: Colors.grey[200],
              ),
              validator: validateName,
            ),
            SizedBox(height: 10),

            // Code Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: codeController,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Code (e.g., sonss000)',
                border: OutlineInputBorder(),
                filled: true,
                counter: SizedBox(height: 0),
                // fillColor: Colors.grey[200],
              ),
              validator: validateCode,
            ),
            SizedBox(height: 10),

            // PIN Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: pinController,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'PIN (4 digits)',
                border: OutlineInputBorder(),
                filled: true,
                counter: SizedBox(height: 0),
                // fillColor: Colors.grey[200],
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: validatePin,
            ),
          ],
        ),
      ),
    );
  }
}

// Add Task Form UI
class AddTaskForm extends StatefulWidget {
  final GlobalKey<FormState> formKey; // Pass the form key from parent
  // Controllers for the form fields
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const AddTaskForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey, // Use the passed form key
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // First Name Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              minLines: 1,
              maxLines: 2,
              controller: titleController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Title',
                border: OutlineInputBorder(),
                filled: true,
                // fillColor: Colors.grey[200],
              ),
              validator: validateName,
            ),
            SizedBox(height: 10),

            // Middle Name Field
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              minLines: 3,
              maxLines: 5,
              controller: descriptionController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Description',
                border: OutlineInputBorder(),
                filled: true,
                // fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// Assign a task Form UI
class AssignTaskForm extends StatefulWidget {
  final GlobalKey<FormState> formKey; // Pass the form key from the parent

  const AssignTaskForm({super.key, required this.formKey});

  @override
  State<AssignTaskForm> createState() => _AssignTaskFormState();
}

class _AssignTaskFormState extends State<AssignTaskForm> {
  // Controllers for the form fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey, // Use the passed form key
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Example Name Field
          TextFormField(
            controller: employeeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: true,
            onTap: () {
              final List<String> employeeList = [
                "Francis",
                "Samuel",
                "John",
                "Doe",
                "Benjamin",
                "Wilson"
              ];
              // Show a dialog to select an employee
              callBottomSheet(
                context: context,
                scrollController: scrollController,
                full: false,
                title: "Select Employee",
                content: ListView.builder(
                  controller: scrollController,
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(employeeList[index]),
                      onTap: () {
                        setState(() {
                          employeeController.text = employeeList[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            },
            decoration: InputDecoration(
              labelText: 'Employee',
              suffixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
              filled: true,
              // fillColor: Colors.grey[200],
            ),
            validator: validateName,
          ),
          SizedBox(height: 10),

          // Date Selection Field
          DateSelectionField(
            title: "Due date",
            errorText: 'Set due date',
            dateController: dateController, // Pass the controller
          ),
        ],
      ),
    );
  }
}
