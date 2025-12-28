import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/tenant/settings/controller/logoutController.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/verfiy_password_requierd_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_language_page.dart';

import 'package:apartment_rental_system/features/tenant/settings/screen/edit_theme_page.dart';
import 'package:apartment_rental_system/helper/const/requestType.dart';
import 'package:apartment_rental_system/util/Binding/verify_password_binding.dart';

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

  // -------------------- Helper function --------------------
  void _navigateWithAuth(String routeName) {
    Get.toNamed("/authPasswordRequierdPage", arguments: {"next": routeName});
  }

  // -------------------- Overrides --------------------
  @override
  void changePassword() {
    // قبل تغيير كلمة المرور يجب التحقق
    _navigateWithAuth("/editPasswordPage");
  }

  @override
  void changePhoneNumber() {
    // قبل تغيير الهاتف يجب التحقق
    _navigateWithAuth("/editPhonePage");
  }

  @override
  void changeEmail() {
    // قبل تغيير الإيميل يجب التحقق
    _navigateWithAuth("/editEmailPage");
  }

  @override
  void updateProfile(BuildContext context) {
    // تعديل البروفايل العام يمكن بدون تحقق
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
