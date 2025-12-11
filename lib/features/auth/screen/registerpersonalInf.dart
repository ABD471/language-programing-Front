import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/auth/controller/registerpersonalInfController.dart';
import 'package:apartment_rental_system/features/auth/widget/cardprofile.dart';

import 'package:apartment_rental_system/features/auth/widget/nationaid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// افترض أنك لديك هذه الويجتس مسبقًا
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
                // الخلفية

                // طبقة شفافة خفيفة لتغميق الخلفية
                Container(color: Colors.black.withOpacity(0.3)),

                // الكارت المتحرك
                Center(
                  child: SingleChildScrollView(
                    child: AnimatedAuthCard(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            EmptyProfileCard(
                              onTap: () {
                                controller.pickImage(true);
                              },
                              profileImageFile:
                                  controller.profileImageFile.value,
                              theme: theme,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Create Profile",
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),

                            // First Name
                            Costumfiledtext(
                              hintText: "Enter first name",
                              IconData: const Icon(Icons.person_outline),
                              Mycontroller: controller.firstNameController,
                              label: "First Name",
                              validator: (value) =>
                                  myValidator(value, 2, 30, "text"),
                              obscureText: false,
                            ),
                            const SizedBox(height: 16),

                            // Last Name
                            Costumfiledtext(
                              hintText: "Enter last name",
                              IconData: const Icon(Icons.person_outline),
                              Mycontroller: controller.lastNameController,
                              label: "Last Name",
                              validator: (value) =>
                                  myValidator(value, 2, 30, "text"),
                              obscureText: false,
                            ),
                            const SizedBox(height: 16),

                            // Date of Birth
                            TextFormField(
                              controller: controller.dobController,
                              readOnly: true,
                              onTap: () {
                                controller.pickDate(context);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            nationAidProfileWidget(
                              nationalIdImageFile:
                                  controller.nationalIdImageFile.value,
                              pickImage: (isProfile) async {
                                await controller.pickImage(false);
                              },
                              theme: theme,
                            ),
                            const SizedBox(height: 24),

                            // زر حفظ البيانات
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.savePersonalInfo(context);
                                }
                              },
                              style: theme.elevatedButtonTheme.style,
                              child: const Text(
                                "Save Profile",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
        }
      }),
    );
  }
}
