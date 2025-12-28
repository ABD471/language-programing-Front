import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildEmptyState(ThemeData theme) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_none,
          size: 60.sp,
          color: theme.hintColor.withOpacity(0.3),
        ),
        SizedBox(height: 2.h),
        Text(
          "no_notifications".tr,
          style: theme.textTheme.titleMedium?.copyWith(color: theme.hintColor),
        ),
      ],
    ),
  );
}
