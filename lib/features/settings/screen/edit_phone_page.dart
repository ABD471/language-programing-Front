import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/features/settings/controller/editPhoneController.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhonePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EditPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditPhoneController());
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0.4,
          centerTitle: true,
          title: Text("edit_phone".tr, style: theme.appBarTheme.titleTextStyle),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(18),
              child: Center(
                child: AnimatedAuthCard(
                  child: Column(
                    children: [
                      Icon(
                        Icons.phone_android_rounded,
                        size: 100,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(height: 32),
                      Text(
                        "edit_phone_desc".tr,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 38),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Costumfiledtext(
                              hintText: "new_phone_hint".tr,
                              label: "new_phone_label".tr,
                              IconData: Icon(
                                Icons.phone_android_outlined,
                                color: theme.colorScheme.primary,
                              ),
                              obscureText: false,
                              Mycontroller: controller.phone,
                              validator: (value) =>
                                  myValidator(value, 10, 14, "phone"),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: 30),
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
                                    controller.updatePhone();
                                  }
                                },
                                child: Text(
                                  "save".tr,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
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
                          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                        const Center(child: Loading()),
                      ],
                    )
                  : SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
