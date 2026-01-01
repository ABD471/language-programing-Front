import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildNotificationCard(
  BuildContext context,
  item,
  controller,
  ThemeData theme,
  bool isDark,
) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
    decoration: BoxDecoration(
      color: item.isRead
          ? (isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.white.withOpacity(0.4))
          : (isDark
                ? theme.primaryColor.withOpacity(0.15)
                : Colors.white.withOpacity(0.9)),
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(
        color: item.isRead
            ? (isDark ? Colors.white10 : Colors.transparent)
            : theme.primaryColor.withOpacity(0.4),
        width: 1,
      ),
      boxShadow: [
        if (!isDark)
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
      ],
    ),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
      leading: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: item.isRead
              ? theme.disabledColor.withOpacity(0.05)
              : theme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          item.isRead
              ? Icons.notifications_none_rounded
              : Icons.notifications_active_rounded,
          color: item.isRead ? theme.disabledColor : theme.primaryColor,
          size: 22.sp,
        ),
      ),
      title: Text(
        item.title ?? "",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: item.isRead ? FontWeight.w500 : FontWeight.bold,
          fontSize: 15.sp,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 0.5.h),
        child: Text(
          item.message ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13.sp,
            color: isDark ? Colors.white70 : Colors.black54,
            height: 1.3,
          ),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeago.format(item.createdAt!, locale: 'ar'),
            style: TextStyle(
              fontSize: 10.sp,
              color: theme.hintColor.withOpacity(0.7),
            ),
          ),
          if (!item.isRead)
            Container(
              margin: EdgeInsets.only(top: 1.h),
              width: 2.5.w,
              height: 2.5.w,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
      onTap: () {
        if (!item.isRead) controller.markAsRead(item.id!);
        if (item.bookingId != null) {
          Get.toNamed('/rentel-booking', arguments: item.bookingId);
        }
      },
    ),
  );
}
