import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/auth/controller/forgetPassword_Controller.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ForgetpasswordController controller = Get.put(
      ForgetpasswordController(),
    );
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/Loading.json',
              height: 30.h,
              width: 20.w,
            ),
          );
        } else {
          return GradientBackground(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // الخلفية
                Container(color: Colors.black.withOpacity(0.3)),

                // الكارد المتحرك
                Center(
                  child: SingleChildScrollView(
                    child: AnimatedAuthCard(
                      duration: const Duration(milliseconds: 1200),
                      beginOffset: const Offset(0, 0.2),
                      color: Colors.white.withOpacity(0.95),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 36,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_reset_rounded,
                            color: theme.primaryColor,
                            size: 80,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "نسيت كلمة المرور؟",
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "أدخل البريد الإلكتروني أو رقم الهاتف لاستعادة كلمة المرور.",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // الحقل
                          Form(
                            key: controller.formKey,
                            child: Costumfiledtext(
                              hintText: "البريد الإلكتروني أو الهاتف",
                              IconData: const Icon(Icons.email),
                              Mycontroller: controller.email,
                              label: "البريد الإلكتروني أو الهاتف",
                              validator: (value) =>
                                  myValidator(value, 5, 70, "email"),
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // زر الإرسال
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: theme.elevatedButtonTheme.style,
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.onNext();
                                }
                              },
                              child: Text(
                                "إرسال",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
