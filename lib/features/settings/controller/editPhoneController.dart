import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhoneController extends GetxController {
  late TextEditingController phone;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phone.dispose();
    super.onClose();
  }

  Future<void> updatePhone() async {
    try {
      isLoading.value = true;

      final response = await ApiService.postRequest(
        url: urlClient["updatePhone"]!,
        useAuth: true,
        payload: {"phone": phone.text}, // أضفت الـ payload لتحديث الهاتف
      );

      isLoading.value = false;

      if (response["statusCode"] == 200 && response["body"]["status"] == 1) {
        Get.back();
        Get.snackbar(
          "Success".tr,
          "phone_updated_success".tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error".tr,
          response['body']['message'].toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
