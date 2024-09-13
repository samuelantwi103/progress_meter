import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_meter/pages/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [
        Center(
          child: LottieBuilder.asset("assets/login_loading_anim.json"),
        ),
      ]),
      splashIconSize: 400,
      backgroundColor: Colors.orangeAccent,
      nextScreen: LoginPage(),
    );
  }
}
