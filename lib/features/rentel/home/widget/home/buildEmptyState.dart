import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildEmptyState(ThemeData theme) {
  return RefreshIndicator(
    onRefresh: () => Future.value(),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_work_outlined,
            size: 120,
            color: theme.primaryColor.withOpacity(0.2),
          ),
          const SizedBox(height: 24),
          Text(
            "no_apartments_msg".tr,
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}
