import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/Notification/controller/notificationController.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/rental_home_controller.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/buildApartmentCard.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/buildEmptyState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class MyApartmentsScreen extends StatelessWidget {
  final controller = Get.put(RentalApartmentController());
  final notificationController = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: Obx(
          () => CustomGlassAppBar(
            title: "my_apartments_title".tr,
            notificationIcon: Icons.notifications_none_rounded,
            hasUnreadNotifications: notificationController.hasUnread,
            onNotificationTap: () {
              Get.toNamed('/notificationScreen');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/add'),
        label: Text(
          "add_new".tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        icon: const Icon(Icons.add_home_work_rounded),
        elevation: 6,
        backgroundColor: theme.primaryColor,
      ),
      body: GradientBackground(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.apartmentsList.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchMyApartments();
              },
              color: theme.primaryColor,
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              displacement: 120,
              child: buildEmptyState(theme),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchMyApartments();
            },
            color: theme.primaryColor,
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            displacement: 120,

            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 100,
                  bottom: 120,
                ),
                itemCount: controller.apartmentsList.length,
                itemBuilder: (context, index) {
                  final apartment = controller.apartmentsList[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    child: SlideAnimation(
                      verticalOffset: 100.0,
                      child: FadeInAnimation(
                        child: buildApartmentCard(
                          context,
                          apartment,
                          theme,
                          isDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
