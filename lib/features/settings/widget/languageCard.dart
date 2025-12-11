import 'package:apartment_rental_system/features/settings/controller/editLangauegeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget languageCard(String langCode, String langName, String flag, LanguageController controller) {
      return Obx(() {
        bool selected = controller.currentLang.value == langCode;

        return GestureDetector(
          onTap: () => controller.changeLanguage(langCode),
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
                      Text(flag, style: TextStyle(fontSize: 30)),
                      SizedBox(width: 12),
                      Text(
                        langName.tr, // استخدم الترجمة هنا
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