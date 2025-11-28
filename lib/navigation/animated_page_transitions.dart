import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom page transitions for the app
class AnimatedPageTransitions {
  static const Duration _defaultDuration = Duration(milliseconds: 300);
  static const Curve _defaultCurve = Curves.easeInOut;

  /// Slide from right animation
  static PageRouteBuilder<T> slideFromRight<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Slide from left animation
  static PageRouteBuilder<T> slideFromLeft<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Slide from bottom animation
  static PageRouteBuilder<T> slideFromBottom<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Fade animation
  static PageRouteBuilder<T> fade<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Scale animation
  static PageRouteBuilder<T> scale<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Rotation animation
  static PageRouteBuilder<T> rotate<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Custom elastic animation
  static PageRouteBuilder<T> elastic<T>({
    required Widget child,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.elasticOut,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: curve,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Custom bounce animation
  static PageRouteBuilder<T> bounce<T>({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.bounceOut,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: curve,
          )),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Custom slide and fade combined animation
  static PageRouteBuilder<T> slideAndFade<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Custom zoom animation
  static PageRouteBuilder<T> zoom<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Custom flip animation
  static PageRouteBuilder<T> flip<T>({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value * 3.14159),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}

/// Custom route builder for GoRouter with animations
class AnimatedRouteBuilder {
  static GoRoute buildAnimatedRoute({
    required String name,
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    PageRouteBuilder<dynamic> Function(Widget) transitionBuilder = _defaultTransition,
  }) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) {
        final child = builder(context, state);
        return CustomTransitionPage(
          key: state.pageKey,
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return transitionBuilder(child).transitionsBuilder(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          },
        );
      },
    );
  }

  static PageRouteBuilder<dynamic> _defaultTransition(Widget child) {
    return AnimatedPageTransitions.slideFromRight(child: child);
  }
}

/// Animation types for different screens
enum AnimationType {
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  fade,
  scale,
  rotate,
  slideAndFade,
  zoom,
  flip,
  elastic,
  bounce,
}

/// Extension to get transition builder from animation type
extension AnimationTypeExtension on AnimationType {
  PageRouteBuilder<dynamic> Function(Widget) get transitionBuilder {
    switch (this) {
      case AnimationType.slideFromRight:
        return (child) => AnimatedPageTransitions.slideFromRight(child: child);
      case AnimationType.slideFromLeft:
        return (child) => AnimatedPageTransitions.slideFromLeft(child: child);
      case AnimationType.slideFromBottom:
        return (child) => AnimatedPageTransitions.slideFromBottom(child: child);
      case AnimationType.fade:
        return (child) => AnimatedPageTransitions.fade(child: child);
      case AnimationType.scale:
        return (child) => AnimatedPageTransitions.scale(child: child);
      case AnimationType.rotate:
        return (child) => AnimatedPageTransitions.rotate(child: child);
      case AnimationType.slideAndFade:
        return (child) => AnimatedPageTransitions.slideAndFade(child: child);
      case AnimationType.zoom:
        return (child) => AnimatedPageTransitions.zoom(child: child);
      case AnimationType.flip:
        return (child) => AnimatedPageTransitions.flip(child: child);
      case AnimationType.elastic:
        return (child) => AnimatedPageTransitions.elastic(child: child);
      case AnimationType.bounce:
        return (child) => AnimatedPageTransitions.bounce(child: child);
    }
  }
}
