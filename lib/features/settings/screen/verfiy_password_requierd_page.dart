import 'dart:ui';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/widget/CostumFieldTExt.dart';
import 'package:apartment_rental_system/common/widget/costum_animated_auth_card.dart';
import 'package:apartment_rental_system/common/widget/loading/loading.dart';
import 'package:apartment_rental_system/features/settings/controller/verifyPasswrodrequiredController.dart';
import 'package:apartment_rental_system/helper/funcations/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPasswordRequierdPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AuthPasswordRequierdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyPasswordRequiredController>();
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        controller.password.clear();
        return true;
      },
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: 0.4,
            centerTitle: true,
            title: Text(
              "auth_password".tr,
              style: theme.appBarTheme.titleTextStyle,
            ),
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
                          Icons.lock_outline,
                          size: 100,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(height: 32),
                        Text(
                          "auth_password_msg".tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 38),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Costumfiledtext(
                                hintText: "enter_password".tr,
                                label: "password_label".tr,
                                IconData: Icon(
                                  Icons.lock_outline,
                                  color: theme.colorScheme.primary,
                                ),
                                obscureText: true,
                                Mycontroller: controller.password,
                                validator: (value) =>
                                    myValidator(value, 8, 50, "password"),
                                keyboardType: TextInputType.text,
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
                                      controller.verifyPassword();
                                    }
                                  },
                                  child: Text(
                                    "send_btn".tr,
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
      ),
    );
  }
}
