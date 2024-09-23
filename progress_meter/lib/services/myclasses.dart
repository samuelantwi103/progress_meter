import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_meter/pages/user/user_home.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:progress_meter/services/transitions.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  
  Map<String, dynamic>? memberInfo;

  Member();

  Future<void> updateData(double value) async{
    memberInfo!['completedscores'] += value;
    await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(memberInfo!['uniquecode']))
      .collection('members')
      .doc(memberInfo!['uniquecode'])
      .update(memberInfo!);
      


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


//===========================================ADMIN CLASS
class Admin{

  Map<String, dynamic>? adminInfo;
  List<Map<String, dynamic>>? employees;
  List<Map<String, dynamic>>? tasks;

  Admin();

  List<Map<String, dynamic>> getTasksInProgress(){

    List<Map<String, dynamic>> progress = tasks!.where((task) {
          // Check if the task has a "status" field and if it indicates completion
          return task['status'] ==
              'In Progress'; // Adjust this condition based on your data structure
        }).toList();

    return progress;
  }

  List<Map<String, dynamic>> getTasksCompleted(){

    List<Map<String, dynamic>> completed = tasks!.where((task) {
          // Check if the task has a "status" field and if it indicates completion
          return task['status'] ==
              'Completed'; // Adjust this condition based on your data structure
        }).toList();
    return completed;
  }

  List<Map<String, dynamic>> getTasksOverdue(){

    List<Map<String, dynamic>> overdues = tasks!.where((task) {
      // Check if the task has a "status" field and if it indicates completion
      return task['status'] ==
          'Overdue'; // Adjust this condition based on your data structure
    }).toList();

    return overdues;
  }

  Future<void> addNewTask(String title,String description) async {

    DateTime taskId = DateTime.now();
    await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(adminInfo!['uniquecode']))
      .collection('tasks')
      .doc(convertDateTimeToCompactString(taskId))
      .set({
        'taskId': convertDateTimeToCompactString(taskId),
        'title': title,
        'description': description,
        'status': 'In Progress',
        'month': DateFormat.MMMM().format(taskId),
        'year': DateFormat.y().format(taskId)
      });
  }

  Future<void> deleteTask(String taskId) async {

    try{
      await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(adminInfo!['uniquecode']))
      .collection('tasks')
      .doc(taskId)
      .delete();

      int index = tasks!.indexWhere((admintask) => admintask['taskId'] == taskId);
      tasks!.remove(tasks![index]);
    }
    catch(e){
      debugPrint('Error deleting task: $e');
    }
    
  }

    Future<void> updateTask(Map<String,dynamic> task) async {

    //DateTime taskId = DateTime.now();
    int index = tasks!.indexWhere((admintask) => admintask['taskId'] == task['taskId']);

  // If the task is found (index is not -1), update it
  if (index != -1) {
    tasks![index] = task;
  }
    await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(adminInfo!['uniquecode']))
      .collection('tasks')
      .doc(task['taskId'])
      .update(task);
  }

}

//=======================================ADMIN CLASS Provider

class AdminProvider extends ChangeNotifier {
  Admin? _currentAdmin;

  Admin? get currenMember => _currentAdmin;

  void setCurrentAdmin(Admin admin) {
    _currentAdmin = admin;
    notifyListeners();
  }
}

//=================================================
Future<bool> fetchdata(BuildContext context, String uid, String pin) async {

  bool state = false;

  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  DocumentSnapshot usersnap = await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(uid))
      .collection('members')
      .doc(uid)
      .get();
  if (usersnap.exists) {
    // do something
    if (usersnap['pin'].toString() == pin) {

      // document to help check if we are in a new month or not.
      final docToCheck = await FirebaseFirestore.instance.collection('organisations')
          .doc(getFirstThreeLetters(uid))
          .collection('members').doc(uid)
          .collection('months').doc(monthdoc).get();

      if(!docToCheck.exists){

        await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(uid)).collection('members').doc(uid).update({
          'completedscores': 0,
          'overallperformance': 0,
          'personalperformance': 0,

        });
      }
       DocumentSnapshot usersnap2 = await FirebaseFirestore.instance
      .collection('organisations')
      .doc(getFirstThreeLetters(uid))
      .collection('members')
      .doc(uid)
      .get();
      Member member = Member();
      member.memberInfo = usersnap2.data() as Map<String, dynamic>;
      Provider.of<MemberProvider>(context, listen: false)
          .setCurrentMember(member);
      
      state = true;
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
  return state;
}
