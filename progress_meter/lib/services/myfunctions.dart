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

String formatDateString(String dateTimeString) {
  // Parse the input string to a DateTime object
  DateTime parsedDateTime = DateTime.parse(dateTimeString);

  // Format the DateTime object to "Month Day, Year" (e.g., "September 12, 2024")
  String formattedDate = DateFormat('MMMM d, yyyy').format(parsedDateTime);

  return formattedDate;
}

String convertDateTimeToLowercaseString(DateTime dateTime) {
  // Format the DateTime to "september2024"
  String formattedDate = DateFormat("MMMM yyyy").format(dateTime);

  // Convert it to lowercase and remove space between month and year
  return formattedDate.toLowerCase().replaceAll(' ', '');
}

Future<void> fetchAssignedTasks(AssignedTasks assigned, String code, {String? pin}) async {
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());

  final usersnap = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(code).collection('months').doc(monthdoc).collection('assigned').get();
  if (usersnap.docs.isNotEmpty){
    // do something
      

      assigned.memberAssignedtasks = usersnap.docs.where((doc) => doc.id != 'default').map((doc){return doc.data() as Map<String, dynamic>;}).toList();
      //return assigned;
      
      
    
  }
  else{
    debugPrint('incorrect values');
    //return assigned;
  }
  debugPrint('done checking assigned tasks');
}



//=======================================================

Future<void> fetchSelfTasks(SelfTasks notAssigned, String code, {String? pin}) async {
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());

  final usersnap = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(code).collection('months').doc(monthdoc).collection('notassigned').get();
  if (usersnap.docs.isNotEmpty){
    // do something
    

      notAssigned.memberSelftasks = usersnap.docs.where((doc) => doc.id != 'default').map((doc){return doc.data() as Map<String, dynamic>;}).toList();
      //Provider.of<SelfTasksProvider>(context,listen:false).setCurrentSelfTaks(notAssigned);
      //return notAssigned;
      
    
  }
  else{
    debugPrint('incorrect values');
    //return notAssigned;
  }
  debugPrint('done checking for self tasks');
}

Future<void> submitStandUp(String title, String description,String challenges, String memberId,SelfTasksProvider selfPro) async{
  final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final doc = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(memberId).collection('months').doc(monthdoc).collection('notassigned').doc(docId).get();
  (doc.exists) ?
  await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(memberId).collection('months').doc(monthdoc).collection('notassigned').doc(docId).update({
    'title': title,
    'description': description,
    'challenges': challenges,
    'time': DateTime.now().toString()
  }) : 
  await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(memberId).collection('months').doc(monthdoc).collection('notassigned').doc(docId).set({
    'title': title,
    'description': description,
    'challenges': challenges,
    'time': DateTime.now().toString()
  });
  SelfTasks notAssigned = SelfTasks();
  await fetchSelfTasks(notAssigned, memberId);
  selfPro.setCurrentSelfTaks(notAssigned);
}



int getDaysBetween(String startDateString, String endDateString) {
  // Parse the string dates into DateTime objects
  DateTime startDate = DateTime.parse(startDateString);
  DateTime endDate = DateTime.now();

  // Calculate the difference in days
  int daysDifference = endDate.difference(startDate).inDays;

  return daysDifference;
}


Future<void> markComplete(String taskId, String memberId, AssignedProvider assPro, Member member, double rawScore, int dayNum, MemberProvider memPro) async {
  //final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final reports = await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(memberId).collection('months').doc(monthdoc).collection('assigned').doc(taskId).collection('reports').get();
  int reportNum = reports.size;
  await FirebaseFirestore.instance.collection('organisations').doc('son').collection('members').doc(memberId).collection('months').doc(monthdoc).collection('assigned').doc(taskId).update({
    'status': 'Completed',
    'reportsize': reportNum
  });

  final reportscore = rawScore + ((reportNum)/dayNum);
  member.updateData(reportscore);
  
  AssignedTasks assignedTasks = AssignedTasks();
  await fetchAssignedTasks(assignedTasks, memberId);
  
  assPro.setCurrentAssignedTasks(assignedTasks);
  memPro.setCurrentMember(member);
}

//==================Evaluating difference in dates.

int calculateDateTimePercentage(String dateTimeStr1, String dateTimeStr2) {
  // Parse the input DateTime strings
  DateTime dateTime1 = DateTime.parse(dateTimeStr1);
  DateTime dateTime2 = DateTime.parse(dateTimeStr2);
  DateTime now = DateTime.now();  // Get the current date and time

  // Find the least and greatest DateTime
  DateTime leastDateTime = dateTime1.isBefore(dateTime2) ? dateTime1 : dateTime2;
  DateTime greatestDateTime = dateTime1.isAfter(dateTime2) ? dateTime1 : dateTime2;

  // Calculate the differences in minutes
  int diffBetweenDates = greatestDateTime.difference(leastDateTime).inMinutes;
  int diffBetweenLeastAndNow = now.difference(leastDateTime).inMinutes;

  // Handle the case where the difference might be zero to avoid division by zero
  if (now.difference(greatestDateTime).inMinutes >= 0) {
    return 100; // or handle it as needed (e.g., return a special value)
  }

  // Apply the formula to calculate the percentage
  double percentage = (diffBetweenLeastAndNow / diffBetweenDates) * 100;

  // Return the percentage as an integer by rounding
  return percentage.round();
}



// Function to get the current month and day in the format "monthday"
String getCurrentMonthDay() {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Define the format for the month and day
  String month = DateFormat('MMMM').format(now).toLowerCase(); // Full month name in lowercase
  String day = DateFormat('d').format(now); // Day of the month

  // Combine month and day into the desired format
  String monthDay = '$month$day';

  return monthDay;
}


int getDaysInCurrentMonth() {
  // Get the current date
  DateTime now = DateTime.now();

  // Create a DateTime object for the first day of the next month
  DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);

  // Subtract one day to get the last day of the current month
  DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));

  // Get the day of the month for the last day, which is the total number of days
  int totalDays = lastDayOfCurrentMonth.day;

  return totalDays;
}


//===============submit a report from a task

Future<void> submitReport(String memberId, String reportText,String taskId, AssignedProvider assignPro)async {
  final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final doc = await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(taskId)
  .collection('reports').doc(docId).get();
  (doc.exists) ?
  await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(taskId)
  .collection('reports').doc(docId).update({
    'report': reportText,
    'date': DateTime.now().toString()
  }) : 
  await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(taskId)
  .collection('reports').doc(docId).set({
    'report': reportText,
    'date': DateTime.now().toString()
  });
  AssignedTasks assigned = AssignedTasks();
  await fetchAssignedTasks(assigned, memberId);
  assignPro.setCurrentAssignedTasks(assigned);

}

Future<List<Map<String,dynamic>>> fetchAllReports(String memberId,String taskId) async{
  //final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final doc = await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(taskId)
  .collection('reports').get();
  List<Map<String,dynamic>> reports = doc.docs.where((doc) => doc.id != 'default').map((doc){return doc.data() as Map<String, dynamic>;}).toList();
  return reports;
}