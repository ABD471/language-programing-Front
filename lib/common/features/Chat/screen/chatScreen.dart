import 'package:apartment_rental_system/common/features/Chat/controller/ChatController.dart';
import 'package:apartment_rental_system/common/features/Chat/model/messageModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';

class ChatScreen extends StatefulWidget {
  final int receiverId;
  final String receiverName;
  final int currentUserId;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.currentUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.find<ChatController>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController.fetchMessages(widget.receiverId, widget.currentUserId);
    chatController.setupChatStreams(widget.currentUserId, widget.receiverId);
    chatController.markMessagesAsRead(widget.receiverId);

    chatController.messages.listen((_) {
      if (_scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.receiverName,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Obx(
              () => Text(
                chatController.isOnline.value ? "online".tr : "offline".tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: chatController.isOnline.value
                      ? Colors.greenAccent
                      : Colors.white70,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(
                    chatController.messages[index],
                    isDark,
                  );
                },
              );
            }),
          ),
          _buildInputArea(isDark, theme),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isDark) {
    bool isMe = message.senderId == widget.currentUserId;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 2.w),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 75.w),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
            decoration: BoxDecoration(
              color: isMe
                  ? AppTheme.primary
                  : (isDark ? Colors.grey[850] : Colors.grey[200]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp),
                bottomLeft: isMe ? Radius.circular(12.sp) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(12.sp),
              ),
            ),
            child: Text(
              message.message ?? "",
              style: TextStyle(
                color: isMe
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
                fontSize: 14.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h, left: 1.w, right: 1.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isMe) ...[_buildStatusIcon(message), SizedBox(width: 1.w)],
                Text(
                  message.createdAt != null && message.createdAt!.length > 16
                      ? message.createdAt!.substring(11, 16)
                      : "",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(MessageModel message) {
    if (message.isFailed == true) {
      return Icon(Icons.error_outline, size: 11.sp, color: Colors.redAccent);
    }
    if (message.status == 2) {
      return Icon(Icons.done_all, size: 12.sp, color: Colors.blueAccent);
    }
    if (message.status == 1) {
      return Icon(Icons.done_all, size: 12.sp, color: Colors.grey);
    }
    return Icon(Icons.check, size: 11.sp, color: Colors.grey);
  }

  Widget _buildInputArea(bool isDark, ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 1.5.h,
        top: 1.5.h,
        left: 3.w,
        right: 3.w,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey[900]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey[100],
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: TextField(
                controller: _messageController,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: "type_message_hint".tr,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          GestureDetector(
            onTap: () {
              if (_messageController.text.trim().isNotEmpty) {
                chatController.sendMessage(
                  widget.receiverId,
                  _messageController.text,
                  widget.currentUserId,
                );
                _messageController.clear();
              }
            },
            child: CircleAvatar(
              radius: 20.sp,
              backgroundColor: AppTheme.primary,
              child: Icon(Icons.send_rounded, color: Colors.white, size: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
