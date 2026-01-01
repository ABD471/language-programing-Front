import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildImageThumbnail({
  required int index,
  required dynamic imageData,
  required VoidCallback onRemove,
}) {
  final bool isNetwork = imageData is String && imageData.startsWith('http');

  return Container(
    margin: EdgeInsets.all(1.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.w),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2.w,
          offset: Offset(0, 0.5.h),
        ),
      ],
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.w),
          child: isNetwork
              ? Image.network(
                  imageData,
                  width: 25.w,
                  height: 25.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 25.w,
                      height: 25.w,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 0.5.w),
                      ),
                    );
                  },
                )
              : Image.file(
                  imageData as File,
                  width: 25.w,
                  height: 25.w,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          top: 1.h,
          right: 2.w,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 14.sp,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
