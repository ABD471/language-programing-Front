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
    margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
    decoration: BoxDecoration(
      // تحسين الألوان للثيمين
      color: item.isRead
          ? (isDark ? Colors.black26 : Colors.white.withOpacity(0.6))
          : (isDark
                ? Colors.blueGrey.withOpacity(0.3)
                : Colors.white.withOpacity(0.9)),
      borderRadius: BorderRadius.circular(15.sp),
      boxShadow: [
        if (!isDark)
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
      ],
      border: Border.all(
        color: item.isRead
            ? Colors.transparent
            : theme.primaryColor.withOpacity(0.3),
        width: 1,
      ),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      leading: CircleAvatar(
        backgroundColor: item.isRead
            ? theme.disabledColor.withOpacity(0.1)
            : theme.primaryColor.withOpacity(0.1),
        child: Icon(
          item.isRead ? Icons.notifications_none : Icons.notifications_active,
          color: item.isRead ? theme.disabledColor : theme.primaryColor,
          size: 20.sp,
        ),
      ),
      title: Text(
        item.title ?? "",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      subtitle: Text(
        item.message ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          fontSize: 14.sp,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeago.format(item.createdAt!, locale: 'ar'),
            style: TextStyle(fontSize: 12.sp, color: theme.hintColor),
          ),
          if (!item.isRead)
            Container(
              margin: EdgeInsets.only(top: 0.8.h),
              width: 2.w,
              height: 2.w,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                shape: BoxShape.circle,
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
