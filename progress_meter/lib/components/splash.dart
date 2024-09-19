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
      splash: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text(
              "Progress Meter",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                
                fontSize: 50
              ),
            ),
            SizedBox(
              height: 0.3 * MediaQuery.of(context).size.height,
              child: LottieBuilder.asset("assets/general_loading.json"),
            ),
          ]),
        ),
      ),
      splashIconSize: 400,
      backgroundColor: Colors.orangeAccent.shade100,
      nextScreen: LoginPage(),
    );
  }
}
