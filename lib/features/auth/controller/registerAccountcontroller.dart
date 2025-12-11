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
  late var profile;
  var selectedRole = UserRole.tenant.obs;

  // تغيير الاختيار
  void setRole(UserRole role) {
    selectedRole.value = role;
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
          message: "password not confirmation".tr,
          lottieAsset: "assets/lottie/Error.json",
        );
        return;
      }

      final Map<String, String> fields = {
        "email": email.text,
        "password": password.text,
        "password_confirmation": password_confirmation.text,
        "phone": phone.text,
        "role": selectedRole.value == UserRole.tenant ? "tenant" : "rented",
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

      if (statusCode == 201 && body["status"] == 1) {
        Get.toNamed("/verfiyOtpEmailPage", arguments: email.text);
        Get.snackbar("Success".tr, "message");
        return;
      }

      // معالجة أخطاء 422
      if (statusCode == 422 && body["errors"] != null) {
        final errors = body["errors"];

        if (errors.containsKey("email") && errors.containsKey("phone")) {
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: "phone and email is exists ready".tr,
            lottieAsset: "assets/lottie/Error.json",
          );
          return;
        }

        if (errors.containsKey("email")) {
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: "email is exists ready".tr,
            lottieAsset: "assets/lottie/Error.json",
          );
          return;
        }

        // --------- فحص أخطاء الهاتف ----------
        if (errors.containsKey("phone")) {
          final phoneErrors = errors["phone"];

          // خطأ تنسيق رقم الهاتف
          if (phoneErrors is List &&
              phoneErrors.any((e) => e.toString().contains("format"))) {
            showDialogWithLottie(
              title: "dialog_error_title".tr,
              message: "phone format invaild".tr,
              lottieAsset: "assets/lottie/Error.json",
            );
            return;
          }

          // رقم الهاتف موجود مسبقاً
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: "phone is exists ready".tr,
            lottieAsset: "assets/lottie/Error.json",
          );
          return;
        }

        if (errors.containsKey("password")) {
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: "The password field must be at least 8 characters",
            lottieAsset: "assets/lottie/Error.json",
          );
          return;
        }
      }

      // أي حالة غير متوقعة
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
