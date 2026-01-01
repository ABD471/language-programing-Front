import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPasswordController extends GetxController {
  late TextEditingController password;
  late TextEditingController passwordConfirmation;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    password.dispose();
    passwordConfirmation.dispose();
    super.onClose();
  }

  Future<void> updatePassword() async {
    final payload = {
      "password": password.text,
      "password_confirmation": passwordConfirmation.text,
    };

    if (password.text != passwordConfirmation.text) {
      Get.snackbar(
        "Error".tr,
        "password_mismatch".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiService.postRequest(
        url: urlClient["updatePassword"]!,
        useAuth: true,
        payload: payload,
      );

      if (response["statusCode"] == 200 && response["body"]['status'] == 1) {
        Get.back();
        Get.snackbar(
          "Success".tr,
          "password_updated_success".tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error".tr,
          response['statusCode'].toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error".tr,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
