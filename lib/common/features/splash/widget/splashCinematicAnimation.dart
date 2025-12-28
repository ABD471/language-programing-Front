import 'dart:math';

import 'package:flutter/material.dart';

class SplashCinematicAnimation extends StatefulWidget {
  const SplashCinematicAnimation();

  @override
  State<SplashCinematicAnimation> createState() =>
      SplashCinematicAnimationState();
}

class SplashCinematicAnimationState extends State<SplashCinematicAnimation>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _logoController;
  late AnimationController _loaderController;
  late AnimationController _typingController;

  final int particleCount = 30;
  final List<Offset> particles = [];

  double tiltX = 0;
  double tiltY = 0;

  String subtitle = "Find your perfect home";
  String displayedText = "";

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < particleCount; i++) {
      particles.add(Offset(Random().nextDouble(), Random().nextDouble()));
    }

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();

    _typingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: subtitle.length * 100),
    );

    _typingController.addListener(() {
      int count = (_typingController.value * subtitle.length).round();
      if (count > subtitle.length) count = subtitle.length;
      setState(() {
        displayedText = subtitle.substring(0, count);
      });
    });

    _typingController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _loaderController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  void _updateTilt(DragUpdateDetails details, Size size) {
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    setState(() {
      tiltX = (dx - size.width / 2) / (size.width / 2) * 0.15;
      tiltY = (dy - size.height / 2) / (size.height / 2) * -0.15;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanUpdate: (d) => _updateTilt(d, size),
      child: AnimatedBuilder(
        animation: _bgController,
        builder: (_, __) {
          final t = _bgController.value;

          final color1 = Color.lerp(
            Colors.deepPurple,
            Colors.blueAccent,
            sin(t * pi),
          )!;
          final color2 = Color.lerp(
            Colors.pinkAccent,
            Colors.indigoAccent,
            cos(t * pi),
          )!;

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (_, __) {
                        final scale = 0.9 + 0.15 * _logoController.value;
                        return Transform.scale(
                          scale: scale,
                          child: const Icon(
                            Icons.apartment,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Dream House",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayedText,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 40),
                    AnimatedBuilder(
                      animation: _loaderController,
                      builder: (_, __) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (i) {
                            double anim =
                                (_loaderController.value + i * 0.3) % 1;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.3 + 0.7 * anim,
                                ),
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
