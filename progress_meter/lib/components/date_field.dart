import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionField extends StatefulWidget {
  final TextEditingController dateController;

  const DateSelectionField({
    super.key,
    required this.dateController,
  });

  @override
  State<DateSelectionField> createState() => _DateSelectionFieldState();
}

class _DateSelectionFieldState extends State<DateSelectionField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        widget.dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Select Date',
        border: OutlineInputBorder(),
        filled: true,
        // fillColor: Colors.grey[200],
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () => _selectDate(context), // Open the date picker on tap
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Set due date';
        }
        return null;
      },
    );
  }
}
