import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildAnimatedActionBtn({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.w),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
    ),
  );
}
