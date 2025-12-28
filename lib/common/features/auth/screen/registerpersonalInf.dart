import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/auth/controller/registerpersonalInfController.dart';
import 'package:apartment_rental_system/common/features/auth/widget/cardprofile.dart';
import 'package:apartment_rental_system/common/features/auth/widget/nationaid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// Widgets
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';

class Registerpersonalinf extends StatelessWidget {
  const Registerpersonalinf({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final registerPersonalInfoControllerImpl controller = Get.put(
      registerPersonalInfoControllerImpl(),
    );

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "create_profile".tr,
          style: theme.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      backgroundColor: theme.scaffoldBackgroundColor,

      body: Obx(() {
        return controller.isloading.value
            ? Center(
                child: Lottie.asset(
                  'assets/lottie/Loading.json',
                  height: 25.h,
                  width: 25.w,
                ),
              )
            : GradientBackground(
                child: Stack(
                  children: [
                    Container(color: Colors.black.withOpacity(0.28)),

                    Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(5.w),
                        child: AnimatedAuthCard(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // *************** Profile Image ***************
                                EmptyProfileCard(
                                  onTap: () => controller.pickImage(true),
                                  profileImageFile:
                                      controller.profileImageFile.value,
                                  theme: theme,
                                ),

                                SizedBox(height: 3.h),

                                // *************** First Name ***************
                                Costumfiledtext(
                                  hintText: "first_name_hint".tr,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  Mycontroller: controller.firstNameController,
                                  label: "first_name".tr,
                                  validator: (value) =>
                                      myValidator(value, 2, 30, "text"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.h),

                                // *************** Last Name ***************
                                Costumfiledtext(
                                  hintText: "last_name_hint".tr,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  Mycontroller: controller.lastNameController,
                                  label: "last_name".tr,
                                  validator: (value) =>
                                      myValidator(value, 2, 30, "text"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.h),

                                // *************** Date of Birth ***************
                                GestureDetector(
                                  onTap: () => controller.pickDate(context),
                                  child: AbsorbPointer(
                                    child: Costumfiledtext(
                                      hintText: "dob".tr,
                                      prefixIcon: const Icon(
                                        Icons.calendar_today,
                                      ),
                                      Mycontroller: controller.dobController,
                                      label: "dob".tr,
                                      validator: (value) {
                                        return myValidator(value, 0, 0, "");
                                      },
                                      obscureText: false,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                // *************** National ID Upload ***************
                                nationAidProfileWidget(
                                  nationalIdImageFile:
                                      controller.nationalIdImageFile.value,
                                  pickImage: (isProfile) async =>
                                      await controller.pickImage(false),
                                  theme: theme,
                                ),

                                SizedBox(height: 3.h),

                                // *************** Save Button ***************
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.savePersonalInfo(context);
                                      }
                                    },
                                    style: theme.elevatedButtonTheme.style,
                                    child: Text(
                                      "save_profile".tr,
                                      style: TextStyle(
                                        fontSize: 15.sp,
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
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
