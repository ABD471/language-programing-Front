import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class SplashCinematicAnimation extends StatefulWidget {
  const SplashCinematicAnimation({super.key});

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

  late String subtitle;
  String displayedText = "";

  @override
  void initState() {
    super.initState();
    subtitle = "splash_subtitle".tr;

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
      if (mounted) {
        setState(() {
          displayedText = subtitle.substring(0, count);
        });
      }
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onPanUpdate: (d) => _updateTilt(d, size),
      onPanEnd: (_) => setState(() {
        tiltX = 0;
        tiltY = 0;
      }),
      child: AnimatedBuilder(
        animation: _bgController,
        builder: (context, __) {
          final t = _bgController.value;

          final color1 = Color.lerp(
            isDark ? Colors.black : Colors.deepPurple.shade900,
            isDark ? Colors.indigo.shade900 : Colors.indigo.shade700,
            sin(t * pi),
          )!;
          final color2 = Color.lerp(
            isDark ? Colors.blueGrey.shade900 : Colors.blue.shade800,
            isDark ? Colors.black : Colors.deepPurple.shade700,
            cos(t * pi),
          )!;

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color1, color2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size.infinite,
                  painter: ParticlePainter(particles, t),
                ),
                Center(
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(tiltY)
                      ..rotateY(tiltX),
                    alignment: FractionalOffset.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (_, __) {
                            final scale = 0.95 + 0.1 * _logoController.value;
                            return Transform.scale(
                              scale: scale,
                              child: Icon(
                                Icons.apartment_rounded,
                                size: 50.sp,
                                color: const Color.fromARGB(255, 247, 223, 5),
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 20 * _logoController.value,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "app_name".tr,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          displayedText,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14.sp,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AnimatedBuilder(
                          animation: _loaderController,
                          builder: (_, __) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(3, (i) {
                                double anim =
                                    (_loaderController.value + i * 0.3) % 1;
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1.5.w,
                                  ),
                                  width: 2.5.w,
                                  height: 2.5.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(
                                      0.3 + 0.7 * anim,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      if (anim > 0.8)
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          blurRadius: 10,
                                        ),
                                    ],
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
              ],
            ),
          );
        },
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Offset> particles;
  final double animationValue;

  ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.2);
    for (var offset in particles) {
      double dy = (offset.dy - (animationValue * 0.1)) % 1.0;
      canvas.drawCircle(
        Offset(offset.dx * size.width, dy * size.height),
        1.5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
