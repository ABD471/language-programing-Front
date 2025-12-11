import 'dart:io';
import 'package:flutter/material.dart';

Widget EmptyProfileCard({
  required ThemeData theme,
  required File? profileImageFile,
  required void Function() onTap,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
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
                  : null,
              child: profileImageFile == null
                  ? Icon(
                      Icons.person,
                      size: 50,
                      color: theme.colorScheme.onSurface,
                    )
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
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
      ],
    ),
  );
}
