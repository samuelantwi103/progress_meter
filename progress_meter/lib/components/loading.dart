import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> LoginLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: Lottie.asset(
          "assets/login_loading_anim.json",

        ),
        // insetAnimationCurve: Curves.bounceIn,
      );
    },
  );
}
