import 'package:flutter/material.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';

class PopupDialog extends StatelessWidget {
  final String title, memberId,taskId;
  final TextEditingController report;
  final Widget message;
  final VoidCallback onCancel;
  final AssignedProvider assignPro;
  

  const PopupDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.assignPro,
    required this.memberId,
    required this.report,
    required this.taskId,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: ()async{
            await submitReport(memberId, report.text.trim(), taskId, assignPro);
            report.clear();
            Navigator.pop(context);
            
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final Widget content;
  final String actionText;
  final VoidCallback onAction;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    required this.actionText,
    required this.onAction,
  }) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          widget.content,
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: widget.onAction,
              child: Text(widget.actionText),
            ),
          ),
        ],
      ),
    );
  }
}

