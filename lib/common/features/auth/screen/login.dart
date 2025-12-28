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
    final LoginController controller = Get.put(LoginController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              children:<Widget> [
                Container(color: Colors.black.withOpacity(0.3)),
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.apartment_rounded,
                                size: 15.w,
                                color: theme.primaryColor,
                              ),

                              SizedBox(height: 2.h),

                              /// **Title**
                              Text(
                                'login_welcome'.tr,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineSmall!.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5.h),

                              /// **Phone Field**
                              Costumfiledtext(
                                hintText: "phone_hint".tr,
                                label: "phone".tr,
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  size: 18.sp,
                                ),
                                Mycontroller: controller.phone,
                                validator: (value) =>
                                    myValidator(value, 9, 10, "phone"),
                                obscureText: false,
                                keyboardType: TextInputType.phone,
                              ),

                              SizedBox(height: 2.h),

                              /// **Password Field**
                              Obx(
                                () => Costumfiledtext(
                                  hintText: "password_hint".tr,
                                  label: "password".tr,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    size: 18.sp,
                                  ),
                                  Mycontroller: controller.password,
                                  validator: (value) =>
                                      myValidator(value, 8, 25, "password"),
                                  obscureText: controller.hiden.value,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.hiden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 18.sp,
                                    ),
                                    onPressed: controller.onTapHiden,
                                  ),
                                ),
                              ),

                              SizedBox(height: 3.h),

                              /// **Login Button**
                              SizedBox(
                                width: double.infinity,
                                height: 6.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.onLogin();
                                    }
                                  },
                                  child: Text(
                                    'Login'.tr,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 1.5.h),

                              /// **Forgot Password**
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: controller.onForgetPassword,
                                  child: Text(
                                    'forgot_password'.tr,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ),
                              ),

                              SizedBox(height: 2.h),

                              /// **Sign Up**
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "dont_have_account".tr,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  TextButton(
                                    onPressed: controller.onSignUp,
                                    child: Text(
                                      'create_new_account'.tr,
                                      style: TextStyle(fontSize: 15.sp),
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
        }
      }),
    );
  }
}
