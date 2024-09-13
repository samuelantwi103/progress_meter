import 'package:flutter/material.dart';
import 'package:progress_meter/pages/user/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Member{

  String? firstName, middleName, lastName;
  String? code;
  String? pin;

  Member();
}

class MemberProvider extends ChangeNotifier{
  Member? _currentMember;

  Member? get currenMember => _currentMember;

  void setCurrentMember(Member member){
    _currentMember = member;
    notifyListeners();
  }
}

Future<void> fetchdata(BuildContext context,String uid,String pin)async{

  DocumentSnapshot usersnap = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(uid).get();
  if (usersnap.exists){
    // do something
    (usersnap['pin'].toString() == pin) ? 
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardPage())):
    debugPrint('Wrong inputs');
  }
  else{
    debugPrint('incorrect values');
  }
}