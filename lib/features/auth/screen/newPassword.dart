import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/features/auth/controller/newPassword_Controller.dart';
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
      duration: const Duration(milliseconds: 1000),
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
      resizeToAvoidBottomInset: true,
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
          fit: StackFit.expand,
          children: [
            // خلفية التدرج
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFD600), Color(0xFF2C2C2C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // صورة التاكسي شفافة
            Positioned(
              bottom: -50,
              right: -30,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset('assets/success.png', width: 300),
              ),
            ),

            // البطاقة المتحركة
            Center(
              child: AnimatedAuthCard(
                duration: const Duration(milliseconds: 1200),
                beginOffset: const Offset(0, 0.2),
                color: Colors.white.withOpacity(0.95),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 36,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: theme.primaryColor,
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "تغيير كلمة المرور",
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "الرجاء إدخال كلمة المرور الجديدة لتحديثها.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // حقول كلمة المرور
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            // كلمة المرور الجديدة
                            Obx(
                              () => Costumfiledtext(
                                hintText: "أدخل كلمة المرور الجديدة",
                                label: "كلمة المرور الجديدة",
                                IconData: const Icon(Icons.lock),
                                Mycontroller: controller.passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "يرجى إدخال كلمة المرور";
                                  }
                                  if (value.length < 6) {
                                    return "كلمة المرور قصيرة جدًا";
                                  }
                                  return null;
                                },
                                obscureText: controller.obscurePassword.value,
                                hide: IconButton(
                                  icon: Icon(
                                    controller.obscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    controller.obscurePassword.value =
                                        !controller.obscurePassword.value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // تأكيد كلمة المرور
                            Obx(
                              () => Costumfiledtext(
                                hintText: "أدخل تأكيد كلمة المرور",
                                label: "تأكيد كلمة المرور",
                                IconData: const Icon(Icons.lock_outline),
                                Mycontroller: controller.confirmController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "يرجى تأكيد كلمة المرور";
                                  }
                                  if (value !=
                                      controller.passwordController.text) {
                                    return "كلمتا المرور غير متطابقتين";
                                  }
                                  return null;
                                },
                                obscureText: controller.obscureConfirm.value,
                                hide: IconButton(
                                  icon: Icon(
                                    controller.obscureConfirm.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: theme.elevatedButtonTheme.style,
                          onPressed: controller.onSave,
                          child: Text(
                            "تحديث كلمة المرور",
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
        );
      }),
    );
  }
}
