import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/common/features/settings/controller/editEmailController.dart';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EditEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Editemailcontroller());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "edit_email".tr,
            style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 16.sp),
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
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.alternate_email_rounded,
                          size: 50.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "edit_email_desc".tr,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Costumfiledtext(
                              hintText: "enter_new_email".tr,
                              label: "new_email_label".tr,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: theme.colorScheme.primary,
                                size: 18.sp,
                              ),
                              obscureText: false,
                              Mycontroller: controller.email,
                              validator: (value) =>
                                  myValidator(value, 8, 100, "email"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 4.h),
                            SizedBox(
                              width: double.infinity,
                              height: 7.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.updateEmail();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                ),
                                child: Text(
                                  "save_btn".tr,
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
                      SizedBox(height: 1.h),
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
    );
  }
}
