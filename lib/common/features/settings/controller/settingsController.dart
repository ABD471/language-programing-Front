import 'package:apartment_rental_system/common/features/settings/controller/logoutController.dart';

import 'package:apartment_rental_system/common/features/settings/screen/edit_language_page.dart';

import 'package:apartment_rental_system/common/features/settings/screen/edit_theme_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'verifyPasswrodrequiredController.dart';

abstract class SettingsController extends GetxController {
  void changePassword();
  void updateProfile(BuildContext context);
  void changePhoneNumber();
  void changeEmail();
  void onTapModeSettings();
  void onTapLogout();
  void onTapLanguageSettings();
  void onTapNotificationSettings();
}

class SettingsControllerImpl extends SettingsController {
  VerifyPasswordRequiredController get authController =>
      Get.find<VerifyPasswordRequiredController>();

  void _navigateWithAuth(String routeName) {
    Get.toNamed("/authPasswordRequierdPage", arguments: {"next": routeName});
  }

  // -------------------- Overrides --------------------
  @override
  void changePassword() {
    _navigateWithAuth("/editPasswordPage");
  }

  @override
  void changePhoneNumber() {
    _navigateWithAuth("/editPhonePage");
  }

  @override
  void changeEmail() {
    _navigateWithAuth("/editEmailPage");
  }

  @override
  void updateProfile(BuildContext context) {
    Get.toNamed("/editprofilepage");
  }

  @override
  void onTapLanguageSettings() {
    // TODO: implement onTapLanguageSettings
    Get.to(() => LanguageSelectionCardPage());
  }

  @override
  void onTapLogout() async {
    Get.find<LogoutController>().logout();
  }

  @override
  void onTapModeSettings() {
    // TODO: implement onTapModeSettings
    Get.to(() => ThemeSelectionPage());
  }

  @override
  void onTapNotificationSettings() {
    // TODO: implement onTapNotificationSettings
  }
}
