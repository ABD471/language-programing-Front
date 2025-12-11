import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    loadThemeFromAPI();
    super.onInit();
  }

  /// Getter: يعطي ThemeMode إلى الـ GetMaterialApp
  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// تغيير الثيم + إرسال تحديث إلى الـ API
  void changeTheme(bool darkMode) {
    isDarkMode.value = darkMode;

    // تحديث API هنا
    updateThemeOnServer(darkMode);
  }

  /// استدعاء API لتحديث الثيم
  Future<void> updateThemeOnServer(bool darkMode) async {
    try {
      isLoading.value = true;
      await ApiService.postRequest(
        url: urlClient["updateSetting"]!,
        useAuth: true,
        payload: {"theme": darkMode ? "dark" : "light"},
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update theme",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  /// استدعاء API لجلب الثيم عند فتح التطبيق
  Future<void> loadThemeFromAPI() async {
    try {
      final response = await ApiService.getRequest(
        url: urlClient["getSetting"]!,
        useAuth: true,
      );

      if (response["statusCode"] == 200 && response["body"]["status"] == 1) {
        String theme = response["body"]["data"]["theme"];

        isDarkMode.value = theme == "dark";
      }
    } catch (e) {
      print("Failed to load theme");
    }
    isLoaded.value = true; // تمتّ عملية التحميل
  }
}
