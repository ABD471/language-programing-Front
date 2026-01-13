import 'dart:convert';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/common/features/Chat/model/messageModel.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:apartment_rental_system/util/service/pusherService.dart';
import 'package:get/get.dart';

class ChatBoxController extends GetxController {
  var conversations = <MessageModel>[].obs;
  var isLoading = true.obs;
  final PusherService _pusherService = PusherService();

  var onlineUserIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() async {
    // 1. جلب القائمة أولاً
    await getChatList();
    // 2. الاستماع لتحديثات الأونلاين (الـ Stream)
    _listenToOnlineStatus();
    // 3. ربط Pusher والاشتراك في القنوات
    _listenToPusherUpdates();
  }

  void _listenToOnlineStatus() {
    _pusherService.onlineUsersStream.listen((users) {
      print("👥 Received online users list: $users");
      onlineUserIds.assignAll(users);

      // تحديث حالة كل محادثة بناءً على القائمة الجديدة
      for (var chat in conversations) {
        if (chat.otherUser != null) {
          String otherId = chat.otherUser!['id'].toString();
          chat.isOnline = onlineUserIds.contains(otherId);
          print("🔍 Checking User $otherId: isOnline = ${chat.isOnline}");
        }
      }
      conversations.refresh();
    });
  }

  void _listenToPusherUpdates() async {
    if (AuthService.userId == null) return;
    String currentUserId = AuthService.userId!;

    await _pusherService.connectPusher();

    // 🔵 القناة الخاصة بالرسائل
    await _pusherService.subscribeToChannel("private-chat.$currentUserId");

    // 🟢 التعديل المهم: الاشتراك في قناة الـ Presence لمراقبة المتصلين
    // ملاحظة: تأكد أن اسم القناة يطابق ما هو موجود في Laravel (مثلاً chat-online)
    await _pusherService.subscribeToChannel("presence-chatonline.$currentUserId");

    _pusherService.eventStream.listen((event) {
      if (event.eventName == "MessageSent") {
        try {
          final dynamic decoded = event.data is String
              ? jsonDecode(event.data)
              : event.data;

          final Map<String, dynamic> incomingData = Map<String, dynamic>.from(decoded);
          Map<String, dynamic> messageMap;

          if (incomingData['message'] is Map) {
            messageMap = Map<String, dynamic>.from(incomingData['message']);
          } else {
            messageMap = incomingData;
          }

          var newMessage = MessageModel.fromJson(messageMap);
          _handleIncomingMessage(newMessage);
        } catch (e) {
          print("🚨 [BoxController Error] Parsing failed: $e");
        }
      }
    });
  }

  void _handleIncomingMessage(MessageModel newMessage) {
    int index = conversations.indexWhere(
          (c) =>
      c.otherUser?['id'] == newMessage.senderId ||
          c.otherUser?['id'] == newMessage.receiverId,
    );

    if (index != -1) {
      var chat = conversations[index];
      chat.lastMessage = newMessage.message;
      chat.createdAt = newMessage.createdAt;

      if (newMessage.senderId != int.parse(AuthService.userId!)) {
        chat.unreadCount = (chat.unreadCount ?? 0) + 1;
      }

      conversations.removeAt(index);
      conversations.insert(0, chat);
      conversations.refresh();
    } else {
      // إذا كانت محادثة جديدة تماماً، نحدث القائمة من السيرفر
      getChatList();
    }
  }

  Future<void> getChatList() async {
    try {
      isLoading(true);
      var response = await ApiService.getRequest(
        url: "${urlClient['chat_list']}",
        useAuth: true,
      );
      if (response['statusCode'] == 200) {
        List data = response['body']["body"];
        var fetchedChats = data.map((e) => MessageModel.fromJson(e)).toList();

        // فحص الحالة الابتدائية عند جلب القائمة
        for (var chat in fetchedChats) {
          if (chat.otherUser != null) {
            chat.isOnline = onlineUserIds.contains(
              chat.otherUser!['id'].toString(),
            );
          }
        }
        conversations.assignAll(fetchedChats);
      }
    } catch (e) {
      print("Error fetching chat list: $e");
    } finally {
      isLoading(false);
    }
  }
}