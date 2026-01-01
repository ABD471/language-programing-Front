import 'dart:async';
import 'dart:convert';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();
  factory PusherService() => _instance;
  PusherService._internal();

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  bool _isConnected = false;

  final _onlineUsersController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get onlineUsersStream => _onlineUsersController.stream;
  List<String> activeUsers = [];

  final _eventController = StreamController<PusherEvent>.broadcast();
  Stream<PusherEvent> get eventStream => _eventController.stream;

  Future<void> connectPusher() async {
    print(
      "🎬 [STEP 1] Entering connectPusher. Current Status: isConnected=$_isConnected",
    );

    if (_isConnected) {
      print("ℹ️ Pusher already connected, skipping.");
      return;
    }

    try {
      print("🚀 [STEP 2] Starting pusher.init...");
      await pusher.init(
        apiKey: "5f24808f978cdd988fc8",
        cluster: "us2",
        useTLS: false, // HTTP
        authEndpoint: "${serverurl}/broadcasting/auth",
        onAuthorizer: _onAuthorizer,

        onEvent: (event) {
          print(
            "📡 [EVENT] Incoming: ${event.eventName} on ${event.channelName}",
          );
          _eventController.add(event);
        },

        onSubscriptionSucceeded: (channelName, data) {
          print("✅ [SUCCESS] Subscribed to: $channelName");
          _eventController.add(
            PusherEvent(
              channelName: channelName,
              eventName: "pusher:subscription_succeeded",
              data: data,
            ),
          );
          if (channelName.startsWith("presence-")) _handlePresenceUpdate(data);
        },

        onMemberAdded: (channelName, member) {
          print("👤 [MEMBER] Added: ${member.userId}");
          _eventController.add(
            PusherEvent(
              channelName: channelName,
              eventName: "pusher:member_added",
              data: {"user_id": member.userId},
            ),
          );
        },

        onError: (message, code, error) {
          print("❌ [PUSHER ERROR] Message: $message, Code: $code");
        },

        onConnectionStateChange: (currentState, previousState) {
          print("🔄 [STATE] Changed from $previousState to $currentState");
        },
      );
      print("✅ [STEP 3] pusher.init completed.");

      print("🔌 [STEP 4] Attempting pusher.connect()...");
      await pusher.connect();
      _isConnected = true;
      print("🟢 [STEP 5] pusher.connect() called successfully.");
    } catch (e) {
      print("🔴 [CRITICAL] Connection Error in connectPusher: $e");
    }
  }

  Future<void> subscribeToChannel(String channelName) async {
    print("⏳ [SUB] Starting subscription request for: $channelName");
    try {
      await pusher.subscribe(channelName: channelName);
      print("📤 [SUB] Request for $channelName sent to native plugin.");
    } catch (e) {
      print("🔴 [SUB ERROR] Failed to subscribe to $channelName: $e");
    }
  }

  Future<dynamic> _onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    print("🔑 [AUTH] Authorizer Triggered for $channelName");
    print("🔑 [AUTH] Socket ID: $socketId");
    print(
      "🔑 [AUTH] Using Token: ${AuthService.token != null ? 'Token Exists' : 'TOKEN IS NULL!'}",
    );
    print("[Auth token :] ${AuthService.token}");

    try {
      print("🌐 [AUTH] Sending POST request to Laravel...");
      var response = await http
          .post(
            Uri.parse("$serverurl/broadcasting/auth"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AuthService.token}',
              'Accept': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
              'X-Socket-ID': socketId,
            },
            body: jsonEncode({
              'socket_id': socketId,
              'channel_name': channelName,
            }),
          )
          .timeout(const Duration(seconds: 20));

      print("🌐 [AUTH] Laravel Response Code: ${response.statusCode}");
      print("🌐 [AUTH] Laravel Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ [AUTH] Authorization successful.");
        return jsonDecode(response.body);
      } else {
        print("⚠️ [AUTH] Failed with status ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🚨 [AUTH EXCEPTION] Error during HTTP Auth: $e");
      return null;
    }
  }

  void _handlePresenceUpdate(dynamic data) {
    print("👥 [PRESENCE] Updating active users list...");
    try {
      final decoded = data is String ? jsonDecode(data) : data;
      if (decoded['presence']?['ids'] != null) {
        activeUsers = List<String>.from(
          decoded['presence']['ids'].map((id) => id.toString()),
        );
        _onlineUsersController.add(activeUsers);
        print("👥 [PRESENCE] Current Online Users: $activeUsers");
      }
    } catch (e) {
      print("📝 [PRESENCE ERROR] Parsing failed: $e");
    }
  }
}
