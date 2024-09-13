import 'package:flutter/material.dart';

// Reusable transition function
Route createSlideScaleTransition(Widget page, {Duration duration = const Duration(milliseconds: 500)}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page; // The page you are navigating to
    },
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Starts from bottom
      const end = Offset.zero; // Ends at the center
      const curve = Curves.ease;

      var curveAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      // Combine slide and scale animations
      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: end,
        ).animate(curveAnimation),
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
  );
}
