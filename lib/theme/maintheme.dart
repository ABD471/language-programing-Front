import 'package:flutter/material.dart';

// ------------------- الألوان والسمات (Theming) -------------------
class AppTheme {
  static const Color primary = Color(0xFF1565C0); // أزرق ملكي
  static const Color secondary = Color(0xFFFFCA28); // أصفر كهرماني
  static const Color background = Color(0xFFF5F7FA); // رمادي فاتح جداً للخلفية
  static const Color textDark = Color(0xFF263238);
  static const Color textLight = Color(0xFF78909C);

  static ThemeData get theme => ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Segoe UI', // خط افتراضي جميل، يمكن تغييره
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primary,
      secondary: secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
      ),
    ),
  );
}
