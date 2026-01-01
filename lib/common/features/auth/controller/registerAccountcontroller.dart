import 'dart:io';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/helper/const/role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterAccountcontroller extends GetxController {
  RxBool isloading = false.obs;

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController password_confirmation;
  late TextEditingController phone;

  RxBool obscurePassword = true.obs;
  RxBool obscureConfirm = true.obs;

  late var profile;

  var selectedRole = UserRole.tenant.obs;

  void setRole(UserRole role) {
    selectedRole.value = role;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmVisibility() {
    obscureConfirm.value = !obscureConfirm.value;
  }

  @override
  void onInit() {
    profile = Get.arguments;
    email = TextEditingController();
    password = TextEditingController();
    password_confirmation = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  void onSignUp() async {
    isloading.value = true;

    try {
      if (password.text != password_confirmation.text) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: "password_not_match".tr,
          lottieAsset: "assets/lottie/Error.json",
        );
        return;
      }

      final Map<String, String> fields = {
        "email": email.text,
        "password": password.text,
        "password_confirmation": password_confirmation.text,
        "phone": phone.text,

        "role": selectedRole.value == UserRole.tenant ? "tenant" : "rental",

        "first_name": profile["firstname"],
        "last_name": profile["lastname"],
        "date_of_birth": profile["dob"],
      };

      Map<String, File> files = {};
      if (profile["imageProfile"] != null) {
        files["profile_picture"] = profile["imageProfile"];
      }
      if (profile["imageNationalid"] != null) {
        files["national_id_image"] = profile["imageNationalid"];
      }

      final result = await ApiService.postMultipartRequest(
        url: urlClient["registerAccount"]!,
        fields: fields,
        files: files,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      if (statusCode == 200 && body["status"] == 1) {
        final args = {"email": email.text, "urlclient": "otpRegister"};
        Get.toNamed("/verfiyOtpEmailPage", arguments: args);
        Get.snackbar(
          "success".tr,
          "otp_resend".tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (statusCode == 201 && body["status"] == 1) {
        final args = {"email": email.text, "urlclient": "otpRegister"};
        Get.toNamed("/verfiyOtpEmailPage", arguments: args);
        Get.snackbar("success".tr, "account_created_success_otp_sent".tr);
        return;
      }

      if (statusCode == 422 && body["errors"] != null) {
        final errors = body["errors"];
        handleValidationErrors(errors);
        return;
      }

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

  void handleValidationErrors(Map errors) {
    if (errors.containsKey("email") && errors.containsKey("phone")) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: "phone_and_email_exist".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
    } else if (errors.containsKey("email")) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: "email_exist".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
    } else if (errors.containsKey("phone")) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: errors["phone"].toString().contains("format")
            ? "phone_invalid_format".tr
            : "phone_exist".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
    } else if (errors.containsKey("password")) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: "password_min_8".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
    }
  }

  void showDialogWithLottie({
    required String title,
    required String message,
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

  void onLogin() {
    Get.offNamed("/loginScreen");
  }
}
