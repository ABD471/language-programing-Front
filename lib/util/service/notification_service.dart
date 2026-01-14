import 'dart:convert'; 
import 'package:apartment_rental_system/common/features/Notification/controller/notificationController.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class NotificationService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();


  static const AndroidNotificationChannel _bookingChannel = AndroidNotificationChannel(
    'booking_channel_v2', 
    'إشعارات الحجوزات',
    description: 'تنبيهات طلبات الحجز الجديدة وتحديثاتها',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

 
  static const AndroidNotificationChannel _chatChannel = AndroidNotificationChannel(
    'chat_channel', 
    'رسائل الدردشة',
    description: 'تنبيهات الرسائل الجديدة من المستخدمين',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  Future<NotificationService> init() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _messaging.requestPermission(alert: true, badge: true, sound: true);

   
    final androidPlugin = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(_bookingChannel);
    await androidPlugin?.createNotificationChannel(_chatChannel);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap(response.payload);
      },
    );

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleDataNavigation(message.data);
    });

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleDataNavigation(initialMessage.data);
    }

    String? token = await getToken();
    print("========================================");
    print("My Device Token: $token");
    print("========================================");

    return this;
  }

  void _handleForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;

 
    if (message.data['type'] == 'chat') {
      if (Get.currentRoute == '/chatScreen' &&
          Get.arguments?['receiverId'].toString() == message.data['sender_id']) {
        return;
      }
    }

    if (notification != null) {
    
      bool isChat = message.data['type'] == 'chat';

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            isChat ? _chatChannel.id : _bookingChannel.id,
            isChat ? _chatChannel.name : _bookingChannel.name,
            channelDescription: isChat ? _chatChannel.description : _bookingChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }

    if (Get.isRegistered<NotificationController>()) {
      Get.find<NotificationController>().fetchNotifications();
    }
  }

  void _onNotificationTap(String? payload) {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      _handleDataNavigation(data);
    }
  }

  void _handleDataNavigation(Map<String, dynamic> data) {
    String? type = data['type'];

    if (type == 'chat') {
      Get.toNamed(
        '/chatScreen',
        arguments: {
          'receiverId': int.parse(data['sender_id']),
          'receiverName': data['sender_name'],
          'currentUserId': AuthService.userId,
        },
      );
    } else {
      Get.toNamed('/rentel-booking', arguments: data['booking_id']);
    }
  }

  Future<String?> getToken() async => await _messaging.getToken();
}