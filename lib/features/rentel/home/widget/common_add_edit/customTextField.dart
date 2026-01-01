import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 2.w,
              offset: Offset(0, 0.5.h),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: isDark
                ? Colors.white.withOpacity(0.9)
                : theme.primaryColor.withOpacity(0.9),
          ),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: theme.primaryColor.withOpacity(0.6),
                    size: 20.sp,
                  )
                : null,
            labelStyle: theme.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? Colors.white54
                  : theme.primaryColor.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            filled: true,
            fillColor: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.white.withOpacity(0.9),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: theme.primaryColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
