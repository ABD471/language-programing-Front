import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginController extends GetxController {
  late TextEditingController phone;
  late TextEditingController password;
  RxBool hiden = true.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() async {
    phone = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  void onLogin() async {
    isloading.value = true;

    try {
      final Map<String, dynamic> payload = {
        "phone": phone.text,
        "password": password.text,
      };

      final result = await ApiService.postRequest(
        url: urlClient["login"]!,
        useAuth: false,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];
      final message = body["message"]?.toString() ?? "";

      // -------------------------
      //      SUCCESS CASE
      // -------------------------
      if (statusCode == 200 && body["status"] == 1) {
        final arg = {"phone": phone.text, "urlclient": "loginverity"};
        Get.toNamed("/verfiyOtpEmailPage", arguments: arg);

        showDialogWithLottie(
          title: "dialog_success_title".tr,
          message: "dialog_success_message_login".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
        return;
      }

      // -------------------------
      //      ERROR CASES
      // -------------------------

      // Wrong phone or password
      if (statusCode == 401 && message.contains("Invalid phone or password")) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: "dialog_invalid_phone_or_password".tr,
          lottieAsset: "assets/lottie/Error.json",
        );
        return;
      }

      // Email not verified
      if (statusCode == 403 && message.contains("Your email is not verified")) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: "dialog_email_not_verified".tr,
          lottieAsset: "assets/lottie/Alert.json",
        );
        return;
      }

      // Account not approved by admin
      if (statusCode == 403 &&
          message.contains("Your account is not approved")) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: "dialog_account_not_approved".tr,
          lottieAsset: "assets/lottie/Alert.json",
        );
        return;
      }

      // Unhandled errors
      showDialogWithLottie(
        title: "dialog_unexpected_title".tr,
        message: "${"dialog_unexpected_code".tr} $statusCode",
        lottieAsset: "assets/lottie/Alert.json",
      );
    } catch (e) {
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: "${"dialog_exception_message".tr} $e",
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isloading.value = false;
    }
  }

  void showDialogWithLottie({
    required String title,
    required dynamic message,
    required String lottieAsset,
  }) {
    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          SizedBox(height: 150, child: Lottie.asset(lottieAsset)),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
      textConfirm: "dialog_confirm".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void onForgetPassword() {
    Get.toNamed("/forgetPasswordPage");
  }

  void onSignUp() {
    Get.toNamed("/registerProfileScreen");
  }

  void onTapHiden() {
    hiden.value = !hiden.value;
  }
  
}
