import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/auth/controller/forgetPassword_Controller.dart';
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
              height: 25.h,
              width: 25.w,
            ),
          );
        } else {
          return GradientBackground(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.black.withOpacity(0.3)),

                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: AnimatedAuthCard(
                      duration: const Duration(milliseconds: 1000),
                      beginOffset: const Offset(0, 0.2),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 4.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_reset_rounded,
                            color: theme.primaryColor,
                            size: 13.w,
                          ),

                          SizedBox(height: 2.h),

                          /// ---------------- Title ----------------
                          Text(
                            "forgot_password".tr,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColorDark,
                            ),
                          ),

                          SizedBox(height: 1.5.h),

                          /// ---------------- Description ----------------
                          Text(
                            "forgot_password_description".tr,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15.sp,
                              color: theme.secondaryHeaderColor,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          /// ---------------- Input Field ----------------
                          Form(
                            key: controller.formKey,
                            child: Costumfiledtext(
                              label: "email_or_phone".tr,
                              hintText: "email_or_phone".tr,
                              Mycontroller: controller.phone,
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                size: 18.sp,
                                color: theme.primaryColor,
                              ),
                              validator: (value) =>
                                  myValidator(value, 5, 50, "email_or_phone"),
                              obscureText: false,
                              keyboardType: TextInputType.text,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          /// ---------------- Button ----------------
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.onNext();
                                }
                              },
                              style: theme.elevatedButtonTheme.style,
                              child: Text(
                                "send".tr,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 16.sp,
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
