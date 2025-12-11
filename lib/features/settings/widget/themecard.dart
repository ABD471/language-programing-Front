import 'package:apartment_rental_system/features/settings/controller/editThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget themeCard(String titleKey, IconData icon, bool darkMode, ThemeController controller) {
      return Obx(() {
        bool selected = controller.isDarkMode.value == darkMode;

        return GestureDetector(
          onTap: () {
            controller.changeTheme(darkMode);
          },
          child: AnimatedScale(
            scale: selected ? 1.05 : 1.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                gradient: selected
                    ? LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      )
                    : null,
                color: selected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: selected
                        ? Colors.blueAccent.withOpacity(0.4)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
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
                        size: 30,
                        color: selected ? Colors.white : Colors.black87,
                      ),
                      SizedBox(width: 12),
                      Text(
                        titleKey.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  if (selected)
                    Icon(Icons.check_circle, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
        );
      });
    }
