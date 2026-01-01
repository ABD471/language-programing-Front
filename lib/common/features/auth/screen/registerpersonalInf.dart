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
          "create_profile".tr,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
       
              Container(color: Colors.black.withOpacity(0.15)),

              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Column(
                      children: [
                        AnimatedAuthCard(
                          color: isDark
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.92),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            
                                EmptyProfileCard(
                                  onTap: () => controller.pickImage(true),
                                  profileImageFile:
                                      controller.profileImageFile.value,
                                  theme: theme,
                                ),

                                SizedBox(height: 4.h),

                
                                Costumfiledtext(
                                  hintText: "first_name_hint".tr,
                                  prefixIcon: const Icon(
                                    Icons.person_outline_rounded,
                                  ),
                                  Mycontroller: controller.firstNameController,
                                  label: "first_name".tr,
                                  validator: (value) =>
                                      myValidator(value!, 2, 30, "text"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.5.h),

                             
                                Costumfiledtext(
                                  hintText: "last_name_hint".tr,
                                  prefixIcon: const Icon(
                                    Icons.person_outline_rounded,
                                  ),
                                  Mycontroller: controller.lastNameController,
                                  label: "last_name".tr,
                                  validator: (value) =>
                                      myValidator(value!, 2, 30, "text"),
                                  obscureText: false,
                                ),

                                SizedBox(height: 2.5.h),

                                
                                GestureDetector(
                                  onTap: () => controller.pickDate(context),
                                  child: AbsorbPointer(
                                    child: Costumfiledtext(
                                      hintText: "dob_hint".tr,
                                      prefixIcon: const Icon(
                                        Icons.calendar_month_outlined,
                                      ),
                                      Mycontroller: controller.dobController,
                                      label: "dob".tr,
                                      validator: (value) =>
                                          myValidator(value!, 0, 0, ""),
                                      obscureText: false,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 3.h),

                            
                                nationAidProfileWidget(
                                  nationalIdImageFile:
                                      controller.nationalIdImageFile.value,
                                  pickImage: (isProfile) async =>
                                      await controller.pickImage(false),
                                  theme: theme,
                                ),

                                SizedBox(height: 4.h),

                            
                                SizedBox(
                                  width: double.infinity,
                                  height: 6.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.savePersonalInfo(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: Text(
                                      "save_profile".tr,
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
                      ],
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
