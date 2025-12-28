import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/tenant/settings/controller/logoutController.dart';
import 'package:apartment_rental_system/features/tenant/settings/controller/settingsController.dart';
import 'package:apartment_rental_system/features/tenant/settings/widget/sectionTitle.dart';
import 'package:apartment_rental_system/features/tenant/settings/widget/settingsTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final SettingsControllerImpl controller = Get.put(SettingsControllerImpl());
  final LogoutController controllerLogout = Get.put(LogoutController());

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
              icon: Icons.person,
              title: "edit_profile".tr,
              onTap: () {
                controller.updateProfile(context);
              },
            ),
            settingsTile(
              icon: Icons.phone,
              title: "change_phone".tr,
              onTap: () {
                controller.changePhoneNumber();
              },
            ),
            settingsTile(
              icon: Icons.email,
              title: "change_email".tr,
              onTap: () {
                controller.changeEmail();
              },
            ),
            const SizedBox(height: 20),
            sectionTitle("security".tr),
            settingsTile(
              icon: Icons.lock,
              title: "change_password".tr,
              onTap: () {
                controller.changePassword();
              },
            ),
            settingsTile(
              icon: Icons.security,
              title: "two_step_verification".tr,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            sectionTitle("app".tr),
            settingsTile(
              icon: Icons.language,
              title: "language".tr,
              onTap: () {
                controller.onTapLanguageSettings();
              },
            ),
            settingsTile(
              icon: Icons.dark_mode,
              title: "dark_mode".tr,
              onTap: () {
                controller.onTapModeSettings();
              },
            ),
            settingsTile(
              onTap: () {
                controller.onTapNotificationSettings();
              },
              icon: Icons.notifications,
              title: "notifications".tr,
            ),
            const SizedBox(height: 20),
            sectionTitle("general".tr),
            settingsTile(
              icon: Icons.help_center,
              title: "help_center".tr,
              onTap: () {},
            ),
            settingsTile(
              icon: Icons.privacy_tip,
              title: "privacy_policy".tr,
              onTap: () {},
            ),
            Obx(
              () => settingsTile(
                icon: Icons.logout,
                title: "logout".tr,
                color: Colors.red,
                onTap: () {
                  controller.onTapLogout();
                },
                trailing: controllerLogout.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
