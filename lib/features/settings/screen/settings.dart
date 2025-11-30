import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات"),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        elevation: 3,
        foregroundColor: Colors.black,
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle("الملف الشخصي"),
            _settingsTile(Icons.person, "تعديل البيانات الشخصية"),
            _settingsTile(Icons.phone, "تغيير رقم الهاتف"),
            _settingsTile(Icons.email, "تغيير البريد الإلكتروني"),
            const SizedBox(height: 20),
            _sectionTitle("الأمان"),
            _settingsTile(Icons.lock, "تغيير كلمة المرور"),
            _settingsTile(Icons.security, "التحقق بخطوتين"),
            const SizedBox(height: 20),
            _sectionTitle("التطبيق"),
            _settingsTile(Icons.language, "اللغة"),
            _settingsTile(Icons.dark_mode, "الوضع الليلي"),
            _settingsTile(Icons.notifications, "الإشعارات"),
            const SizedBox(height: 20),
            _sectionTitle("عام"),
            _settingsTile(Icons.help_center, "مركز المساعدة"),
            _settingsTile(Icons.privacy_tip, "سياسة الخصوصية"),
            _settingsTile(
              Icons.logout,
              "تسجيل خروج",
              color: Colors.red,
              onTap: () {
                // logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    Color? color,
    void Function()? onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.black87),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          onTap!();
        },
      ),
    );
  }
}
