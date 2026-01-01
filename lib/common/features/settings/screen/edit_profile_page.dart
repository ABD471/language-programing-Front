import 'dart:ui';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/common/features/settings/controller/editProfileController.dart';
import 'package:apartment_rental_system/common/features/settings/widget/profile/ProfileCard.dart';
import 'package:apartment_rental_system/common/features/settings/widget/profile/buildform.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileControllerImpl());
  final _formKey = GlobalKey<FormState>();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent, // تم التعديل ليتناسب مع الخلفية
          centerTitle: true,
          elevation: 0,
          title: Text(
            "edit_profile".tr,
            style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 16.sp),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: Loading());
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    Obx(
                      () => ProfileCard(
                        onTap: (isProfile) async {
                          await controller.pickImage(isProfile);
                        },
                        profileData: controller.profileData,
                        profileImageFile: controller.profileImageFile.value,
                        theme: theme,
                      ),
                    ),

                    SizedBox(height: 3.h),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Costumfiledtext(
                            hintText: "new_first_name_hint".tr,
                            label: "new_first_name_label".tr,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: theme.colorScheme.primary,
                              size: 18.sp,
                            ),
                            obscureText: false,
                            Mycontroller: controller.firstNameController,
                            validator: (value) =>
                                myValidator(value, 3, 100, "username"),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 2.h),
                          Costumfiledtext(
                            hintText: "new_last_name_hint".tr,
                            label: "new_last_name_label".tr,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: theme.colorScheme.primary,
                              size: 18.sp,
                            ),
                            obscureText: false,
                            Mycontroller: controller.lastNameController,
                            validator: (value) =>
                                myValidator(value, 3, 100, "username"),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 2.h),
                          buildField(
                            controller: controller.dobController,
                            label: "dob_label".tr,
                            readOnly: true,
                            context: context,
                            onTap: controller.pickDate,
                          ),
                          SizedBox(height: 4.h),

                          SizedBox(
                            width: double.infinity,
                            height: 7.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.saveProfile();
                                }
                              },
                              child: Text(
                                "save_btn".tr,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),

              Obx(
                () => controller.isLoading.value
                    ? Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ),
                          const Center(child: Loading()),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
