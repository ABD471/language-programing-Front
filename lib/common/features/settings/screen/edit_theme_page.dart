import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/common/features/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/common/features/settings/widget/themecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ThemeSelectionPage extends StatelessWidget {
  ThemeSelectionPage({super.key});

  final settings = Get.find<EditlangThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "select_theme".tr,
            style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 16.sp),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: theme.iconTheme,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  SizedBox(height: 1.5.h),
                  themeCard(
                    "light_mode".tr,
                    Icons.light_mode_rounded,
                    false,
                    settings,
                  ),
                  SizedBox(height: 2.5.h),
                  themeCard(
                    "dark_mode".tr,
                    Icons.dark_mode_rounded,
                    true,
                    settings,
                  ),
                ],
              ),
            ),

            Obx(
              () => settings.isLoaded.value
                  ? Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          child: Container(
                            color: isDark
                                ? Colors.black54
                                : Colors.black.withOpacity(0.25),
                          ),
                        ),
                        const Center(child: Loading()),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
