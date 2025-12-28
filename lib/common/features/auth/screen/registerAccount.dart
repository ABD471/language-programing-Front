import 'dart:ui';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/auth/controller/registerAccountcontroller.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Registeraccount extends StatelessWidget {
  const Registeraccount({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final RegisterAccountcontroller controller = Get.put(
      RegisterAccountcontroller(),
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "create_account".tr,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            shadows: [
              Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 6),
            ],
          ),
        ),
      ),

      backgroundColor: theme.scaffoldBackgroundColor,

      body: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/Loading.json',
              height: 20.h,
              width: 20.w,
            ),
          );
        }

        return GradientBackground(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(color: Colors.black.withOpacity(0.05)),
              ),

              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.1.w,
                    vertical: 2.h,
                  ),
                  child: AnimatedAuthCard(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.w),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: 90.w,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: theme.cardColor.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(4.w),
                            border: Border.all(
                              color: theme.primaryColor.withOpacity(0.25),
                              width: 0.6.w,
                            ),
                          ),

                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_add_alt_1_rounded,
                                  color: theme.primaryColor,
                                  size: 14.w,
                                ),

                                SizedBox(height: 3.h),

                                // PHONE FIELD
                                Costumfiledtext(
                                  hintText: "phone_hint".tr,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: theme.primaryColor,
                                  ),
                                  Mycontroller: controller.phone,
                                  label: "phone".tr,
                                  validator: (value) =>
                                      myValidator(value, 8, 25, "phone"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.5.h),

                                // EMAIL FIELD
                                Costumfiledtext(
                                  hintText: "email_hint".tr,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: theme.primaryColor,
                                  ),
                                  Mycontroller: controller.email,
                                  label: "email".tr,
                                  validator: (value) =>
                                      myValidator(value, 8, 70, "email"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.5.h),

                                // PASSWORD FIELD
                                Obx(
                                  () => Costumfiledtext(
                                    hintText: "password_hint".tr,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: theme.primaryColor,
                                    ),
                                    Mycontroller: controller.password,
                                    label: "password".tr,
                                    validator: (value) =>
                                        myValidator(value, 8, 25, "password"),
                                    obscureText:
                                        controller.obscurePassword.value,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.obscurePassword.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: theme.primaryColor,
                                        size: 18.sp,
                                      ),
                                      onPressed: () {
                                        controller.obscurePassword.value =
                                            !controller.obscurePassword.value;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(height: 2.5.h),

                                // CONFIRM PASSWORD
                                Obx(
                                  () => Costumfiledtext(
                                    hintText: "confirm_password_hint".tr,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: theme.primaryColor,
                                    ),
                                    Mycontroller:
                                        controller.password_confirmation,
                                    label: "confirm_password".tr,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "confirm_password_hint".tr;
                                      }
                                      if (value != controller.password.text) {
                                        return "password_not_match".tr;
                                      }
                                      return null;
                                    },
                                    obscureText:
                                        controller.obscureConfirm.value,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.obscureConfirm.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: theme.primaryColor,
                                        size: 18.sp,
                                      ),
                                      onPressed: () {
                                        controller.obscureConfirm.value =
                                            !controller.obscureConfirm.value;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                // SIGNUP BUTTON
                                SizedBox(
                                  width: double.infinity,
                                  height: 6.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.onSignUp();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          3.w,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "signup".tr,
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "already_have_account".tr,
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                            color: const Color.fromARGB(
                                              179,
                                              89,
                                              131,
                                              214,
                                            ),
                                            fontSize: 15.sp,
                                          ),
                                    ),
                                    TextButton(
                                      onPressed: () => controller.onLogin(),
                                      child: Text(
                                        "login".tr,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                              color: theme.primaryColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
