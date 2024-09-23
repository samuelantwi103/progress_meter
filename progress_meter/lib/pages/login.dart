// pages/login.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_meter/components/loading.dart';
import 'package:progress_meter/pages/admin/admin_home.dart';
import 'package:progress_meter/pages/user/user_home.dart';
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

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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

  // Fade In Animation
  late Animation<double> logoFadeAnimation;
  late Animation<Offset> formSlideAnimation;
  late AnimationController animationController;
  late AnimationController fastAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fastAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    fastAnimationController.forward();
    fastAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          fastAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fastAnimationController.forward();
        }
      },
    );

    fastAnimationController.repeat();
    // fastAnimationController.duration = Duration(seconds: 2);
    logoFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    formSlideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(animationController);

    fastAnimationController.forward();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    fastAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: FadeTransition(
          opacity: logoFadeAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/bg-image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Lottie.asset(
                      'assets/corner_anim.json',
                      controller: fastAnimationController,
                      repeat: false,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // Bottom-left Lottie animation (Rotated, no padding)
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Lottie.asset(
                        'assets/corner_anim.json',
                        controller: fastAnimationController,
                        repeat: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
                                height:
                                    0.3 * MediaQuery.of(context).size.height,
                                child: Image.asset(
                                    "assets/progress_meter_named.png"),
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _codeController,
                                onTapOutside:  (event) => FocusScope.of(context).unfocus(),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 8,
                                decoration: InputDecoration(
                                  labelText: "Code",
                                  hintText: "Enter your code",
                                  prefixIcon:
                                      const Icon(Icons.vpn_key_outlined),
                                  filled: true,
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
                                  if (value == null || value.isEmpty) {
                                    return "Enter your code";
                                  }

                                  if (!RegExp(r'[A-Za-z]{3}[A-Za-z0-9]{5}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid code: eg.sonss001';
                                  }
                                  if (value.isNotEmpty &&
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
                                onTapOutside:  (event) => FocusScope.of(context).unfocus(),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _pinController,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: false,
                                ),
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
                                    SelfTasksProvider selfPro = Provider.of<SelfTasksProvider>(context,
                                            listen: false);
                                    if (await fetchAdminData(
                                        context, code, pin)) {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          createSlideScaleTransition(
                                              AdminHomePage(),
                                              duration: Duration(
                                                  milliseconds: 1000)));
                                    } else if (await fetchdata(
                                        context, code, pin)) {
                                          await fetchSelfTasks(selfTasks, code,pin: pin);
                                          await fetchAssignedTasks(assigned, code,
                                          pin: pin);
                                      Navigator.pop(context);

                                      Navigator.pushReplacement(

                                          context, createSlideScaleTransition(HomePage()));
                                      
                                      
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
        ));
  }
}
