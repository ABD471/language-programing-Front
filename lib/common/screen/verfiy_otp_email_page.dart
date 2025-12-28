import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/controller/verfiyOtpEmailController.dart';
import 'package:apartment_rental_system/common/widget/custom_otpField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerfiyOtpEmailPage extends StatelessWidget {
  VerfiyOtpEmailPage({super.key});

  final VerifyOtpEmailController controller = Get.put(
    VerifyOtpEmailController(),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0.4,
          centerTitle: true,
          title: Text(
            "verify_otp_title".tr,
            style: theme.appBarTheme.titleTextStyle,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              child: Column(
                children: [
                  Text(
                    'otp_screen_title'.tr,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black45,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    'otp_screen_subtitle'.tr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  AnimatedAuthCard(
                    color: Colors.white.withOpacity(0.9),
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        //=====================
                        // OTP FIELDS
                        //=====================
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(controller.otpLength, (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 10,
                              ),
                              child: buildOtpField(
                                controllers: controller.controllers,
                                focusNodes: controller.focusNodes,
                                index: i,
                                onChanged: (value) =>
                                    controller.onOtpChanged(value, i),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 20),

                        //=====================
                        // VERIFY BUTTON
                        //=====================
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.verifyOtp,
                              style: theme.elevatedButtonTheme.style,
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text('verify_button'.tr),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        //=====================
                        // RESEND OTP
                        //=====================
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: controller.canResend.value
                                    ? controller.resendOtp
                                    : null,
                                child: Text(
                                  'resend_otp'.tr,
                                  style: TextStyle(
                                    color: controller.canResend.value
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ),

                              Text(
                                controller.canResend.value
                                    ? 'resend_available'.tr
                                    : '${"resend_after".tr} ${controller.secondsRemaining.value}s',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('change_phone_number'.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
