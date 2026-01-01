import 'dart:convert';
import 'dart:async';

import 'package:apartment_rental_system/common/features/Chat/model/messageModel.dart';
import 'package:apartment_rental_system/util/service/pusherService.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;
  var isOnline = false.obs;
  final PusherService _pusherService = PusherService();
  StreamSubscription? _connectivitySubscription;
  StreamSubscription? _pusherEventSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupConnectivityListener();
  }

  void _setupConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (results.isNotEmpty && results.first != ConnectivityResult.none) {
        _retryFailedMessages();
      }
    });
  }

  void _retryFailedMessages() {
    for (var msg in messages) {
      if (msg.isMe && msg.isFailed == true) {
        resendMessage(msg);
      }
    }
  }

 
  void setupChatStreams(int currentUserId, int receiverId) async {
    await _pusherService.connectPusher();
    await _pusherEventSubscription?.cancel();

    print(
      "🎧 [LISTEN] Chat Active for User: $currentUserId -> Receiver: $receiverId",
    );

    _pusherEventSubscription = _pusherService.eventStream.listen((event) {
      
      final dynamic rawEventData = event.data is String
          ? jsonDecode(event.data)
          : event.data;
      Map<String, dynamic> rawData = Map<String, dynamic>.from(rawEventData);

      if (event.channelName == "presence-chatonline.$receiverId") {
        _handlePresenceEvents(event.eventName, rawData, receiverId);
      }

     
      if (event.channelName == "private-chat.$currentUserId") {
     
        if (event.eventName == "MessageSent") {
          _handleIncomingMessage(rawData, currentUserId, receiverId);
        }
       
        else if (event.eventName == "messages.read" ||
            event.eventName == "MessageSeen") {
          print("👀 [EVENT] Messages were read by the other user.");
          _handleMessageReadEvent(receiverId);
        }
      }
    });

   
    try {
     
      await _pusherService.pusher.unsubscribe(
        channelName: "presence-chatonline.$receiverId",
      );
      await _pusherService.subscribeToChannel(
        "presence-chatonline.$receiverId",
      );

      
      String myPrivateChannel = "private-chat.$currentUserId";
      await _pusherService.pusher.unsubscribe(channelName: myPrivateChannel);
      await _pusherService.subscribeToChannel(myPrivateChannel);
    } catch (e) {
      print("🚨 [SUB ERROR] Exception during subscription: $e");
    }
  }

 
  void _handleIncomingMessage(
    Map<String, dynamic> rawData,
    int currentUserId,
    int receiverId,
  ) {
    try {
      Map<String, dynamic> finalMessageMap;
     
      if (rawData.containsKey('message') && rawData['message'] is Map) {
        finalMessageMap = Map<String, dynamic>.from(rawData['message']);
      } else {
        finalMessageMap = rawData;
      }

      var newMessage = MessageModel.fromJson(finalMessageMap);

     
      bool belongsToChat =
          (newMessage.senderId == receiverId &&
              newMessage.receiverId == currentUserId) ||
          (newMessage.senderId == currentUserId &&
              newMessage.receiverId == receiverId);

      if (belongsToChat) {
        int existingIndex = messages.indexWhere((m) => m.id == newMessage.id);

        if (existingIndex == -1) {
         
          if (newMessage.senderId != currentUserId) {
            newMessage.isMe = false;
            messages.add(newMessage);
          
            markMessagesAsRead(receiverId);
          }
        } else {
         
          messages[existingIndex].status = 1;
        }
        messages.refresh();
      }
    } catch (e) {
      print("🚨 Parsing Error: $e");
    }
  }


  void _handleMessageReadEvent(int receiverId) {
   
    bool updated = false;
    for (var msg in messages) {
      if (msg.isMe == true && msg.receiverId == receiverId && msg.status != 2) {
        msg.status = 2; 
        updated = true;
      }
    }
    if (updated) {
      messages.refresh();
      print("✅ [UI UPDATE] Blue ticks activated!");
    }
  }

  void _handlePresenceEvents(String eventName, dynamic data, int receiverId) {
  
    try {
      if (eventName == "pusher:subscription_succeeded") {
        final Map<String, dynamic> pData = data is String
            ? jsonDecode(data)
            : Map<String, dynamic>.from(data);
        List<dynamic> ids = (pData['presence']?['ids'] ?? pData['ids'] ?? []);
        isOnline.value = ids
            .map((e) => e.toString())
            .contains(receiverId.toString());
      } else if (eventName == "pusher:member_added") {
  
        final id =
            (data is Map
                    ? (data['user_id'] ?? data['id'])
                    : jsonDecode(data)['user_id'])
                .toString();
        if (id == receiverId.toString()) isOnline.value = true;
      } else if (eventName == "pusher:member_removed") {
        final id =
            (data is Map
                    ? (data['user_id'] ?? data['id'])
                    : jsonDecode(data)['user_id'])
                .toString();
        if (id == receiverId.toString()) isOnline.value = false;
      }
    } catch (e) {
      print("Presence Error: $e");
    }
  }

  Future<void> sendMessage(
    int receiverId,
    String text,
    int currentUserId,
  ) async {
    if (text.trim().isEmpty) return;
    final tempMsg = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUserId,
      receiverId: receiverId,
      message: text,
      createdAt: DateTime.now().toIso8601String(),
      status: 0, // 0 = Sending
      isMe: true,
      isFailed: false,
    );
    messages.add(tempMsg);

    try {
      final response = await ApiService.postRequest(
        url: urlClient['send_message']!,
        payload: {'receiver_id': receiverId, 'message': text},
        useAuth: true,
      );
      if (response["statusCode"] == 200) {
        tempMsg.status = 1; // 1 = Sent/Delivered
        tempMsg.isFailed = false;
        if (response['body']?['body'] != null) {
          var realMsg = MessageModel.fromJson(response['body']['body']);
          tempMsg.id = realMsg.id;
        }
      } else {
        tempMsg.isFailed = true;
      }
    } catch (e) {
      tempMsg.isFailed = true;
    } finally {
      messages.refresh();
    }
  }

  Future<void> resendMessage(MessageModel msg) async {
    try {
      final response = await ApiService.postRequest(
        url: urlClient['send_message']!,
        payload: {'receiver_id': msg.receiverId, 'message': msg.message},
        useAuth: true,
      );
      if (response["statusCode"] == 200) {
        msg.status = 1;
        msg.isFailed = false;
        messages.refresh();
      }
    } catch (e) {
      msg.isFailed = true;
    }
  }

  Future<void> fetchMessages(int receiverId, int currentUserId) async {
    try {
      isLoading.value = true;
      final response = await ApiService.getRequest(
        url: "${urlClient['chat_messages']}/$receiverId",
        useAuth: true,
      );
      if (response["statusCode"] == 200) {
        final List data = response['body']['body'];
        messages.assignAll(
          data.map((json) {
            var m = MessageModel.fromJson(json);
            m.isMe = (m.senderId == currentUserId);
            return m;
          }).toList(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markMessagesAsRead(int senderId) async {
    try {
      await ApiService.postRequest(
        url: urlClient['mark_read']!,
        payload: {'sender_id': senderId},
        useAuth: true,
      );
     
    } catch (_) {}
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    _pusherEventSubscription?.cancel();
    super.onClose();
  }
}
