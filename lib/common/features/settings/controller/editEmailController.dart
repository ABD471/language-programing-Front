import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editemailcontroller extends GetxController {
  late TextEditingController email;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  Future<void> updateEmail() async {
    try {
      isLoading.value = true;

      final response = await ApiService.postRequest(
        url: urlClient["updateEmail"]!,
        useAuth: true,
        payload: {"email": email.text},
      );

      isLoading.value = false;

      final statusCode = response["statusCode"];
      final body = response["body"];

      // ================================
      //           SUCCESS 200
      // ================================
      if (statusCode == 200 && body["status"] == 1) {
        final arg = {
          "email": email.text,
          "urlclient": "updateEmailconfirm",
          "useAuth": true,
        };
        Get.toNamed("/verfiyOtpEmailPage", arguments: arg);
        Get.snackbar(
          "Success".tr,
          body["message"] ?? "Email updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ================================
      //           VALIDATION ERROR 422
      // ================================
      if (statusCode == 422) {
        final errorMessage =
            body["errors"]?["email"]?[0] ??
            body["message"] ??
            "Validation error";

        Get.snackbar(
          "Validation Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // ================================
      //           UNAUTHORIZED 403
      // ================================
      if (statusCode == 403) {
        Get.snackbar(
          "Unauthorized",
          body["message"] ?? "Unauthorized access",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // ================================
      //           NOT FOUND 404
      // ================================
      if (statusCode == 404) {
        Get.snackbar(
          "Not Found",
          body["message"] ?? "Not found",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // ================================
      //           OTHER ERRORS
      // ================================
      Get.snackbar(
        "Error",
        body["message"] ?? "Unexpected error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
