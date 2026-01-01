import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/editApartmentController.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildLoadingOverlay.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildSteps.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildStepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
              top: -6.h,
              right: -12.w,
              child: CircleAvatar(
                radius: 25.w,
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
                        top: MediaQuery.of(context).padding.top + 10.h,
                        left: 3.w,
                        right: 3.w,
                        bottom: 2.h,
                      ),
                      child: AnimatedOpacity(
                        opacity: controller.isUpdating.value ? 0.3 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withOpacity(
                              isDark ? 0.9 : 0.8,
                            ),
                            borderRadius: BorderRadius.circular(8.w),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.black54 : Colors.black12,
                                blurRadius: 5.w,
                                spreadRadius: 0.5.w,
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
