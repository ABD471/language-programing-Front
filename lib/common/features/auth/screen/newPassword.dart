import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/features/auth/controller/newPassword_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Newpasswordscreen extends StatefulWidget {
  const Newpasswordscreen({super.key});

  @override
  State<Newpasswordscreen> createState() => _NewpasswordscreenState();
}

class _NewpasswordscreenState extends State<Newpasswordscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
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
    final NewpasswordController controller = Get.put(NewpasswordController());
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
        }

        return Stack(
          children: [
            /// 🔥 خلفية متدرجة
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.6),
                    theme.colorScheme.secondary.withOpacity(0.4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Center(
              child: AnimatedAuthCard(
                duration: const Duration(milliseconds: 1200),
                beginOffset: const Offset(0, 0.2),
                color: Colors.white.withOpacity(0.9),
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock_reset_rounded,
                        color: theme.primaryColor,
                        size: 12.w,
                      ),

                      SizedBox(height: 2.h),

                      /// عنوان تغيير كلمة المرور
                      Text(
                        "new_password_title".tr,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 1.h),

                      /// الوصف
                      Text(
                        "new_password_description".tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 3.h),

                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            /// كلمة المرور الجديدة
                            Obx(
                              () => Costumfiledtext(
                                hintText: "new_password_hint".tr,
                                label: "new_password".tr,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: theme.primaryColor,
                                ),
                                Mycontroller: controller.passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "new_password_empty".tr;
                                  }
                                  if (value.length < 6) {
                                    return "new_password_short".tr;
                                  }
                                  return null;
                                },
                                obscureText: controller.obscurePassword.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: theme.primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.obscurePassword.value =
                                        !controller.obscurePassword.value;
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: 2.h),

                            /// تأكيد كلمة المرور
                            Obx(
                              () => Costumfiledtext(
                                hintText: "confirm_password_hint".tr,
                                label: "confirm_password".tr,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: theme.primaryColor,
                                ),
                                Mycontroller: controller.confirmController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "confirm_password_empty".tr;
                                  }
                                  if (value !=
                                      controller.passwordController.text) {
                                    return "password_not_match".tr;
                                  }
                                  return null;
                                },
                                obscureText: controller.obscureConfirm.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscureConfirm.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: theme.primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.obscureConfirm.value =
                                        !controller.obscureConfirm.value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 4.h),

                      /// زر حفظ كلمة المرور
                      SizedBox(
                        width: 100.w,
                        height: 6.h,
                        child: ElevatedButton(
                          style: theme.elevatedButtonTheme.style,
                          onPressed: controller.onSave,
                          child: Text(
                            "save_new_password".tr,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
