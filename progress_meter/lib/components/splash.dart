import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';

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
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Text(
            //   "Progress Meter",
            //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 0.1 * MediaQuery.of(context).size.width,
            //       ),
            // ),

            // Image.asset("assets/progress_meter_full.svg"),

            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 0.3 * MediaQuery.of(context).size.height,
              child: Image.asset("assets/progress_meter.png"),
            ),
          ]),
        ),
      ),
      splashIconSize: 400,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      nextScreen: LoginPage(),
    );
  }
}
