import 'dart:ui';
import 'package:flutter/material.dart';

class CustomGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  
  // باراميترات جديدة للأيقونة
  final IconData? notificationIcon; 
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications; // للتحكم في ظهور نقطة التنبيه

  const CustomGlassAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.bottom,
    this.notificationIcon, // اختياري
    this.onNotificationTap, // اختياري
    this.hasUnreadNotifications = false, // افتراضياً لا يوجد
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // تجهيز قائمة الـ Actions لتشمل أيقونة الإشعارات إذا تم تمريرها
    List<Widget> finalActions = actions ?? [];
    if (notificationIcon != null) {
      finalActions.insert(
        0, // وضعها في البداية قبل أي actions أخرى
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(notificationIcon),
              onPressed: onNotificationTap,
            ),
            if (hasUnreadNotifications)
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.white.withOpacity(0.4),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.grey.withOpacity(0.3),
                width: 2.0,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              title,
              style: theme.appBarTheme.titleTextStyle?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 0.8,
              ),
            ),
            actions: finalActions, // نستخدم القائمة المعدلة هنا
            bottom: bottom,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0) + 10,
      );
}