import 'package:apartment_rental_system/features/rentel/Notification/widget/buildSwipeBackground.dart';
import 'package:apartment_rental_system/features/rentel/Notification/widget/buildNotificationCard.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/buildEmptyState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// Imports
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/Notification/controller/notificationController.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomGlassAppBar(title: "notifications_title".tr),
      body: GradientBackground(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return buildEmptyState(theme);
          }

          return RefreshIndicator(
            onRefresh: () async => controller.fetchNotifications(),
            child: ListView.builder(
              padding: EdgeInsets.only(top: kToolbarHeight + 6.h, bottom: 2.h),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final item = controller.notifications[index];

                return Dismissible(
                  key: Key(item.id!),
                  direction: DismissDirection.horizontal,
                  background: buildSwipeBackground(
                    color: Colors.green,
                    icon: Icons.mark_email_read,
                    alignment: Alignment.centerRight,
                  ),
                  secondaryBackground: buildSwipeBackground(
                    color: Colors.redAccent,
                    icon: Icons.delete_sweep,
                    alignment: Alignment.centerLeft,
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      if (!item.isRead) controller.markAsRead(item.id!);
                      return false;
                    } else {
                      controller.deleteNotification(item.id!);
                      return true;
                    }
                  },
                  child: buildNotificationCard(
                    context,
                    item,
                    controller,
                    theme,
                    isDark,
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
