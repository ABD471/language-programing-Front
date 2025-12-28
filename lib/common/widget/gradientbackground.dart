import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // التحقق مما إذا كان النظام في الوضع الليلي
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0D47A1), // أزرق داكن جداً (Deep Blue)
                  const Color(0xFF121212), // أسود مطفي (Material Dark)
                  const Color(0xFF1E1E1E), // رمادي داكن جداً
                ]
              : [
                  const Color(0xFF1565C0), // أزرق (لونك الأصلي)
                  const Color(0xFFF5F5F5), // أبيض رمادي
                  const Color(0xFFEEEEEE), // رمادي أفتح
                ],
        ),
      ),
      child: child,
    );
  }
}
