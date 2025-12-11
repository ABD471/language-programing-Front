import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/auth/controller/loginController.dart';
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
              height: 30.h,
              width: 20.w,
            ),
          );
        } else {
          return GradientBackground(
            child: Stack(
              children: [
                Container(color: Colors.black.withOpacity(0.3)),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.apartment_rounded,
                                size: 80,
                                color: theme.primaryColor,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Login',
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Phone
                              TextFormField(
                                controller: controller.phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'رقم الموبايل',
                                  prefixIcon: const Icon(Icons.phone_android),
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password
                              Obx(
                                () => TextFormField(
                                  controller: controller.password,
                                  obscureText: controller.hiden.value,
                                  decoration: InputDecoration(
                                    labelText: 'كلمة المرور',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.hiden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: controller.onTapHiden,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'هذا الحقل مطلوب';
                                    }
                                    if (value.length < 6) {
                                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.onLogin();
                                    }
                                  },
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: controller.onForgetPassword,
                                  child: const Text('نسيت كلمة المرور؟'),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Sign Up
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('ليس لديك حساب؟'),
                                  TextButton(
                                    onPressed: controller.onSignUp,
                                    child: const Text('إنشاء حساب جديد'),
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
