import 'package:flutter/material.dart';

Widget buildOtpField({
  required int index,
  required List<TextEditingController> controllers,
  required List<FocusNode> focusNodes,
  required void Function(String)? onChanged,
}) {
  return SizedBox(
    width: 52,
    child: Directionality(
      textDirection: TextDirection.ltr, // 👈 Force Left-To-Right
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
