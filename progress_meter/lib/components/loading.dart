import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> loginLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Lottie.asset(
          "assets/login_loading_anim.json",
        ),
        // insetAnimationCurve: Curves.bounceIn,
      );
    },
  );
}

Future<dynamic> generalLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Lottie.asset(
          "assets/general_loading.json",
        ),
        insetAnimationCurve: Curves.bounceIn,
      );
    },
  );
}
