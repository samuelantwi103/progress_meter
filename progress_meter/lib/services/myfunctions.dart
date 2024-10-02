// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_meter/pages/admin/admin_home.dart';
import 'package:progress_meter/pages/user/user_home.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/transitions.dart';
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

  // final docToCheck = await FirebaseFirestore.instance.collection('organisations')
  // .doc(getFirstThreeLetters(code))
  // .collection('members').doc(code)
  // .collection('months').doc(monthdoc).get();
  final docToCheck = await FirebaseFirestore.instance.collection('organisations')
  .doc(getFirstThreeLetters(code))
  .collection('members').doc(code).collection('months').doc(monthdoc)
  .get();

  debugPrint('member assigned doc exist : ${docToCheck.exists}');

  final usersnap = await FirebaseFirestore.instance.collection('organisations')
  .doc(getFirstThreeLetters(code)).collection('members').doc(code)
  .collection('months').doc(monthdoc).collection('assigned').get();
  if (usersnap.docs.isNotEmpty){
    // do something
      

      assigned.memberAssignedtasks = usersnap.docs.where((doc) => doc.id != 'default')
      .map((doc){return doc.data();}).toList();
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

  final docToCheck = await FirebaseFirestore.instance.collection('organisations')
  .doc(getFirstThreeLetters(code))
  .collection('members').doc(code)
  .collection('months').doc(monthdoc).get();

  debugPrint('member doc exist value: ${docToCheck.exists}');

  if(docToCheck.exists){

    final usersnap = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(code))
      .collection('members').doc(code).collection('months').doc(monthdoc).collection('notassigned').get();
       debugPrint('member doc size: ${usersnap.size}');
      if (usersnap.docs.isNotEmpty){
        // do something
        
          debugPrint('Before inside function check: ${notAssigned.memberSelftasks}');
          notAssigned.memberSelftasks = usersnap.docs.where((doc) => doc.id != 'default').map((doc){return doc.data();}).toList();
          debugPrint('inside function check: ${notAssigned.memberSelftasks}');
              
        
      }
      else{
        debugPrint('incorrect values');
    //return notAssigned;
    }
  }
  else{
    // Create the month document with the "newMonth" field
    await FirebaseFirestore.instance
        .collection('organisations')
        .doc(getFirstThreeLetters(code))
        .collection('members')
        .doc(code)
        .collection('months')
        .doc(monthdoc)
        .set({
          'newMonth': monthdoc, // Add the newMonth field
        });
        
    await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(code))
      .collection('members').doc(code)
      .collection('months').doc(monthdoc)
      .collection('notassigned').doc('default').set({'name': 'default'});

    await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(code))
      .collection('members').doc(code)
      .collection('months').doc(monthdoc)
      .collection('assigned').doc('default').set({'name': 'default'});

  }  
  
}



