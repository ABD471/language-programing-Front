import 'package:apartment_rental_system/features/rentel/Notification/controller/notificationController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // تعريف القناة كمتغير ثابت لضمان التطابق
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'booking_channel_v2',
    'High Importance Bookings',

    description: 'Notifications for new booking requests',
    importance: Importance.max, // تضمن ظهور الإشعار كـ Pop-up
    playSound: true,
    enableVibration: true,
  );

  Future<NotificationService> init() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // 1. إنشاء القناة في أندرويد برمجياً (مهم جداً للـ Foreground)
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap(response.payload);
      },
    );

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _onNotificationTap(message.data['booking_id']);
    });

    String? token = await getToken();
    print("========================================");
    print("My Device Token: $token");
    print("========================================");

    return this;
  }

  void _handleForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: _channel.importance,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data['booking_id'],
      );
    }
    if (Get.isRegistered<NotificationController>()) {
      Get.find<NotificationController>().fetchNotifications();
    }
  }

  void _onNotificationTap(String? bookingId) {
    // التوجيه لصفحة الحجوزات مع تمرير الـ ID إذا أردت استخدامه في الصفحة
    Get.toNamed('/rentel-booking', arguments: bookingId);
  }

  Future<String?> getToken() async => await _messaging.getToken();
}
