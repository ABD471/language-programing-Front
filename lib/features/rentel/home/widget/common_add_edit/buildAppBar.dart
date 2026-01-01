import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final IconData? notificationIcon;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications;

  const CustomGlassAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.bottom,
    this.notificationIcon,
    this.onNotificationTap,
    this.hasUnreadNotifications = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    List<Widget> finalActions = actions ?? [];
    if (notificationIcon != null) {
      finalActions.insert(
        0,
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(notificationIcon, size: 22.sp),
              onPressed: onNotificationTap,
            ),
            if (hasUnreadNotifications)
              Positioned(
                right: 3.w,
                top: 1.5.h,
                child: Container(
                  width: 2.5.w,
                  height: 2.5.w,
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
                width: 0.5.w,
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
                fontSize: 17.sp,
                letterSpacing: 0.8,
              ),
            ),
            actions: finalActions,
            bottom: bottom,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0) + 1.2.h,
  );
}
