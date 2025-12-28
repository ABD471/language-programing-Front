import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetpasswordController extends GetxController {
  late TextEditingController phone;
  late GlobalKey<FormState> formKey;

  RxBool isloading = false.obs;

  @override
  void onInit() {
    phone = TextEditingController();
    formKey = GlobalKey<FormState>();

    super.onInit();
  }

  void onNext() async {
    if (!formKey.currentState!.validate()) return;

    isloading.value = true;
    Map<String, dynamic> payload = {"phone": phone.text};

    try {
      final result = await ApiService.postRequest(
        url: urlClient["forgetpassword"]!,
        useAuth: false,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      // الحالة 200 نجاح
      if (statusCode == 200 && body["status"] == 1) {
        final Map<String, String> arg = {
          "phone": phone.text,
          "urlclient": "forgetpasswordverity",
        };

        Get.toNamed("/verfiyOtpEmailPage", arguments: arg);

        showDialogWithLottie(
          title: "success".tr,
          message: "otp_sent_password_reset".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
        return;
      }

      // الحالة 404 المستخدم غير موجود
      if (statusCode == 404) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: "user_not_found".tr,
          lottieAsset: "assets/lottie/Error.json",
        );
        return;
      }

      // الحالة 422 — مشاكل في التحقق
      if (statusCode == 422 && body["errors"] != null) {
        final errors = body["errors"];

        if (errors.containsKey("phone")) {
          final phoneErrors = errors["phone"].toString().toLowerCase();

          if (phoneErrors.contains("format")) {
            showDialogWithLottie(
              title: "dialog_error_title".tr,
              message: "phone_invalid_format".tr,
              lottieAsset: "assets/lottie/Error.json",
            );
            return;
          } else {
            showDialogWithLottie(
              title: "dialog_error_title".tr,
              message: "phone_not_exist".tr,
              lottieAsset: "assets/lottie/Error.json",
            );
            return;
          }
        }
      }

      // حالة غير متوقعة
      showDialogWithLottie(
        title: "dialog_unexpected_title".tr,
        message: "dialog_unexpected_code".tr + " $statusCode",
        lottieAsset: "assets/lottie/Alert.json",
      );
    } catch (e) {
      debugPrint(e.toString());
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: "dialog_exception_message".trParams({"error": "$e"}),
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
}
