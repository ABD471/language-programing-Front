import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPasswordRequiredController extends GetxController {
  late TextEditingController password;
  RxBool isLoading = false.obs;

  // الصفحة التالية التي سيتم الذهاب إليها بعد التحقق
  String? nextRoute;

  @override
  void onInit() {
    super.onInit();

    password = TextEditingController();

    // قراءة اسم الصفحة التالية من arguments
    if (Get.arguments != null && Get.arguments["next"] != null) {
      nextRoute = Get.arguments["next"];
    }
  }

  @override
  void onClose() {
    password.dispose();
    super.onClose();
  }

  // يمكن استدعاؤه إن أردت تغيير الصفحة يدويًا
  void setNextPage(String routeName) {
    nextRoute = routeName;
  }

  Future<void> verifyPassword() async {
    try {
      isLoading.value = true;

      final response = await ApiService.postRequest(
        url: urlClient["verifyPassword"]!,
        useAuth: true,
        payload: {"password": password.text},
      );

      if (response["statusCode"] == 200 && response["body"]["status"] == 1) {
        // نجاح — كلمة المرور صحيحة
        Get.snackbar(
          "Success".tr,
          "password_verified_success".tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        // الانتقال للصفحة المطلوبة
        if (nextRoute != null) {
          Get.offNamed(nextRoute!);
        }
      } else if (response["statusCode"] == 401 &&
          response["body"]["status"] == 0) {
        // كلمة المرور خاطئة
        Get.snackbar(
          "Error".tr,
          "wrong_password".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error".tr,
        "unexpected_error".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
