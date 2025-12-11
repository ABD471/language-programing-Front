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
            "Verfiy Otp Code",
            style: theme.appBarTheme.titleTextStyle,
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 36,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // العنوان
                      Text(
                        'تأكيد الحساب',
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
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'أدخل رمز التحقق المرسل إلى رقم هاتفك',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),

                      // AnimatedAuthCard للـ OTP
                      AnimatedAuthCard(
                        color: Colors.white.withOpacity(0.9),
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            // خانات OTP
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(controller.otpLength, (
                                i,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  child: buildOtpField(
                                    controllers: controller.controllers,
                                    focusNodes: controller.focusNodes,
                                    index: i,
                                    onChanged: (value) {
                                      if (value.isNotEmpty &&
                                          i < controller.otpLength - 1) {
                                        controller.focusNodes[i + 1]
                                            .requestFocus();
                                      } else if (value.isEmpty && i > 0) {
                                        controller.focusNodes[i - 1]
                                            .requestFocus();
                                      }
                                      controller.onOtpChanged(value, i);
                                    },
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),

                            // زر التأكيد
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: theme.elevatedButtonTheme.style,
                                onPressed: controller.verifyOtp,
                                child: Text(
                                  'تأكيد',
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // إعادة الإرسال
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: theme.textButtonTheme.style,
                                  onPressed: controller.canResend.value
                                      ? controller.resendOtp
                                      : null,
                                  child: const Text('إعادة إرسال'),
                                ),
                                Text(
                                  controller.canResend.value
                                      ? 'يمكنك إعادة الإرسال الآن'
                                      : 'أعد الإرسال بعد ${controller.secondsRemaining}s',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),
                      TextButton(
                        style: theme.textButtonTheme.style,
                        onPressed: () => Navigator.of(context).maybePop(),
                        child: const Text('تغيير رقم الهاتف'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
