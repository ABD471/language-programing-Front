import 'package:apartment_rental_system/common/features/settings/controller/editlang_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget themeCard(
  String titleKey,
  IconData icon,
  bool darkMode,
  EditlangThemeController controller,
) {
  return Obx(() {
    final theme = Get.theme;
    bool selected = controller.isDarkMode.value == darkMode;

    return GestureDetector(
      onTap: () => controller.updateTheme(darkMode),
      child: AnimatedScale(
        scale: selected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(0.7),
                    ],
                  )
                : null,
            color: selected ? null : theme.cardColor,
            borderRadius: BorderRadius.circular(15.sp),
            boxShadow: [
              BoxShadow(
                color: selected
                    ? theme.colorScheme.primary.withOpacity(0.4)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 22.sp,
                    color: selected ? Colors.white : theme.iconTheme.color,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    titleKey.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? Colors.white
                          : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              if (selected)
                Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  });
}
