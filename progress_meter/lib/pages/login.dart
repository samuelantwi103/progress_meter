// pages/login.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/pages/admin/admin_home.dart';
import 'package:progress_meter/services/callback.dart';
import 'package:progress_meter/services/myclasses.dart';
import 'package:progress_meter/services/myfunctions.dart';
import 'package:progress_meter/services/transitions.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _isPinVisible = false; // To toggle pin visibility
  bool _isCodeValid = false;

  // // Video Controller
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   _controller = VideoPlayerController.asset(
  //     "assets/smoke_anim.mp4",
  //   );
  //   _controller.play();

  //   _initializeVideoPlayerFuture = _controller.initialize();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/bg-image.jpg",
                fit: BoxFit.cover,
              ),
            ),
            // FutureBuilder(
            //     future: _initializeVideoPlayerFuture,
            //     builder: (context, snapshot) {
            //       return AspectRatio(
            //           aspectRatio: _controller.value.aspectRatio,
            //           child: VideoPlayer(_controller));
            //     }),
            Positioned(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: LottieBuilder.asset(
                    "assets/corner_anim.json",
                    // controller: CurvedAnimation(
                    //     parent: AnimationController(
                    //       vsync: this,
                    //     ),

                    //     curve: Curves.bounceInOut),
                    repeat: true,
                  )),
              right: -0.06 * MediaQuery.of(context).size.height,
              top: -0.06 * MediaQuery.of(context).size.height,
            ),
            Positioned(
              child: RotatedBox(
                quarterTurns: 2,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 0.2 * MediaQuery.of(context).size.height,
                    // height: 0.0 * MediaQuery.of(context).size.height,
                    child: LottieBuilder.asset(
                      "assets/corner_anim.json",
                      // frameRate: FrameRate(320),
                      // controller: CurvedAnimation(
                      //     parent: AnimationController(
                      //       vsync: this,
                      //     ),

                      //     curve: Curves.bounceInOut),
                      repeat: true,
                    )),
              ),
              left: MediaQuery.of(context).size.aspectRatio > 0.6
                  ? -0.65 * MediaQuery.of(context).size.height
                  : -0.06 * MediaQuery.of(context).size.height,
              bottom: -0.06 * MediaQuery.of(context).size.height,
            ),
            Center(
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
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: 0.3 * MediaQuery.of(context).size.height,
                            child:
                                Image.asset("assets/progress_meter_named.png"),
                          ),

                          // // Login text
                          // Text(
                          //   "Login",
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headlineMedium
                          //       ?.copyWith(
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          // ),

                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _codeController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            onChanged: (value) =>
                                formatLoginCode(_codeController),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _pinController,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            obscureText: !_isPinVisible,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                              return null;
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
                                if (await fetchAdminData(context, code, pin)) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      createSlideScaleTransition(
                                          AdminHomePage(),
                                          duration:
                                              Duration(milliseconds: 1000)));
                                } else if (await fetchdata(
                                    context, code, pin)) {
                                  await fetchAssignedTasks(assigned, code,
                                      pin: pin);
                                  await fetchSelfTasks(selfTasks, code,
                                      pin: pin);
                                  assPro.setCurrentAssignedTasks(assigned);
                                  selfPro.setCurrentSelfTaks(selfTasks);
                                }
                              }
                            },
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
