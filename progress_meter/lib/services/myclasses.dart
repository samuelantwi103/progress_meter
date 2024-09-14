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
          // Navigator.pop(context);
      Navigator.pushReplacement(
          context, createSlideScaleTransition(HomePage()));
    } else {
      debugPrint('Wrong inputs');
    }
  } else {
    debugPrint('incorrect values');
  }
}
