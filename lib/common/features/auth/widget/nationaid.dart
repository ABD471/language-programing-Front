import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget nationAidProfileWidget({
  required ThemeData theme,
  required File? nationalIdImageFile,
  required Future<dynamic> Function(bool isProfile) pickImage,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "national_id".tr,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
      SizedBox(height: 1.5.h),
      GestureDetector(
        onTap: () => pickImage(false),
        child: Container(
          height: 22.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: theme.colorScheme.surface.withOpacity(0.6),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.2,
            ),
            image: nationalIdImageFile != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(nationalIdImageFile),
                  )
                : null,
          ),
          child: nationalIdImageFile == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        color: isDark
                            ? theme.colorScheme.primary
                            : theme.iconTheme.color,
                        size: 32.sp,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "upload_national_id".tr,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    ],
  );
}
