import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/common/features/settings/controller/logoutController.dart';
import 'package:apartment_rental_system/common/features/settings/controller/settingsController.dart';
import 'package:apartment_rental_system/common/features/settings/widget/sectionTitle.dart';
import 'package:apartment_rental_system/common/features/settings/widget/settingsTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final SettingsControllerImpl controller = Get.put(SettingsControllerImpl());
  final LogoutController controllerLogout = Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings".tr,
          style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 16.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: theme.iconTheme,
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(4.w),
            children: [
              sectionTitle("profile".tr),
              settingsTile(
                icon: Icons.person_outline,
                title: "edit_profile".tr,
                onTap: () => controller.updateProfile(context),
              ),
              settingsTile(
                icon: Icons.phone_android_outlined,
                title: "change_phone".tr,
                onTap: () => controller.changePhoneNumber(),
              ),
              settingsTile(
                icon: Icons.email_outlined,
                title: "change_email".tr,
                onTap: () => controller.changeEmail(),
              ),
              SizedBox(height: 2.5.h),

              sectionTitle("security".tr),
              settingsTile(
                icon: Icons.lock_outline,
                title: "change_password".tr,
                onTap: () => controller.changePassword(),
              ),
              settingsTile(
                icon: Icons.security_outlined,
                title: "two_step_verification".tr,
                onTap: () {},
              ),
              SizedBox(height: 2.5.h),

              sectionTitle("app".tr),
              settingsTile(
                icon: Icons.language_outlined,
                title: "language".tr,
                onTap: () => controller.onTapLanguageSettings(),
              ),
              settingsTile(
                icon: Icons.dark_mode_outlined,
                title: "dark_mode".tr,
                onTap: () => controller.onTapModeSettings(),
              ),
              settingsTile(
                icon: Icons.notifications_none_outlined,
                title: "notifications".tr,
                onTap: () => controller.onTapNotificationSettings(),
              ),
              SizedBox(height: 2.5.h),

              sectionTitle("general".tr),
              settingsTile(
                icon: Icons.help_outline,
                title: "help_center".tr,
                onTap: () {},
              ),
              settingsTile(
                icon: Icons.privacy_tip_outlined,
                title: "privacy_policy".tr,
                onTap: () {},
              ),
              Obx(
                () => settingsTile(
                  icon: Icons.logout,
                  title: "logout".tr,
                  color: Colors.redAccent,
                  onTap: () => controller.onTapLogout(),
                  trailing: controllerLogout.isLoading.value
                      ? SizedBox(
                          width: 5.w,
                          height: 5.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(Icons.arrow_forward_ios, size: 14.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
