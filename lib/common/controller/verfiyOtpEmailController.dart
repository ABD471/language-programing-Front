import 'dart:async';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifyOtpEmailController extends GetxController {
  RxBool isLoading = false.obs;
  final int otpLength = 6;

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

    // اجعل الفوكس على أول خانة عند البداية
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

  void onOtpChanged(String value, int index) {
    if (value.isEmpty) {
      if (index > 0) focusNodes[index - 1].requestFocus();
      return;
    }

    final char = value.characters.first;
    controllers[index].text = char;
    controllers[index].selection = TextSelection.collapsed(offset: 1);

    if (index + 1 < otpLength) {
      focusNodes[index + 1].requestFocus();
    } else {
      focusNodes[index].unfocus();
    }
  }

  String getOtp() => controllers.map((c) => c.text).join();

  Future<void> verifyOtp() async {
    final otp = getOtp();
    if (otp.length < otpLength) {
      _showSnackBar('أدخل جميع أرقام التحقق');
      return;
    }

    isLoading.value = true;

    try {
      final String email = Get.arguments;
      final Map<String, dynamic> payload = {"email": email, "otp": otp};

      final result = await ApiService.postRequest(
        url: urlClient["otpRegister"]!,
        useAuth: false,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      switch (statusCode) {
        case 200:

          // حالة نجاح التحقق
          showDialogWithLottie(
            title: "otp_verified_title".tr,
            message: "otp_verified_message".tr,
            lottieAsset: "assets/lottie/Success.json",
            onConfirm: () {
              Get.back(); // اغلاق الدايالوغ
              // الانتقال للشاشة المناسبة بعد التحقق
              if (body["message"] == 'OTP verified successfully') {
              
                Get.offAllNamed("/mainwrapper");
              } else {
                Get.toNamed("/newpasswordscreen", arguments: email);
                // Get.offAllNamed("/newPasswordPage", arguments: body["user"]);
              }
            },
          );
          break;

        case 400:
          // OTP خاطئ أو منتهي الصلاحية
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "OTP خاطئ أو منتهي الصلاحية",
            lottieAsset: "assets/lottie/Error.json",
          );
          break;

        case 403:
          // الحساب غير مفعل
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "حسابك غير مفعل بعد",
            lottieAsset: "assets/lottie/Alert.json",
          );
          break;

        case 600:
        case 601:
        case 602:
        case 603:
        case 604:
          // حالات مخصصة من الـ API
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "خطأ غير معروف",
            lottieAsset: "assets/lottie/Error.json",
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
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: e.toString(),
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showDialogWithLottie({
    required String title,
    required String message,
    required String lottieAsset,
    void Function()? onConfirm,
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
      onConfirm: onConfirm ?? () => Get.back(),
    );
  }

  void _showSnackBar(String text) {
    Get.snackbar("", text);
  }

  // إعادة إرسال OTP مع مؤقت
  void resendOtp() async {
    if (!canResend.value) {
      _showSnackBar('انتظر قليلاً قبل إعادة الإرسال');
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
        _showSnackBar('تم إعادة إرسال رمز التحقق بنجاح');
        startResendTimer();
      } else {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: body['message'] ?? "حدث خطأ أثناء إعادة الإرسال",
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
}
