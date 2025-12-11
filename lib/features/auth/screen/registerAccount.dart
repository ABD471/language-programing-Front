import 'dart:ui';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/auth/controller/registerAccountcontroller.dart';

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
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isloading.value == true) {
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
              children: [
                // تأثير Blur زجاجي
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(color: Colors.black.withOpacity(0.05)),
                ),

                Center(
                  child: SingleChildScrollView(
                    child: AnimatedAuthCard(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: EdgeInsets.all(4.h),
                            width: 85.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.person_add_alt_1_rounded,
                                    color: Colors.white,
                                    size: 75,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Create Account",
                                    style: theme.textTheme.headlineMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: const [
                                            Shadow(
                                              color: Colors.black45,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 4.h),

                                  Costumfiledtext(
                                    hintText: "12".tr,
                                    IconData: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    Mycontroller: controller.phone,
                                    label: "13".tr,
                                    validator: (value) =>
                                        myValidator(value, 8, 25, "phone"),
                                    obscureText: false,
                                  ),
                                  const SizedBox(height: 16),

                                  Costumfiledtext(
                                    hintText: "2".tr,
                                    IconData: const Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    Mycontroller: controller.email,
                                    label: "3".tr,
                                    validator: (value) =>
                                        myValidator(value, 8, 70, "email"),
                                    obscureText: false,
                                  ),
                                  const SizedBox(height: 16),

                                  Costumfiledtext(
                                    hintText: "4".tr,
                                    IconData: const Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    Mycontroller: controller.password,
                                    label: "5".tr,
                                    validator: (value) =>
                                        myValidator(value, 8, 25, "password"),
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 16),

                                  Costumfiledtext(
                                    hintText: "21".tr,
                                    IconData: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    Mycontroller:
                                        controller.password_confirmation,
                                    label: "20".tr,
                                    validator: (value) =>
                                        myValidator(value, 8, 25, "password"),
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 24),

                                  // زر بتأثير نيون جميل
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blueAccent.withOpacity(
                                            0.6,
                                          ),
                                          blurRadius: 20,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          controller.onSignUp();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      TextButton(
                                        onPressed: () => controller.onLogin(),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
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
        }
      }),
    );
  }
}
