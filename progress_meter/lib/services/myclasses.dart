import 'package:flutter/material.dart';
import 'package:progress_meter/pages/user/user_home.dart';
import 'package:progress_meter/services/transitions.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String? firstName, middleName, lastName;
  String? code;
  String? pin;
  Map<String, dynamic>? memberInfo;

  Member();

  Future<void> updateData(double value) async{
    memberInfo!['completedscores'] += value;
    await FirebaseFirestore.instance
      .collection('organisations')
      .doc('son')
      .collection('members')
      .doc(memberInfo!['uniquecode'])
      .update(memberInfo!);
      debugPrint('successfully marked complete');


  }
}

class MemberProvider extends ChangeNotifier {
  Member? _currentMember;

  Member? get currenMember => _currentMember;

  void setCurrentMember(Member member) {
    _currentMember = member;
    notifyListeners();
  }
}

//===============================================================

class AssignedTasks {
  List<Map<String, dynamic>>? memberAssignedtasks;

  AssignedTasks();

  List<Map<String, dynamic>> get getCompletedTasks {
    // Ensure memberAssignedtasks is not null and contains data
    if (memberAssignedtasks == null) {
      return [];
    }

    // Filter tasks that are marked as completed
    List<Map<String, dynamic>> completed = memberAssignedtasks!.where((task) {
      // Check if the task has a "status" field and if it indicates completion
      return task['status'] ==
          'Completed'; // Adjust this condition based on your data structure
    }).toList();

    return completed;
  }

  List<Map<String, dynamic>> get getProgressTasks {
    // Ensure memberAssignedtasks is not null and contains data
    if (memberAssignedtasks == null) {
      return [];
    }

    // Filter tasks that are marked as completed
    List<Map<String, dynamic>> completed = memberAssignedtasks!.where((task) {
      // Check if the task has a "status" field and if it indicates completion
      return task['status'] ==
          'In Progress'; // Adjust this condition based on your data structure
    }).toList();

    return completed;
  }

  List<Map<String, dynamic>> get getOverdueTasks {
    // Ensure memberAssignedtasks is not null and contains data
    if (memberAssignedtasks == null) {
      return [];
    }

    // Filter tasks that are marked as completed
    List<Map<String, dynamic>> completed = memberAssignedtasks!.where((task) {
      // Check if the task has a "status" field and if it indicates completion
      return task['status'] ==
          'Overdue'; // Adjust this condition based on your data structure
    }).toList();

    return completed;
  }
}

class AssignedProvider extends ChangeNotifier {
  AssignedTasks? _currentTasks;

  AssignedTasks? get currenMember => _currentTasks;

  void setCurrentAssignedTasks(AssignedTasks tasks) {
    _currentTasks = tasks;
    notifyListeners();
  }
}

//=============================================================

class SelfTasks {
  List<Map<String, dynamic>>? memberSelftasks;

  SelfTasks();
}

class SelfTasksProvider extends ChangeNotifier {
  SelfTasks? _currentTasks;

  SelfTasks? get currenMember => _currentTasks;

  void setCurrentSelfTaks(SelfTasks tasks) {
    _currentTasks = tasks;
    notifyListeners();
  }
}

Future<void> fetchdata(BuildContext context, String uid, String pin) async {
  DocumentSnapshot usersnap = await FirebaseFirestore.instance
      .collection('organisations')
      .doc('son')
      .collection('members')
      .doc(uid)
      .get();
  if (usersnap.exists) {
    // do something
    if (usersnap['pin'].toString() == pin) {
      Member member = Member();
      member.memberInfo = usersnap.data() as Map<String, dynamic>;
      Provider.of<MemberProvider>(context, listen: false)
          .setCurrentMember(member);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, createSlideScaleTransition(HomePage()));
    } else {
      Navigator.pop(context);
      debugPrint('Wrong inputs');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Wrong Credentials")),
      );
    }
  } else {
    Navigator.pop(context);
    debugPrint('incorrect values');
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wrong Credentials")),
      );
  }
}
