import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/common/features/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/helper/const/requestType.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:apartment_rental_system/util/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;

      await ApiService.postRequest(
        url: urlClient["logout"]!,
        useAuth: true,
        type: RequestType.normal,
      );
    } catch (e) {
      
      debugPrint("Logout API failed: $e");
    } finally {
      await AuthService.clearToken();

      
      Get.deleteAll(force: true);
      await Get.putAsync(() => NotificationService().init(), permanent: true);
      await Get.putAsync(
        () async => EditlangThemeController(),
        permanent: true,
      );

      Get.offAllNamed('/loginScreen');
      isLoading.value = false;
    }
  }
}
