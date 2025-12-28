import 'dart:ui';

import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:get/get.dart';

class EditlangThemeController extends GetxController {
  RxBool isDarkMode = true.obs;
  RxString language = 'ar'.obs;
  RxBool isLoaded = false.obs;

  Future<void> load() async {
    if (isLoaded.value) return;

    // 1️⃣ Local cache أولاً
    await sharedPreferences.setString('language', "en");
    final cachedTheme = sharedPreferences.getString('theme');
    final cachedLang = sharedPreferences.getString('language');

    if (cachedTheme != null) {
      isDarkMode.value = cachedTheme == 'dark';
    }
    if (cachedLang != null) {
      language.value = cachedLang;
      Get.updateLocale(Locale(cachedLang));
    }

    // إذا الاثنين موجودين → لا API
    if (cachedTheme != null && cachedLang != null) {
      isLoaded.value = true;

      return;
    }

    // 2️⃣ API (مرة واحدة فقط)
    try {
      final res = await ApiService.getRequest(
        url: urlClient["getSetting"]!,
        useAuth: true,
      );

      if (res["statusCode"] == 200) {
        final data = res["body"]["data"];

        isDarkMode.value = data["theme"] == 'dark';
        language.value = data["language"];

        Get.updateLocale(Locale(language.value));

        // Cache
        await sharedPreferences.setString('theme', data["theme"]);
        await sharedPreferences.setString('language', data["language"]);
      }
    } catch (e) {
      print(e);
    }

    isLoaded.value = true;
  }

  Future<void> updateTheme(bool dark) async {
    isDarkMode.value = dark;
    await sharedPreferences.setString('theme', dark ? 'dark' : 'light');

    ApiService.postRequest(
      url: urlClient["settingsUpdate"]!,
      useAuth: true,
      payload: {"theme": dark ? "dark" : "light"},
    );
  }

  Future<void> updateLanguage(String lang) async {
    language.value = lang;
    Get.updateLocale(Locale(lang));
    await sharedPreferences.setString('language', lang);

    ApiService.postRequest(
      url: urlClient["settingsUpdate"]!,
      useAuth: true,
      payload: {"language": lang},
    );
  }
}
