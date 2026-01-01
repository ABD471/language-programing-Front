import 'package:apartment_rental_system/common/features/Chat/controller/chat_box_controller.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ChatBoxScreen extends StatelessWidget {
  final controller = Get.put(ChatBoxController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "chats_title".tr,
          style: theme.appBarTheme.titleTextStyle?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingShimmer(isDark);
        }

        if (controller.conversations.isEmpty) {
          return _buildEmptyState(isDark, theme);
        }

        return RefreshIndicator(
          onRefresh: () => controller.getChatList(),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 1.h),
            itemCount: controller.conversations.length,
            itemBuilder: (context, index) {
              final chat = controller.conversations[index];
              final Map<String, dynamic>? otherUser = chat.otherUser;

              bool isOnline = chat.isOnline ?? false;
              int unreadCount = chat.unreadCount ?? 0;
              String lastMessage = chat.lastMessage ?? chat.message ?? "";

              return InkWell(
                onTap: () => Get.toNamed(
                  '/chatScreen',
                  arguments: {
                    'receiverId': otherUser?['id'],
                    'receiverName': otherUser?['name'],
                    'currentUserId': int.parse(AuthService.userId!),
                  },
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 26.sp,
                            backgroundColor: theme.colorScheme.primary
                                .withOpacity(0.1),
                            child: Text(
                              otherUser?['name']?[0].toUpperCase() ?? "?",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          if (isOnline)
                            Positioned(
                              bottom: 0.5.h,
                              right: 0.5.w,
                              child: Container(
                                width: 12.sp,
                                height: 12.sp,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDark
                                        ? theme.scaffoldBackgroundColor
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  otherUser?['name'] ?? "user".tr,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: unreadCount > 0
                                        ? FontWeight.bold
                                        : FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF1A1A1A),
                                  ),
                                ),
                                Text(
                                  _formatChatTime(chat.createdAt),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: unreadCount > 0
                                        ? theme.colorScheme.primary
                                        : theme.hintColor,
                                    fontWeight: unreadCount > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: unreadCount > 0
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: unreadCount > 0
                                          ? (isDark
                                                ? Colors.white70
                                                : Colors.black87)
                                          : theme.hintColor,
                                    ),
                                  ),
                                ),
                                if (unreadCount > 0)
                                  Container(
                                    margin: EdgeInsets.only(left: 2.w),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 0.4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(
                                        10.sp,
                                      ),
                                    ),
                                    child: Text(
                                      unreadCount > 9
                                          ? "+9"
                                          : unreadCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(bool isDark, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 60.sp,
            color: isDark ? theme.hintColor.withOpacity(0.2) : Colors.grey[300],
          ),
          SizedBox(height: 2.h),
          Text(
            "no_chats".tr,
            style: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.grey,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDark) {
    return ListView.builder(
      itemCount: 8,
      padding: EdgeInsets.all(4.w),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2.5.h),
          child: Row(
            children: [
              CircleAvatar(radius: 26.sp, backgroundColor: Colors.white),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 1.5.h, width: 30.w, color: Colors.white),
                    SizedBox(height: 1.h),
                    Container(
                      height: 1.2.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatChatTime(String? dateStr) {
    if (dateStr == null) return "";
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      DateTime now = DateTime.now();

      if (date.day == now.day &&
          date.month == now.month &&
          date.year == now.year) {
        return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
      } else if (date.day == now.subtract(const Duration(days: 1)).day) {
        return "yesterday".tr;
      } else {
        return "${date.day}/${date.month}";
      }
    } catch (e) {
      return "";
    }
  }
}
