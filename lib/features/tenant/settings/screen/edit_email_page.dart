import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/features/tenant/settings/controller/editEmailController.dart';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EditEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Editemailcontroller());
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0.4,
          centerTitle: true,
          title: Text("edit_email".tr, style: theme.appBarTheme.titleTextStyle),
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
                        Icons.email_outlined,
                        size: 100,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(height: 32),
                      Text(
                        "edit_email_desc".tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 38),
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
                              ),
                              obscureText: false,
                              Mycontroller: controller.email,
                              validator: (value) =>
                                  myValidator(value, 8, 100, "email"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 53,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.updateEmail();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  "save_btn".tr,
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
