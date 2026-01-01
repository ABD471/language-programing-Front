import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildField({
  required TextEditingController controller,
  required String label,
  bool readOnly = false,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  final theme = Theme.of(context);

  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    onTap: onTap,
    validator: (v) => v!.isEmpty ? "field_required".tr : null,
    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: theme.textTheme.titleMedium?.copyWith(
        fontSize: 12.sp,
        color: theme.hintColor,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: theme.colorScheme.primary),
      ),
      filled: true,
      fillColor: theme.cardColor.withOpacity(0.5),
    ),
  );
}