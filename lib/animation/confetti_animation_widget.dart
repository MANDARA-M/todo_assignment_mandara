import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../navigation/navigation_utils.dart';

class ConfettiAnimationWidget extends StatefulWidget {
  const ConfettiAnimationWidget({super.key});

  static void showConfetti({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: ConfettiAnimationWidget(),
        );
      },
    );
  }

  @override
  _ConfettiAnimationWidgetState createState() => _ConfettiAnimationWidgetState();
}

class _ConfettiAnimationWidgetState extends State<ConfettiAnimationWidget> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playConfetti();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirection: pi / 3,
      blastDirectionality: BlastDirectionality.explosive,
      //blastDirection: Random().nextDouble() * 2 * pi,
      // 90 degrees (downwards)
      maxBlastForce: 70,
      // set a lower max and min, to keep the effects contained
      minBlastForce: 20,
      emissionFrequency: 0.05,
      // how often it emits particles
      numberOfParticles: 70,
      // number of particles to emit
      gravity: 0.1,
      // particles fall faster
      colors: const [
        // custom colors for confetti
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple,
        Colors.yellow,
        Colors.red,
        Colors.white,
        Colors.brown,
        Colors.teal,
        Colors.cyan,
      ],
      //particleDrag: 0.05, // decrease particles speed
      // You can uncomment and use a custom path for particles:
      // particleDrag: 0.05,
      // createParticlePath: drawStar, // using a custom star shape
    );
  }

  void _playConfetti() {
    _confettiController.play();

    Timer(const Duration(seconds: 3), () {
      _confettiController.stop();
      NavigationUtils.instance.pop(context: context);
    });
  }
}
