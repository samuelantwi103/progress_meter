// pages/login.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/pages/admin/admin_home.dart';
import 'package:progress_meter/pages/user/user_home.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   super.initState();
  //   _codeController.addListener(() => formatLoginCode(_codeController));
  // }

  // @override
  // void dispose() {
  //   _codeController.removeListener(() => formatLoginCode(_codeController));
  //   _codeController.dispose();
  //   super.dispose();
  // }

  // Controllers to capture user input
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _isPinVisible = false; // To toggle pin visibility
  bool _isCodeValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Container(
              // height: 200,
              constraints: BoxConstraints(
                maxWidth: 500,
                minWidth: 300,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.airplay,
                      size: 100,
                    ),

                    // Login text
                    Text(
                      "Login",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),

                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _codeController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]$'))
                      // ],
                      maxLength: 8,
                      // textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: "Code",
                        hintText: "Enter your code",
                        prefixIcon: const Icon(Icons.vpn_key_outlined),
                        filled: true,

                        // fillColor: Theme.of(context).colorScheme.primaryContainer,
                        // prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        counter: const SizedBox(
                          height: 0,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) => formatLoginCode(_codeController),
                      validator: (value) {
                        // formatLoginCode(_codeController);
                        if (value == null || value.isEmpty) {
                          return "Enter your code";
                        }

                        if (!RegExp(r'[A-Za-z]{3}[A-Za-z0-9]{5}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid code: eg.sonss001';
                        }
                        if (value != null &&
                            value.isNotEmpty &&
                            !RegExp(r'[A-Za-z]{3}[A-Za-z0-9]{5}$')
                                .hasMatch(value)) {
                          setState(() {
                            _isCodeValid = false;
                          });
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      obscureText: !_isPinVisible,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          labelText: "PIN",
                          hintText: "Enter your PIN",
                          filled: true,
                          counter: const SizedBox(
                            height: 0,
                          ),

                          // fillColor: Theme.of(context).colorScheme.primaryContainer,
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPinVisible = !_isPinVisible;
                                });
                              },
                              icon: Icon(_isPinVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your PIN";
                        }
                        if (value.length != 4) {
                          return "PIN must be 4 digits";
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          loginLoading(context);
                          final code = _codeController.text.trim();
                          final pin = _pinController.text.trim();
                          // ScaffoldMessenger.of(context).showSnackBar(
                              // SnackBar(content: Text("Logging in...")));
                          // LoginLoading(context);
                          AssignedTasks assigned = AssignedTasks();
                          SelfTasks selfTasks = SelfTasks();
                          AssignedProvider assPro =
                              Provider.of<AssignedProvider>(context,
                                  listen: false);
                          SelfTasksProvider selfPro =
                              Provider.of<SelfTasksProvider>(context,
                                  listen: false);
                          await fetchdata(context, code, pin);
                          await fetchAssignedTasks(assigned, code, pin: pin);
                          await fetchSelfTasks(selfTasks, code, pin: pin);
                          assPro.setCurrentAssignedTasks(assigned);
                          selfPro.setCurrentSelfTaks(selfTasks);
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
