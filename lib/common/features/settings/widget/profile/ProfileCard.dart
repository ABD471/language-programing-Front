import 'dart:io';
import 'package:apartment_rental_system/common/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget ProfileCard({
  required ThemeData theme,
  required File? profileImageFile,
  required void Function(bool isprofile) onTap,
  required Profile profileData,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(15.sp),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 45.sp,
              backgroundColor: theme.colorScheme.surface,
              backgroundImage: profileImageFile != null
                  ? FileImage(profileImageFile)
                  : (profileData.profileImageBytes != null
                        ? MemoryImage(profileData.profileImageBytes!)
                        : null),
              child:
                  profileImageFile == null &&
                      profileData.profileImageBytes == null
                  ? Icon(
                      Icons.person,
                      size: 40.sp,
                      color: theme.colorScheme.primary,
                    )
                  : null,
            ),
            Positioned(
              right: 2.w,
              bottom: 0,
              child: GestureDetector(
                onTap: () => onTap(true),
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
                    size: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        Text(
          "${profileData.firstName} ${profileData.lastName}",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 18.sp,
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
