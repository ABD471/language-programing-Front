import 'dart:convert';

import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();
  factory PusherService() => _instance;
  PusherService._internal();

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> initPusher({
    required String channelName,
    required Function(dynamic) onEvent,
  }) async {
    try {
      await pusher.init(
        apiKey: "5f24808f978cdd988fc8",
        authEndpoint: "https://764b2e8f92a6.ngrok-free.app/broadcasting/auth",
        onAuthorizer: (channelName, socketId, options) async {
          try {
            var response = await http.post(
              Uri.parse(
                "https://764b2e8f92a6.ngrok-free.app/broadcasting/auth",
              ),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${AuthService.token}',
                'Accept': 'application/json',
              },
              body: jsonEncode({
                'socket_id': socketId,
                'channel_name': channelName,
              }),
            );

            if (response.statusCode == 200 || response.statusCode == 201) {
              var jsonResponse = jsonDecode(response.body);

              return {"auth": jsonResponse['auth'].toString()};
            } else {
              print("خطأ في التوثيق: ${response.body}");
              return null;
            }
          } catch (e) {
            print("فشل الاتصال بمسار التوثيق: $e");
            return null;
          }
        },
        cluster: "us2",
        onEvent: onEvent,
        onSubscriptionSucceeded: (channelName, data) {
          print("✅ تم الاشتراك بنجاح في القناة: $channelName");
        },
        onSubscriptionError: (message, e) {
          print("❌ فشل الاشتراك في القناة: $message");
        },
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      print("خطأ في اتصال Pusher: $e");
    }
  }

  void disconnect(String channelName) {
    pusher.unsubscribe(channelName: channelName);
    pusher.disconnect();
  }
}
