import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget nationAidProfileWidget({
  required ThemeData theme,
  required File? nationalIdImageFile,
  required Future<dynamic> Function(bool isProfile) pickImage,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "national_id".tr,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 10),
      GestureDetector(
        onTap: () => pickImage(false),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
                        color: theme.iconTheme.color,
                        size: 42,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "upload_national_id".tr,
                        style: theme.textTheme.titleLarge,
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
