import 'package:flutter/material.dart';

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
    validator: (v) => v!.isEmpty ? "Required field" : null,
    style: theme.textTheme.bodyLarge,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: theme.textTheme.titleMedium,
    ),
  );
}
