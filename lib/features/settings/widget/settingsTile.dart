import 'package:flutter/material.dart';

Widget settingsTile(
  IconData icon,
  String title, {
  Color? color,
  required void Function() onTap,
}) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        onTap();
      },
    ),
  );
}
