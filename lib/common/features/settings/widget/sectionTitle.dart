import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget sectionTitle(String text) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);

      return Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: theme.brightness == Brightness.dark
                ? Colors.white70
                : Colors.black87,
          ),
        ),
      );
    },
  );
}
