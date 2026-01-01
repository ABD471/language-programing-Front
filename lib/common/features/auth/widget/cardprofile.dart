import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget EmptyProfileCard({
  required ThemeData theme,
  required File? profileImageFile,
  required void Function() onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(15.sp),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 45.sp,
                backgroundColor: theme.colorScheme.surface,
                backgroundImage: profileImageFile != null
                    ? FileImage(profileImageFile)
                    : null,
                child: profileImageFile == null
                    ? Icon(
                        Icons.person,
                        size: 40.sp,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      )
                    : null,
              ),
              Positioned(
                right: 2.w,
                bottom: 0,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: theme.colorScheme.onSecondary,
                      size: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          if (profileImageFile == null)
            Text(
              "add_profile_photo".tr,
              style: TextStyle(
                color: theme.colorScheme.onPrimary.withOpacity(0.9),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    ),
  );
}