import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
   
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0D47A1), 
                  const Color(0xFF121212), 
                  const Color(0xFF1E1E1E),
                ]
              : [
                  const Color(0xFF1565C0), 
                  const Color(0xFFF5F5F5), 
                  const Color(0xFFEEEEEE),
                ],
        ),
      ),
      child: child,
    );
  }
}
