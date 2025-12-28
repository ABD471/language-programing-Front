import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/Chat/controller/chatController.dart';

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
  final chatController = Get.find<ChatController>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // جلب الرسائل القديمة عند فتح الصفحة
    chatController.fetchMessages(widget.receiverId);
    // الاشتراك في Pusher للاستماع للرسائل الجديدة
    chatController.subscribeToChatStream(widget.currentUserId);

    // التمرير للأسفل تلقائياً عند إضافة رسالة جديدة
    chatController.messages.listen((_) {
      if (_scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.receiverName, style: TextStyle(fontSize: 14.sp)),
        backgroundColor: isDark
            ? Colors.black26
            : Colors.white.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (chatController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    top: kToolbarHeight + 7.h,
                    bottom: 2.h,
                    left: 4.w,
                    right: 4.w,
                  ),
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.messages[index];
                    // نحدد إذا كانت الرسالة لي بناءً على الـ senderId
                    bool isMe = message.senderId == widget.currentUserId;
                    return _buildChatBubble(
                      isMe,
                      message.message ?? "",
                      theme,
                      isDark,
                    );
                  },
                );
              }),
            ),
            _buildMessageInput(context, _messageController, theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(
    bool isMe,
    String text,
    ThemeData theme,
    bool isDark,
  ) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
        constraints: BoxConstraints(maxWidth: 75.w),
        decoration: BoxDecoration(
          color: isMe
              ? theme.primaryColor
              : (isDark ? Colors.grey[800] : Colors.white.withOpacity(0.9)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
            bottomLeft: isMe ? Radius.circular(15.sp) : Radius.zero,
            bottomRight: isMe ? Radius.zero : Radius.circular(15.sp),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe
                ? Colors.white
                : (isDark ? Colors.white : Colors.black87),
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    TextEditingController controller,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey[900]?.withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  hintText: "اكتب رسالة...".tr,
                  hintStyle: TextStyle(fontSize: 11.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.sp),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.black45 : Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () {
                if (controller.text.trim().isNotEmpty) {
                  chatController.sendMessage(
                    widget.receiverId,
                    controller.text,
                    widget.currentUserId,
                  );
                  controller.clear();
                }
              },
              child: CircleAvatar(
                backgroundColor: theme.primaryColor,
                radius: 22.sp,
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
