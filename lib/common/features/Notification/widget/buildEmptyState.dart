import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildEmptyState(ThemeData theme) {
  final isDark = theme.brightness == Brightness.dark;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(18.sp),
          decoration: BoxDecoration(
            color: isDark
                ? theme.colorScheme.primary.withOpacity(0.05)
                : theme.primaryColor.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_off_outlined,
            size: 45.sp,
            color: isDark
                ? theme.colorScheme.primary.withOpacity(0.3)
                : theme.hintColor.withOpacity(0.3),
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          "no_notifications".tr,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 14.sp,
            color: isDark ? Colors.white70 : theme.hintColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 1.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "notifications_empty_hint".tr,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 11.sp,
              color: theme.hintColor.withOpacity(0.5),
            ),
          ),
        ),
      ],
    ),
  );
}
