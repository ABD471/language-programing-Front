import 'package:apartment_rental_system/common/features/Notification/widget/buildSwipeBackground.dart';
import 'package:apartment_rental_system/common/features/Notification/widget/buildNotificationCard.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/buildEmptyState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/Notification/controller/notificationController.dart';
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
            return Center(
              child: CircularProgressIndicator(
                color: isDark ? theme.colorScheme.primary : theme.primaryColor,
              ),
            );
          }

          if (controller.notifications.isEmpty) {
            return buildEmptyState(theme);
          }

          return RefreshIndicator(
            onRefresh: () async => controller.fetchNotifications(),
            color: theme.primaryColor,
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: kToolbarHeight + 8.h,
                bottom: 2.h,
                left: 3.w,
                right: 3.w,
              ),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final item = controller.notifications[index];

                return Dismissible(
                  key: Key(item.id!),
                  direction: DismissDirection.horizontal,
                  background: buildSwipeBackground(
                    color: Colors.green.withOpacity(0.8),
                    icon: Icons.mark_email_read_rounded,
                    alignment: Alignment.centerLeft,
                  ),
                  secondaryBackground: buildSwipeBackground(
                    color: Colors.redAccent.withOpacity(0.8),
                    icon: Icons.delete_sweep_rounded,
                    alignment: Alignment.centerRight,
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: buildNotificationCard(
                      context,
                      item,
                      controller,
                      theme,
                      isDark,
                    ),
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
