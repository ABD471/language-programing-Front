import 'package:flutter/material.dart';

Widget buildOtpField({
  required int index,
  required List<TextEditingController> controllers,
  required List<FocusNode> focusNodes,
  required void Function(String)? onChanged,
}) {
  return SizedBox(
    width: 48,
    child: TextField(
      controller: controllers[index],
      focusNode: focusNodes[index],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty && index < controllers.length - 1) {
          // الانتقال تلقائي للخانة التالية
          focusNodes[index + 1].requestFocus();
        } else if (value.isEmpty && index > 0) {
          // العودة للخانة السابقة عند الحذف
          focusNodes[index - 1].requestFocus();
        }
        onChanged?.call(value);
      },
    ),
  );
}
