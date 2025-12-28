import 'dart:io';

import 'package:apartment_rental_system/common/model/profile.dart';
import 'package:flutter/material.dart';

Widget ProfileCard({
  required ThemeData theme,
  required File? profileImageFile,
  required void Function(bool isprofile) onTap,
  required Profile profileData,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: theme.colorScheme.surface,
              backgroundImage: profileImageFile != null
                  ? FileImage(profileImageFile)
                  : (profileData.profileImageBytes != null
                        ? MemoryImage(profileData.profileImageBytes!)
                        : null),
              child:
                  profileImageFile == null &&
                      profileData.profileImageBytes == null
                  ? Icon(Icons.person, size: 50)
                  : null,
            ),

            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  onTap(true);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: theme.colorScheme.onSecondary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),
        Text(
          "${profileData.firstName} ${profileData.lastName}",
          style: theme.textTheme.headlineMedium,
        ),
      ],
    ),
  );
}
