import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> loginLoading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Lottie.asset(
          "assets/login_loading_anim.json",
          animate: true,
        ),
        // insetAnimationCurve: Curves.bounceIn,
      );
    },
  );
}

Future<dynamic> generalLoading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Lottie.asset(
          "assets/general_loading.json",
          animate: true,
          
        ),
        // insetAnimationCurve: Curves.bounceIn,
      );
    },
  );
}
