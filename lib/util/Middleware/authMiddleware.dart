import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final token = AuthService.token; 

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: "/loginScreen");
    }

    return null; 
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    if (page?.name == "/loginScreen") {
      Future.delayed(Duration.zero, () {
        showDialogWithLottie(
          lottieAsset: "assets/lottie/StopSign.json",
          message: "أنت غير مسجل، صلاحياتك غير كافية، يرجى تسجيل الدخول.",
          title: "تنبيه",
          onConfirm: () {},
        );
      });
    }
    return super.onPageCalled(page);
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
}
