import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/controller/verfiyOtpEmailController.dart';
import 'package:apartment_rental_system/common/widget/custom_otpField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VerfiyOtpEmailPage extends StatelessWidget {
  VerfiyOtpEmailPage({super.key});

  final VerifyOtpEmailController controller = Get.put(
    VerifyOtpEmailController(),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "verify_otp_title".tr,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  Text(
                    'otp_screen_title'.tr,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'otp_screen_subtitle'.tr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 5.h),

                  AnimatedAuthCard(
                    color: isDark
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.95),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 4.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(controller.otpLength, (i) {
                            return buildOtpField(
                              theme: theme,
                              controllers: controller.controllers,
                              focusNodes: controller.focusNodes,
                              index: i,
                              onChanged: (value) =>
                                  controller.onOtpChanged(value, i),
                            );
                          }),
                        ),

                        SizedBox(height: 5.h),

                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 6.h,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'verify_button'.tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 3.h),

                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.canResend.value
                                    ? "resend_available".tr
                                    : "${"resend_after".tr} ${controller.secondsRemaining.value}s",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: controller.canResend.value
                                    ? controller.resendOtp
                                    : null,
                                child: Text(
                                  'resend_otp'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: controller.canResend.value
                                        ? theme.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),

                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'change_phone_number'.tr,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        decoration: TextDecoration.underline,
                        fontSize: 12.sp,
                      ),
                    ),
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
