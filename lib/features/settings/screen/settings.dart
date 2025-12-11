import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/settings/controller/settingsController.dart';
import 'package:apartment_rental_system/features/settings/widget/sectionTitle.dart';
import 'package:apartment_rental_system/features/settings/widget/settingsTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final SettingsControllerImpl controller = Get.put(SettingsControllerImpl());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        elevation: 3,
        foregroundColor: Colors.black,
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            sectionTitle("profile".tr),
            settingsTile(
              Icons.person,
              "edit_profile".tr,
              onTap: () {
                controller.updateProfile(context);
              },
            ),
            settingsTile(
              Icons.phone,
              "change_phone".tr,
              onTap: () {
                controller.changePhoneNumber();
              },
            ),
            settingsTile(
              Icons.email,
              "change_email".tr,
              onTap: () {
                controller.changeEmail();
              },
            ),
            const SizedBox(height: 20),
            sectionTitle("security".tr),
            settingsTile(
              Icons.lock,
              "change_password".tr,
              onTap: () {
                controller.changePassword();
              },
            ),
            settingsTile(
              Icons.security,
              "two_step_verification".tr,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            sectionTitle("app".tr),
            settingsTile(
              Icons.language,
              "language".tr,
              onTap: () {
                controller.onTapLanguageSettings();
              },
            ),
            settingsTile(
              Icons.dark_mode,
              "dark_mode".tr,
              onTap: () {
                controller.onTapModeSettings();
              },
            ),
            settingsTile(
              Icons.notifications,
              "notifications".tr,
              onTap: () {
                controller.onTapNotificationSettings();
              },
            ),
            const SizedBox(height: 20),
            sectionTitle("general".tr),
            settingsTile(Icons.help_center, "help_center".tr, onTap: () {}),
            settingsTile(Icons.privacy_tip, "privacy_policy".tr, onTap: () {}),
            settingsTile(
              Icons.logout,
              "logout".tr,
              color: Colors.red,
              onTap: () {
                controller.onTapLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
