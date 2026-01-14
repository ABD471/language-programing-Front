import 'dart:async';
import 'dart:io';
import 'package:apartment_rental_system/common/features/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final minSplash = Future.delayed(const Duration(seconds: 4));
  @override
  void onReady() async {
    super.onReady();
    await _startApp();
  }

  Future<void> _startApp() async {
    try {
      hasError.value = false;

      // فحص إنترنت فعلي
      final hasInternet = await hasRealInternet();
      if (!hasInternet) {
        throw Exception("NO_INTERNET");
      }

      // تشغيل المهام معًا 
      await Future.wait([
        minSplash,
        AuthService.loadToken(),
        Get.putAsync<EditlangThemeController>(() async {
          final c = EditlangThemeController();
          await c.load();
          return c;
        }),
      ]).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("TIMEOUT"),
      );

      //  التوجيه
      final hasSeenOnboarding =
          sharedPreferences.getBool('onboarding_seen') ?? false;

      if (!hasSeenOnboarding) {
        Get.offAllNamed('/onboardingScreen');
      } else if (AuthService.token == null || AuthService.token!.isEmpty) {
        Get.offAllNamed('/loginScreen');
      } else {
        AuthService.role == 'tenant'
            ? Get.offAllNamed('/mainwrapper')
            : Get.offAllNamed('/rentel-mainwrapper');
      }
    } catch (e) {
      hasError.value = true;

      if (e is TimeoutException) {
        errorMessage.value = "انتهت مهلة الاتصال، حاول مرة أخرى";
      } else {
        errorMessage.value = "لا يوجد اتصال بالإنترنت";
      }
    }
  }

  void retry() {
    hasError.value = false;
    _startApp();
  }

  Future<bool> hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 7));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