Future<void> submitStandUp(String title, String description,String challenges, String memberId,SelfTasksProvider selfPro) async{
  final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final doc = await FirebaseFirestore.instance.collection('organisations')
  .doc(getFirstThreeLetters(memberId)).collection('members').doc(memberId).collection('months').doc(monthdoc)
  .collection('notassigned').doc(docId).get();
  

  (doc.exists) ?
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId).collection('months').doc(monthdoc).collection('notassigned').doc(docId).update({
    'title': title,
    'description': description,
    'challenges': challenges,
    'time': DateTime.now().toString()
  }) : 
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc).collection('notassigned').doc(docId).set({
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
  final completedDate = DateTime.now().toString();


    final assignedCollection = FirebaseFirestore.instance.collection('organisations')
      .doc(getFirstThreeLetters(memberId))
      .collection('members')
      .doc(memberId)
      .collection('months')
      .doc(monthdoc)
      .collection('assigned');
    
    final assignedDocs = await assignedCollection.get();
    if(assignedDocs.docs.isNotEmpty){

        final docToUpdate = assignedDocs.docs.firstWhere(

              (doc) => doc['taskId'] == taskId,
              // Ensure no error if no doc is found
            );
          //await assignedCollection.doc(docToDelete.id).delete();
        final reports = await FirebaseFirestore.instance.collection('organisations')
            .doc(getFirstThreeLetters(memberId))
            .collection('members')
            .doc(memberId)
            .collection('months')
            .doc(monthdoc)
            .collection('assigned')
            .doc(docToUpdate.id)
            .collection('reports')
            .get();

        int reportNum = reports.size;
        await FirebaseFirestore.instance.collection('organisations')
              .doc(getFirstThreeLetters(memberId))
              .collection('members')
              .doc(memberId)
              .collection('months')
              .doc(monthdoc)
              .collection('assigned')
              .doc(docToUpdate.id)
              .update({
                'status': 'Completed',
                'reportsize': reportNum,
                'datecompleted': completedDate
              });

          await FirebaseFirestore.instance.collection('organisations')
              .doc(getFirstThreeLetters(memberId))
              .collection('tasks')
              .doc(taskId)
              .update({
                'status': 'Completed',
                'datecompleted': completedDate
              });
        
        final reportscore = (dayNum != 0) ? rawScore + ((reportNum)/dayNum)*50 : rawScore + 50;
        member.updateData(reportscore);
        
        AssignedTasks assignedTasks = AssignedTasks();
        await fetchAssignedTasks(assignedTasks, memberId);
        
        assPro.setCurrentAssignedTasks(assignedTasks);
        memPro.setCurrentMember(member);
  }
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

  // Define the format for the month, day, hour, minute, and second
  String month = DateFormat('MMMM').format(now).toLowerCase(); // Full month name in lowercase
  String day = DateFormat('d').format(now); // Day of the month
  String hour = DateFormat('HH').format(now); // Hour in 24-hour format
  String minute = DateFormat('mm').format(now); // Minutes
  String second = DateFormat('ss').format(now); // Seconds

  // Combine month, day, hour, minute, and second into the desired format
  String monthDayHourMinuteSecond = '$month$day$hour$minute$second';

  return monthDayHourMinuteSecond;
}

String getReportId() {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Define the format for the month, day, hour, minute, and second
  String month = DateFormat('MMMM').format(now).toLowerCase(); // Full month name in lowercase
  String day = DateFormat('d').format(now); // Day of the month


  // Combine month, day, hour, minute, and second into the desired format
  String monthDayHourMinuteSecond = '$month$day';

  return monthDayHourMinuteSecond;
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
  final docId = getReportId();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final assignedDocs = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId).collection('months').doc(monthdoc).collection('assigned').get();
  final docsignature = assignedDocs.docs.firstWhere((doc) => doc['taskId'] == taskId);

  final doc = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docsignature.id)
  .collection('reports').doc(docId).get();
  (doc.exists) ?
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docsignature.id)
  .collection('reports').doc(docId).update({
    'report': reportText,
    'date': DateTime.now().toString()
  }) : 
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docsignature.id)
  .collection('reports').doc(docId).set({
    'report': reportText,
    'date': DateTime.now().toString()
  });



  // submitting same report at admin end:

  final doc1 = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('tasks').doc(taskId)
  .collection('reports').doc(docId).get();
  (doc1.exists) ?
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('tasks').doc(taskId)
  .collection('reports').doc(docId).update({
    'report': reportText,
    'date': DateTime.now().toString()
  }) : 
  await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('tasks').doc(taskId)
  .collection('reports').doc(docId).set({
    'report': reportText,
    'date': DateTime.now().toString()
  });



  AssignedTasks assigned = AssignedTasks();
  await fetchAssignedTasks(assigned, memberId);
  assignPro.setCurrentAssignedTasks(assigned);

}


//=====================================

Future<void> assignTaskToMember(Map<String,dynamic> selectedMember,Map<String,dynamic> taskId, BuildContext context)async {
  final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());

  //Setting task first before setting report field
  await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(selectedMember['uniquecode'])
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docId).set(taskId);

  //setting report field for this new assigned task
  await FirebaseFirestore.instance.collection('organisations').doc('son')
  .collection('members').doc(selectedMember['uniquecode'])
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docId).collection('reports').doc('default').set({'name': 'default'});
  
  

}

//========================================================

DateTime convertToDateTime(String dateString) {

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  return dateFormat.parse(dateString);
  
}


