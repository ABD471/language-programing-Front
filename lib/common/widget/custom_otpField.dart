import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildOtpField({
  required int index,
  required List<TextEditingController> controllers,
  required List<FocusNode> focusNodes,
  required void Function(String)? onChanged,
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return SizedBox(
 
    width: 11.w,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 17.sp, 
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : theme.primaryColorDark,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.9),
       
          contentPadding: EdgeInsets.symmetric(vertical: 1.2.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), 
            borderSide: BorderSide(
              color: isDark ? Colors.white24 : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDark ? theme.colorScheme.primary : theme.primaryColor,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < controllers.length - 1) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
          onChanged?.call(value);
        },
      ),
    ),
  );
}
