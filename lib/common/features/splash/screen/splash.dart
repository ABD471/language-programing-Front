
import 'package:apartment_rental_system/common/features/splash/controller/splashController.dart';
import 'package:apartment_rental_system/common/features/splash/screen/nointernet.dart';
import 'package:apartment_rental_system/common/features/splash/widget/splashCinematicAnimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashCinematicFull extends StatelessWidget {
  const SplashCinematicFull({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Obx(() {
      // ❌ حالة خطأ (لا إنترنت / timeout)
      if (controller.hasError.value) {
        return NoInternetScreen(
          onRetry: controller.retry,
        );
      }

      // ✅ الأنيميشن السينمائي
      return const SplashCinematicAnimation();
    });
  }
}
