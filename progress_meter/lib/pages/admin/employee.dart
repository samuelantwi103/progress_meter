import 'package:flutter/material.dart';
import 'package:progress_meter/components/card.dart';
import 'package:progress_meter/components/empty_screen.dart';
import 'package:progress_meter/components/form.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  int taskLength = 0;

  final List<Map<String, dynamic>> employees = [];

  @override
  Widget build(BuildContext context) {
    final admin =
        Provider.of<AdminProvider>(context, listen: true).currenMember!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: admin.employees!.length,
                  itemBuilder: (context, index) {
                    return adminTaskIndicator(admin.employees![index], context);
                  },
                ),
                if (admin.employees!.isEmpty) EmptyEmployeeScreen(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callDialog(
              context: context,
              content: AddEmployeeForm(
                formKey: _formKey,
                fnameController: fnameController,
                lnameController: lnameController,
                mnameController: mnameController,
                codeController: codeController,
                pinController: pinController,
              ),
              title: "Add an employee",
              onConfirm: () async {
                if (_formKey.currentState!.validate()) {
                  generalLoading(context);
                  // creating the new member
                  await createNewMember(
                      fnameController.text.trim(),
                      mnameController.text.trim(),
                      lnameController.text.trim(),
                      codeController.text.trim(),
                      int.parse(pinController.text.trim()));

                  await fetchAdminData(context, admin.adminInfo!['uniquecode'],
                      admin.adminInfo!['pin']);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(codeController.text)),
                  );
                  codeController.clear();
                  fnameController.clear();
                  lnameController.clear();
                  mnameController.clear();
                  pinController.clear();
                  _formKey.currentState!.reset();
                  Navigator.pop(context); // Close dialog on success
                  Navigator.pop(context); // Close dialog on success
                }
              });
        },
        // label: Text("Add Task"),
        child: Icon(Icons.person_add_alt),
      ),
    );
  }
}
