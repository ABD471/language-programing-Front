import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildEmptyState(ThemeData theme) {
  return RefreshIndicator(
    onRefresh: () => Future.value(),
    child: ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 25.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_work_outlined,
                size: 35.w,
                color: theme.primaryColor.withOpacity(0.2),
              ),
              SizedBox(height: 3.h),
              Text(
                "no_apartments_msg".tr,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
