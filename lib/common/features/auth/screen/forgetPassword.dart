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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/Loading.json',
              height: 20.h,
              width: 20.h,
            ),
          );
        }

        return GradientBackground(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: Colors.black.withOpacity(isDark ? 0.5 : 0.3)),
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: AnimatedAuthCard(
                    duration: const Duration(milliseconds: 1000),
                    beginOffset: const Offset(0, 0.1),
                    color: isDark
                        ? Colors.grey[900]!.withOpacity(0.9)
                        : Colors.white.withOpacity(0.95),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 4.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_reset_rounded,
                            color: theme.primaryColor,
                            size: 12.w,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "forgot_password".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : theme.primaryColorDark,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          "forgot_password_description".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Form(
                          key: controller.formKey,
                          child: Costumfiledtext(
                            label: "email_or_phone".tr,
                            hintText: "email_or_phone_hint".tr,
                            Mycontroller: controller.phone,
                            prefixIcon: Icon(
                              Icons.alternate_email_rounded,
                              size: 18.sp,
                            ),
                            validator: (value) =>
                                myValidator(value, 5, 50, "email_or_phone"),
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.onNext();
                              }
                            },
                            child: Text(
                              "send".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "back_to_login".tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w500,
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
      }),
    );
  }
}
