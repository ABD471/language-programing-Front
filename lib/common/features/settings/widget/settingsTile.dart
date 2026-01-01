import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget settingsTile({
  required IconData icon,
  required String title,
  Color? color,
  Widget? trailing,
  required VoidCallback onTap,
}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;

      return Card(
        elevation: isDark ? 0 : 2,
        margin: EdgeInsets.only(bottom: 1.5.h),
        color: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
          side: isDark
              ? BorderSide(color: Colors.white10, width: 0.5)
              : BorderSide.none,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 0.5.h,
          ),
          leading: Container(
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
              color: (color ?? theme.colorScheme.primary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(
              icon,
              color: color ?? theme.colorScheme.primary,
              size: 18.sp,
            ),
          ),
          title: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing:
              trailing ??
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: theme.hintColor,
              ),
          onTap: onTap,
        ),
      );
    },
  );
}
