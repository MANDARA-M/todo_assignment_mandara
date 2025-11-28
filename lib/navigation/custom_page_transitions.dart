import 'package:flutter/material.dart';

class CustomPageTransitions {
  /// Creates a page route that slides in from the right bottom corner
  static PageRouteBuilder slideFromRightBottom({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 800),
    Duration reverseTransitionDuration = const Duration(milliseconds: 600),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Create a custom transition from right bottom corner
        const begin = Offset(1.0, 1.0); // Start from right bottom
        const end = Offset.zero; // End at center
        const curve = Curves.easeOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  /// Creates a page route that slides in from the left
  static PageRouteBuilder slideFromLeft({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 600),
    Duration reverseTransitionDuration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  /// Creates a page route that scales in from center
  static PageRouteBuilder scaleFromCenter({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 600),
    Duration reverseTransitionDuration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}
