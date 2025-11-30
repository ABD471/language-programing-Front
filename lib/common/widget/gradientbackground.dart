import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1565C0), // أصفر فاتح
            Color(0xFFF5F5F5), // أبيض رمادي
            Color(0xFFEEEEEE), // رمادي أفتح
          ],
        ),
      ),
      child: child,
    );
  }
}
