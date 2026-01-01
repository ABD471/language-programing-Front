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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/Loading.json',
              height: 25.h,
              width: 25.h,
            ),
          );
        }

        return Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          Colors.black,
                          theme.colorScheme.primary.withOpacity(0.2),
                        ]
                      : [
                          theme.colorScheme.primary.withOpacity(0.7),
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
                beginOffset: const Offset(0, 0.1),
                color: isDark
                    ? Colors.grey[900]!.withOpacity(0.9)
                    : Colors.white.withOpacity(0.9),
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: SingleChildScrollView(
                  child: Column(
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
                          size: 10.w,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "new_password_title".tr,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "new_password_description".tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white70 : Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            Obx(
                              () => Costumfiledtext(
                                hintText: "new_password_hint".tr,
                                label: "new_password".tr,
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  size: 18.sp,
                                ),
                                Mycontroller: controller.passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "new_password_empty".tr;
                                  if (value.length < 6)
                                    return "new_password_short".tr;
                                  return null;
                                },
                                obscureText: controller.obscurePassword.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 18.sp,
                                  ),
                                  onPressed: () =>
                                      controller.obscurePassword.value =
                                          !controller.obscurePassword.value,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Obx(
                              () => Costumfiledtext(
                                hintText: "confirm_password_hint".tr,
                                label: "confirm_password".tr,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  size: 18.sp,
                                ),
                                Mycontroller: controller.confirmController,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "confirm_password_empty".tr;
                                  if (value !=
                                      controller.passwordController.text)
                                    return "password_not_match".tr;
                                  return null;
                                },
                                obscureText: controller.obscureConfirm.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscureConfirm.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 18.sp,
                                  ),
                                  onPressed: () =>
                                      controller.obscureConfirm.value =
                                          !controller.obscureConfirm.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: 100.w,
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
                          onPressed: controller.onSave,
                          child: Text(
                            "save_new_password".tr,
                            style: TextStyle(
                              fontSize: 14.sp,
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
        );
      }),
    );
  }
}
