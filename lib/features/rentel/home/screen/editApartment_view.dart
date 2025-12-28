import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/editApartmentController.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildLoadingOverlay.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildSteps.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildStepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditApartmentScreen extends StatelessWidget {
  final controller = Get.put(EditApartmentController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomGlassAppBar(title: "edit_apartment".tr),
      body: GradientBackground(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: isDark
                    ? Colors.white.withOpacity(0.02)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            SafeArea(
              top: false,
              child: Obx(() {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 85,
                        left: 12,
                        right: 12,
                        bottom: 12,
                      ),
                      child: AnimatedOpacity(
                        opacity: controller.isUpdating.value ? 0.3 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withOpacity(
                              isDark ? 0.9 : 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.black54 : Colors.black12,
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: buildStepper(
                            context: context,
                            controller: controller,
                            steps: buildSteps(context, controller),
                          ),
                        ),
                      ),
                    ),
                    if (controller.isUpdating.value)
                      buildLoadingOverlay(context, message: "updating_msg".tr),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
