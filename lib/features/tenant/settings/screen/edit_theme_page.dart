import 'dart:ui';

import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';

import 'package:apartment_rental_system/features/tenant/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/features/tenant/settings/widget/themecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSelectionPage extends StatelessWidget {
  ThemeSelectionPage({super.key});

  final settings = Get.find<EditlangThemeController>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("select_theme".tr),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  themeCard("light_mode", Icons.light_mode, false, settings),
                  SizedBox(height: 16),
                  themeCard("dark_mode", Icons.dark_mode, true, settings),
                ],
              ),
            ),
            // Loading Overlay
            Obx(
              () => settings.isLoaded.value
                  ? Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                        const Center(child: Loading()),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
