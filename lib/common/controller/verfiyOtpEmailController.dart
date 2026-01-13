import 'dart:async';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';

import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:apartment_rental_system/util/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifyOtpEmailController extends GetxController {
  final int otpLength = 6;
  RxBool isLoading = false.obs;

  late String email;
  late String phone;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  RxBool canResend = false.obs;
  RxInt secondsRemaining = 30.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });

    startResendTimer();
  }

  @override
  void dispose() {
    for (var c in controllers) c.dispose();
    for (var f in focusNodes) f.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ========== OTP FIELD HANDLING ==========
  void onOtpChanged(String value, int index) {
    // حذف القيمة
    if (value.isEmpty) {
      controllers[index].clear();

      if (index > 0) {
        FocusScope.of(Get.context!).requestFocus(focusNodes[index - 1]);
      }
      return;
    }

    if (value.length > 1) {
      value = value.characters.last;
    }

    controllers[index].text = value;
    controllers[index].selection = TextSelection.collapsed(offset: 1);

    if (index < otpLength - 1) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
    } else {
      focusNodes[index].unfocus();
    }
  }

  String getOtp() => controllers.map((c) => c.text).join();

  // ========== VERIFY OTP ==========
  Future<void> verifyOtp() async {
    final otp = getOtp();

    if (otp.length < otpLength) {
      _showSnackBar("enter_all_digits".tr);
      return;
    }

    isLoading.value = true;

    try {
      final Map arg = Get.arguments;
      final String? urlclient = arg["urlclient"];
      final bool useAuth = arg["useAuth"] ?? false;
      late Map<String, dynamic> payload;

      if (arg["email"] != null) {
        email = arg["email"];
        payload = {"email": email, "otp": otp};
      }
      if (arg["phone"] != null) {
        phone = arg["phone"];
        payload = {"phone": phone, "otp": otp};
      }

      final result = await ApiService.postRequest(
        url: urlClient[urlclient]!,
        useAuth: useAuth,
        payload: payload,
      );

      final int statusCode = result["statusCode"];
      final body = result["body"];

      switch (statusCode) {
        case 200:
          showDialogWithLottie(
            title: "otp_verified_title".tr,
            message: "otp_verified_message".tr,
            lottieAsset: "assets/lottie/Success.json",
            onConfirm: () async {
              if (urlclient == 'forgetpasswordverity') {
                Get.toNamed("/newpasswordscreen", arguments: arg["phone"]);
                return;
              } else if (urlclient == 'otpRegister') {
                Get.offAllNamed("/loginScreen", arguments: email);
                return;
              } else if (urlclient == 'loginverity') {
                await AuthService.setToken(
                  body["token"],
                  body["data"]["role"],
                  body["data"]["id"].toString(),
                );
                await saveFcmToken();
              
                if (body["data"]["role"] == "rental") {
                  print("rental logged in");

                  Get.offAllNamed("/rentel-mainwrapper");
                } else if (body["data"]["role"] == "tenant") {
                  Get.offAllNamed("/mainwrapper");
                }
              } else if (urlclient == "updateEmailconfirm") {
                Get.back();
                Get.back();
                Get.back();
                Get.snackbar(
                  "Success".tr,
                  body["message"] ?? "email updated successfully",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          );
          break;

        case 400:
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "otp_wrong_or_expired".tr,
            lottieAsset: "assets/lottie/Error.json",
          );
          break;

        case 403:
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "account_not_verified".tr,
            lottieAsset: "assets/lottie/Alert.json",
          );
          break;

        default:
          showDialogWithLottie(
            title: "dialog_unexpected_title".tr,
            message: "dialog_unexpected_code".trParams({"code": "$statusCode"}),
            lottieAsset: "assets/lottie/Alert.json",
          );
      }
    } catch (e) {
      print(e);
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: e.toString(),
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ========== RESEND OTP ==========
  Future<void> resendOtp() async {
    if (!canResend.value) {
      _showSnackBar("please_wait_resend".tr);
      return;
    }

    try {
      isLoading.value = true;

      final String email = Get.arguments;
      final Map<String, dynamic> payload = {"email": email};

      final result = await ApiService.postRequest(
        url: urlClient["resendOtp"]!,
        useAuth: false,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      if (statusCode == 200) {
        _showSnackBar("otp_resend_success".tr);
        startResendTimer();
      } else {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: body["message"] ?? "dialog_error_title".tr,
          lottieAsset: "assets/lottie/Error.json",
        );
      }
    } catch (e) {
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: e.toString(),
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ========== RESEND TIMER ==========
  void startResendTimer() {
    canResend.value = false;
    secondsRemaining.value = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // ========== HELPERS ==========
  void _showSnackBar(String text) {
    Get.snackbar("", text);
  }

  void showDialogWithLottie({
    required String title,
    required String message,
    required String lottieAsset,
    void Function()? onConfirm,
  }) async {
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
      onConfirm: onConfirm ?? () async => Get.back(),
    );
  }

  Future<void> saveFcmToken() async {
    String? token = await Get.find<NotificationService>().getToken();
    if (token != null) {
      await ApiService.postRequest(
        url: urlClient["update-fcm-token"]!,
        payload: {'fcm_token': token},
        useAuth: true,
      );
    }
  }
}
