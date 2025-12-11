import 'dart:ui';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/features/settings/controller/editProfileController.dart';
import 'package:apartment_rental_system/features/settings/widget/profile/ProfileCard.dart';
import 'package:apartment_rental_system/features/settings/widget/profile/buildform.dart';

import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          backgroundColor: theme.appBarTheme.backgroundColor,
          centerTitle: true,
          elevation: 0.4,
          title: Text(
            "edit_profile".tr,
            style: theme.appBarTheme.titleTextStyle,
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: Loading());
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    // Profile Card
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

                    SizedBox(height: 28),

                    // Form Fields
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Costumfiledtext(
                            hintText: "new_first_name_hint".tr,
                            label: "new_first_name_label".tr,
                            IconData: Icon(
                              Icons.person,
                              color: theme.colorScheme.primary,
                            ),
                            obscureText: false,
                            Mycontroller: controller.firstNameController,
                            validator: (value) =>
                                myValidator(value, 3, 100, "username"),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 18),
                          Costumfiledtext(
                            hintText: "new_last_name_hint".tr,
                            label: "new_last_name_label".tr,
                            IconData: Icon(
                              Icons.person,
                              color: theme.colorScheme.primary,
                            ),
                            obscureText: false,
                            Mycontroller: controller.lastNameController,
                            validator: (value) =>
                                myValidator(value, 3, 100, "username"),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 18),
                          buildField(
                            controller: controller.dobController,
                            label: "dob_label".tr,
                            readOnly: true,
                            context: context,
                            onTap: controller.pickDate,
                          ),
                          SizedBox(height: 30),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            height: 53,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.saveProfile();
                                }
                              },
                              child: Text(
                                "save".tr,
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),

              // Loading Overlay
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
                    : SizedBox.shrink(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
