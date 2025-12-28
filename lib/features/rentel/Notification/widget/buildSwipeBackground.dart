import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildSwipeBackground({
  required Color color,
  required IconData icon,
  required Alignment alignment,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    alignment: alignment,
    decoration: BoxDecoration(
      color: color.withOpacity(0.8),
      borderRadius: BorderRadius.circular(15.sp),
    ),
    child: Icon(icon, color: Colors.white, size: 24.sp),
  );
}
