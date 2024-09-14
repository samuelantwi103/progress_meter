// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:provider/provider.dart';

String convertDateTimeToString(DateTime dateTime) {
  // Define the desired format
  DateFormat format = DateFormat("MMMM d, yyyy");

  // Format the DateTime object to a string
  String formattedDate = format.format(dateTime);

  return formattedDate;
}

String convertDateTimeToLowercaseString(DateTime dateTime) {
  // Format the DateTime to "september2024"
  String formattedDate = DateFormat("MMMM yyyy").format(dateTime);

  // Convert it to lowercase and remove space between month and year
  return formattedDate.toLowerCase().replaceAll(' ', '');
}

Future<void> fetchAssignedTasks(AssignedTasks assigned, String code, String pin,BuildContext context) async {
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());

  final usersnap = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(code).collection('months').doc(monthdoc).collection('assigned').get();
  if (usersnap.docs.isNotEmpty){
    // do something
    

      assigned.memberAssignedtasks = usersnap.docs.where((doc) => doc.id != 'default').map((doc){return doc.data() as Map<String, dynamic>;}).toList();
      Provider.of<AssignedProvider>(context,listen:false).setCurrentAssignedTasks(assigned);
      
    
  }
  else{
    debugPrint('incorrect values');
  }
}
