import 'dart:ui';

import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/features/settings/controller/editLangauegeController.dart';
import 'package:apartment_rental_system/features/settings/widget/languageCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectionCardPage extends StatelessWidget {
  LanguageSelectionCardPage({super.key});

  final LanguageController controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('select_language'.tr),
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  languageCard('en', 'English', '🇺🇸', controller),
                  SizedBox(height: 16),
                  languageCard('ar', 'العربية', '🇸🇦', controller),
                ],
              ),
            ),
          ),
        ),

        // Loading Overlay
        Obx(
          () => controller.isLoading.value
              ? Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: Container(color: Colors.black.withOpacity(0.25)),
                    ),
                    const Center(child: Loading()),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
