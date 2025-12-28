import 'package:apartment_rental_system/features/rentel/Chat/controller/chat_box_controller.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBoxScreen extends StatelessWidget {
  // استدعاء المتحكم
  final controller = Get.put(ChatBoxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المحادثات"), centerTitle: true),
      body: Obx(() {
        // حالة التحميل
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // حالة القائمة الفارغة
        if (controller.conversations.isEmpty) {
          return const Center(child: Text("لا توجد محادثات حالياً"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.getChatList(),
          child: ListView.builder(
            itemCount: controller.conversations.length,
            itemBuilder: (context, index) {
              final chat = controller.conversations[index];

              // استخراج الماب الخاص بالمستخدم الآخر من الموديل
              final Map<String, dynamic>? otherUser = chat.otherUser;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    // نأخذ أول حرف من الاسم الموجود داخل الماب
                    otherUser?['name'] != null
                        ? otherUser!['name'][0].toUpperCase()
                        : "?",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  otherUser?['name'] ?? "مستخدم غير معروف",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chat.message ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  // عرض الوقت (ساعة:دقيقة) من السلسلة النصية القادمة من السيرفر
                  chat.createdAt != null && chat.createdAt!.length >= 16
                      ? chat.createdAt!.substring(11, 16)
                      : "",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  // الانتقال لشاشة المحادثة وتمرير الـ ID والاسم
                  Get.toNamed(
                    '/chatScreen',
                    arguments: {
                      'currentUserId': int.parse(AuthService.userId!),
                      'receiverId': otherUser?['id'],
                      'receiverName': otherUser?['name'],
                    },
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
