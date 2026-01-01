import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/auth/controller/loginController.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final LoginController controller = Get.put(LoginController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            children: [
              Container(color: Colors.black.withOpacity(isDark ? 0.5 : 0.3)),
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Card(
                    color: isDark
                        ? Colors.grey[900]?.withOpacity(0.9)
                        : Colors.white.withOpacity(0.95),
                    elevation: 10,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 4.h,
                      ),
                      child: Form(
                        key: formKey,
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
                                Icons.apartment_rounded,
                                size: 14.w,
                                color: theme.primaryColor,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'login_welcome'.tr,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall!.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Costumfiledtext(
                              hintText: "phone_hint".tr,
                              label: "phone".tr,
                              prefixIcon: Icon(
                                Icons.phone_android_rounded,
                                size: 18.sp,
                              ),
                              Mycontroller: controller.phone,
                              validator: (value) =>
                                  myValidator(value, 9, 10, "phone"),
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: 2.h),
                            Obx(
                              () => Costumfiledtext(
                                hintText: "password_hint".tr,
                                label: "password".tr,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  size: 18.sp,
                                ),
                                Mycontroller: controller.password,
                                validator: (value) =>
                                    myValidator(value, 8, 25, "password"),
                                obscureText: controller.hiden.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.hiden.value
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    size: 18.sp,
                                  ),
                                  onPressed: controller.onTapHiden,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: controller.onForgetPassword,
                                child: Text(
                                  'forgot_password'.tr,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
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
                                  if (formKey.currentState!.validate()) {
                                    controller.onLogin();
                                  }
                                },
                                child: Text(
                                  'Login'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "dont_have_account".tr,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                TextButton(
                                  onPressed: controller.onSignUp,
                                  child: Text(
                                    'create_new_account'.tr,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
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
            ],
          ),
        );
      }),
    );
  }
}
