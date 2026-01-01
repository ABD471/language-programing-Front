import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildSwipeBackground({
  required Color color,
  required IconData icon,
  required Alignment alignment,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    alignment: alignment,
    decoration: BoxDecoration(
      color: color.withOpacity(0.9),
      borderRadius: BorderRadius.circular(12.sp),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Icon(icon, color: Colors.white, size: 22.sp),
  );
}
