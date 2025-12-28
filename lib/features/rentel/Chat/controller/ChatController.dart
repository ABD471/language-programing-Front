import 'dart:convert';

import 'package:apartment_rental_system/features/rentel/Chat/model/messageModel.dart';
import 'package:apartment_rental_system/util/service/pusherService.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs; // قائمة الرسائل التفاعلية
  var isLoading = false.obs;
  final PusherService _pusherService = PusherService();

  // سنفترض أننا نخزن ID المستخدم الحالي عند تسجيل الدخول
  // final int currentUserId = Get.find<AuthController>().user.id;

  @override
  void onClose() {
    // قطع الاتصال عند الخروج من صفحة المحادثة لتوفير الموارد
    // _pusherService.disconnect("private-chat.$currentUserId");
    super.onClose();
  }

  /// جلب تاريخ المحادثة من Laravel
  Future<void> fetchMessages(int receiverId) async {
    try {
      isLoading.value = true;
      final response = await ApiService.getRequest(
        url: "${urlClient['chat_messages']}/$receiverId",
        useAuth: true,
      );

      if (response["statusCode"] == 200) {
        // أولاً: الوصول للمفتاح 'body' داخل الاستجابة لأنه هو الذي يحتوي على القائمة
        final List data = response['body']['body'];

        final List<MessageModel> fetchedMessages = data.map((json) {
          var msg = MessageModel.fromJson(json);
          // تفعيل تحديد جهة الرسالة (يمين أو يسار)
          // msg.isMe = (msg.senderId == currentUserId);
          return msg;
        }).toList();

        messages.assignAll(fetchedMessages);
      }
    } catch (e) {
      print("Error fetching messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// إرسال رسالة جديدة
  Future<void> sendMessage(
    int receiverId,
    String text,
    int currentUserId,
  ) async {
    if (text.trim().isEmpty) return;

    // 1. إضافة الرسالة محلياً فوراً (Optimistic UI) لتجربة مستخدم سريعة
    final temporaryMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUserId,
      receiverId: receiverId,
      message: text,
      createdAt: DateTime.now().toIso8601String(),
      isMe: true,
    );
    messages.add(temporaryMessage);

    try {
      // 2. إرسال الطلب للسيرفر
      final response = await ApiService.postRequest(
        url: urlClient['send_message']!,
        payload: {'receiver_id': receiverId, 'message': text},
        useAuth: true,
      );

      if (response["statusCode"] != 200) {
        // في حال فشل الإرسال، يمكننا وضع علامة خطأ بجانب الرسالة
        Get.snackbar("error_title".tr, "failed_to_send".tr);
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  /// الاستماع للرسائل القادمة عبر Pusher
  void subscribeToChatStream(int currentUserId) {
    _pusherService.initPusher(
      channelName: "private-chat.$currentUserId",
      onEvent: (event) {
        print("الحدث القادم من Pusher هو: ${event.eventName}");

        if (event.eventName == "MessageSent" ||
            event.eventName == 'client-MessageSent') {
          var incomingData = event.data is String
              ? jsonDecode(event.data)
              : event.data;
          var newMessage = MessageModel.fromJson(incomingData);

          newMessage.isMe = false;

          messages.add(newMessage);
        }
      },
    );
  }
}
