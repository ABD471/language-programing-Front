import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/common/features/settings/controller/verifyPasswrodrequiredController.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AuthPasswordRequierdPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AuthPasswordRequierdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyPasswordRequiredController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.password.clear();
        }
      },
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "auth_password".tr,
              style: theme.appBarTheme.titleTextStyle?.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ),
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: AnimatedAuthCard(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.white.withOpacity(0.9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_person_rounded,
                            size: 60.sp,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "auth_password_msg".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Costumfiledtext(
                                hintText: "enter_password".tr,
                                label: "password_label".tr,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: theme.colorScheme.primary,
                                  size: 18.sp,
                                ),
                                obscureText: true,
                                Mycontroller: controller.password,
                                validator: (value) =>
                                    myValidator(value, 8, 50, "password"),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: double.infinity,
                                height: 7.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.sp,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.verifyPassword();
                                    }
                                  },
                                  child: Text(
                                    "send_btn".tr,
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
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                return controller.isLoading.value
                    ? Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              color: isDark
                                  ? Colors.black54
                                  : Colors.black.withOpacity(0.3),
                            ),
                          ),
                          const Center(child: Loading()),
                        ],
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
