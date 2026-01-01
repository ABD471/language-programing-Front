import 'dart:ui';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/auth/controller/registerAccountcontroller.dart';
import 'package:apartment_rental_system/helper/const/role.dart';
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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "create_account".tr,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
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
              Container(color: Colors.black.withOpacity(0.1)),
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_rounded,
                        color: Colors.white,
                        size: 15.w,
                      ),
                      SizedBox(height: 2.h),
                      AnimatedAuthCard(
                        color: isDark
                            ? Colors.black.withOpacity(0.6)
                            : Colors.white.withOpacity(0.9),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // حقل اختيار الدور (Role Selection)
                              _buildRoleDropdown(controller, theme, isDark),

                              SizedBox(height: 2.h),

                              Costumfiledtext(
                                hintText: "phone_hint".tr,
                                prefixIcon: Icon(
                                  Icons.phone_iphone_rounded,
                                  color: theme.primaryColor,
                                ),
                                Mycontroller: controller.phone,
                                label: "phone".tr,
                                validator: (value) =>
                                    myValidator(value!, 8, 25, "phone"),
                                obscureText: false,
                              ),

                              SizedBox(height: 2.h),

                              Costumfiledtext(
                                hintText: "email_hint".tr,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: theme.primaryColor,
                                ),
                                Mycontroller: controller.email,
                                label: "email".tr,
                                validator: (value) =>
                                    myValidator(value!, 8, 70, "email"),
                                obscureText: false,
                              ),

                              SizedBox(height: 2.h),

                              Obx(
                                () => Costumfiledtext(
                                  hintText: "password_hint".tr,
                                  prefixIcon: Icon(
                                    Icons.lock_open_rounded,
                                    color: theme.primaryColor,
                                  ),
                                  Mycontroller: controller.password,
                                  label: "password".tr,
                                  validator: (value) =>
                                      myValidator(value!, 8, 25, "password"),
                                  obscureText: controller.obscurePassword.value,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: theme.primaryColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                    onPressed: () =>
                                        controller.obscurePassword.toggle(),
                                  ),
                                ),
                              ),

                              SizedBox(height: 2.h),

                              Obx(
                                () => Costumfiledtext(
                                  hintText: "confirm_password_hint".tr,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: theme.primaryColor,
                                  ),
                                  Mycontroller:
                                      controller.password_confirmation,
                                  label: "confirm_password".tr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return "confirm_password_hint".tr;
                                    if (value != controller.password.text)
                                      return "password_not_match".tr;
                                    return null;
                                  },
                                  obscureText: controller.obscureConfirm.value,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscureConfirm.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: theme.primaryColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                    onPressed: () =>
                                        controller.obscureConfirm.toggle(),
                                  ),
                                ),
                              ),

                              SizedBox(height: 4.h),

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
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.sp,
                                      ),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "signup".tr,
                                    style: TextStyle(
                                      fontSize: 14.sp,
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
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => controller.onLogin(),
                                    child: Text(
                                      "login".tr,
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRoleDropdown(
    RegisterAccountcontroller controller,
    ThemeData theme,
    bool isDark,
  ) {
    return Obx(
      () => DropdownButtonFormField<UserRole>(
        value: controller.selectedRole.value,
        decoration: InputDecoration(
          labelText: "select_role".tr,
          labelStyle: TextStyle(color: theme.primaryColor, fontSize: 15.sp),
          prefixIcon: Icon(Icons.badge_outlined, color: theme.primaryColor),
          filled: true,
          fillColor: isDark ? Colors.white10 : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
        ),

        items: [
          DropdownMenuItem(
            value: UserRole.tenant,
            child: Text("tenant_role".tr),
          ),
          DropdownMenuItem(
            value: UserRole.rental,
            child: Text("owner_role".tr),
          ),
        ],
        onChanged: (UserRole? value) {
          if (value != null) {
            controller.setRole(value);
          }
        },
        validator: (value) => value == null ? "role_required_error".tr : null,
        dropdownColor: isDark ? Colors.grey[900] : Colors.white,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}