Future<List<Map<String,dynamic>>> fetchAllReports(String memberId,String taskId) async{
  //final docId = getCurrentMonthDay();
  final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final assignedDocs = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId).collection('months').doc(monthdoc).collection('assigned').get();
  final docsignature = assignedDocs.docs.firstWhere((doc) => doc['taskId'] == taskId);
  
  final doc = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(memberId))
  .collection('members').doc(memberId)
  .collection('months').doc(monthdoc)
  .collection('assigned').doc(docsignature.id)
  .collection('reports').get();
  List<Map<String,dynamic>> reports = doc.docs.where((doc) => doc.id != 'default').map((doc){return doc.data();}).toList();
  return reports;
}

Future<List<Map<String,dynamic>>> fetchAdminTaskReports(String adminId,String taskId) async{
  //final docId = getCurrentMonthDay();
  //final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
  final doc = await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(adminId))
  .collection('tasks').doc(taskId)
  .collection('reports').get();
  List<Map<String,dynamic>> reports = [];

  if (doc.docs.isNotEmpty){

    reports = doc.docs.where((doc) => doc.id != 'default').map((doc){return doc.data();}).toList();

  }
  
  return reports;
}



String getFirstThreeLetters(String input) {
  // Check if the input string has 3 or more characters
  if (input.length >= 3) {
    return input.substring(0, 3);  // Return the first 3 letters
  } else {
    return input;  // Return the string itself if it's less than 3 characters
  }
}



//=================================Functions related to admin

Future<bool> fetchAdminData( BuildContext context, String uid, String pin) async {
  bool state = false;
  final usersnap = FirebaseFirestore.instance
      .collection('organisations');

  final adminorg = await usersnap.where('uniquecode', isEqualTo: uid).get();

  if(adminorg.docs.isNotEmpty && adminorg.docs.first['pin'] == pin){
    Admin admin = Admin();
    admin.adminInfo = adminorg.docs.first.data();
    final employees = await  usersnap.doc(adminorg.docs.first.id).collection('members').get();
    admin.employees = employees.docs.where((doc) => doc.id != 'default').map((doc){return doc.data();}).toList();
    final tasks = await  usersnap.doc(adminorg.docs.first.id).collection('tasks').get();
    admin.tasks = tasks.docs.where((doc) => doc.id != 'default').map((doc){return doc.data();}).toList();
    Provider.of<AdminProvider>(context,listen:false).setCurrentAdmin(admin);
    state = true;
    
  }

  return state;
  
}

Future<void> createNewMember(String firstname,String middlename,String lastname,String uniquecode, int pin) async {

    try{


      await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(uniquecode))
            .collection('members').doc(uniquecode).set({
              'firstname': firstname,
              'lastname': lastname,
              'middlename': middlename,
              'pin': pin,
              'uniquecode': uniquecode,
              'personalperformance': 0,
              'overallperformance': 0,
              'completedscores': 0,
              'personal': "None",
              'overall': 'none',       
            });
      // creating assigned field of new member
      final monthdoc = convertDateTimeToLowercaseString(DateTime.now());
      await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(uniquecode))
          .collection('members').doc(uniquecode)
          .collection('months').doc(monthdoc).set({'newMonth': 'monthdoc'});

      await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(uniquecode))
          .collection('members').doc(uniquecode)
          .collection('months').doc(monthdoc)
          .collection('assigned').doc('default').set({
            'name': 'default',
            'taskId': 'taskId'
          });

      // creating not assigned field of new member
      await FirebaseFirestore.instance.collection('organisations').doc(getFirstThreeLetters(uniquecode))
          .collection('members').doc(uniquecode)
          .collection('months').doc(monthdoc)
          .collection('notassigned').doc('default').set({
            'name': 'default',
            'taskId': 'default'
          });
          
    }
    catch(e){
      debugPrint('Error creating new member: $e');
    }

}

//==================DELETING A MEMBER

Future<void> deleteMember(Map<String, dynamic> member) async {
  try{
    await FirebaseFirestore.instance.collection('organisations')
  .doc(getFirstThreeLetters(member['uniquecode']))
  .collection('members')
  .doc(member['uniquecode'])
  .delete();
  }
  catch(e){
    debugPrint('Error deleting member: $e');
  }
  
}

String convertDateTimeToCompactString(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');
  
  return '${day}_${month}_${year}_${hour}_${minute}';
}
