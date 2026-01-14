import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NewpasswordController extends GetxController {
  late TextEditingController passwordController;
  late TextEditingController confirmController;
  late GlobalKey<FormState> formKey;

  RxBool obscurePassword = true.obs;
  RxBool obscureConfirm = true.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  void onSave() async {
    if (!formKey.currentState!.validate()) return;

    isloading.value = true;

    final String phone = Get.arguments["phone"];

    final payload = {
      "phone": phone,
      "password": passwordController.text,
      "password_confirmation": confirmController.text,
    };

    try {
      final result = await ApiService.postRequest(
        url: urlClient["resetpassword"]!,
        useAuth: false,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      // ----------- حالة النجاح 200 ------------
      if (statusCode == 200 && body["status"] == 1) {
        Get.offAllNamed("/loginScreen");

        showDialogWithLottie(
          title: "newpass_change_title".tr,
          message: "newpass_change_message".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
        return;
      }

      // -----------  حالة 422: مشاكل الفاليديشن ------------
      if (statusCode == 422) {
        String errorMessage = "newpass_validation_error".tr;

        if (body["errors"] != null) {
          if (body["errors"]["phone"] != null) {
            errorMessage = body["errors"]["phone"][0];
          } else if (body["errors"]["password"] != null) {
            errorMessage = body["errors"]["password"][0];
          } else if (body["errors"]["password_confirmation"] != null) {
            errorMessage = body["errors"]["password_confirmation"][0];
          }
        }

        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: errorMessage,
          lottieAsset: "assets/lottie/Error.json",
        );
        return;
      }

      // -----------  حالات غير متوقعة -----------
      showDialogWithLottie(
        title: "dialog_unexpected_title".tr,
        message: "newpass_unexpected_message".trParams({
          "code": "$statusCode",
        }),
        lottieAsset: "assets/lottie/Alert.json",
      );
    } catch (e) {
      // -----------  استثناء -----------
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: "dialog_exception_message".trParams({"error": e.toString()}),
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
