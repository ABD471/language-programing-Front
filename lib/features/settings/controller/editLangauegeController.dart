import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  RxString currentLang = 'en'.obs;
  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    loadLanguageFromAPI();
    super.onInit();
  }

  /// 🔵 تغيير اللغة وإرسالها للـ API
  void changeLanguage(String langCode) {
    currentLang.value = langCode;

    // تغيير لغة التطبيق
    Get.updateLocale(Locale(langCode));

    // تحديث API
    updateLanguageOnServer(langCode);
  }

  /// 🟢 تحميل اللغة من الـ API عند تشغيل التطبيق
  Future<void> loadLanguageFromAPI() async {
    try {
      final response = await ApiService.getRequest(
        url: urlClient["getSetting"]!,
        useAuth: true,
      );

      if (response["statusCode"] == 200 && response["body"]["status"] == 1) {
        String lang = response["body"]["data"]["language"];

        currentLang.value = lang;

        // تحديث لغة التطبيق
        Get.updateLocale(Locale(lang));
      }
    } catch (e) {
      print("Failed to load language: $e");
    }

    isLoaded.value = true;
  }

  /// 🔴 API تحديث اللغة بعد تغيير المستخدم لها
  Future<void> updateLanguageOnServer(String langCode) async {
    try {
      isLoading.value = true;
      await ApiService.postRequest(
        url: urlClient["updateSetting"]!,
        useAuth: true,
        payload: {"language": langCode},
      );
    } catch (e) {
      print("Failed to update language");
    }
    isLoading.value = false;
  }
}
