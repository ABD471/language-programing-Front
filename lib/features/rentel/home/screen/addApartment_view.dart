import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildLoadingOverlay.dart';

import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildStepper.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildSteps.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/addApartmentController.dart';

class AddApartmentScreen extends GetView<AddApartmentController> {
  const AddApartmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(sharedPreferences.getString("language"));
    final controller = Get.put(AddApartmentController());
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomGlassAppBar(title: "add_apartment".tr),
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
              child: Obx(
                () => Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 85,
                        left: 10,
                        right: 10,
                      ),
                      child: AnimatedOpacity(
                        opacity: controller.isUploading.value ? 0.1 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withOpacity(
                              isDark ? 0.95 : 0.85,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.black54 : Colors.black12,
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),

                            child: Theme(
                              data: theme.copyWith(
                                canvasColor: Colors.transparent,
                              ),
                              child: Obx(
                                () => buildStepper(
                                  context: context,
                                  controller: controller,
                                  steps: buildSteps(context, controller),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.isUploading.value)
                      Center(child: buildLoadingOverlay(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
