import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
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
      // حتى لو فشل السيرفر نكمّل logout محليًا
      debugPrint("Logout API failed: $e");
    } finally {
      await AuthService.clearToken(); // حذف التوكن محليًا

      // حذف كل Controllers
      Get.deleteAll(force: true);
      await Get.putAsync(() => NotificationService().init(), permanent: true);
      // توجيه بدون رجوع
      Get.offAllNamed('/loginScreen');
      isLoading.value = false;
    }
  }
}
