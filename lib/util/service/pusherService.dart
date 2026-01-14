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
    if (_isConnected) return;

    try {
      await pusher.init(
        apiKey: "5f24808f978cdd988fc8",
        cluster: "us2",
        useTLS: false,
        authEndpoint: "${serverurl}/broadcasting/auth",
        onAuthorizer: _onAuthorizer,

        onEvent: (event) {
          _eventController.add(event);
        },

        onSubscriptionSucceeded: (channelName, data) {
          print("✅ Subscribed to: $channelName");
          if (channelName.startsWith("presence-")) {
            _handlePresenceUpdate(data);
          }
        },

        onMemberAdded: (channelName, member) {
          print("👤 Member Added: ${member.userId}");
          if (!activeUsers.contains(member.userId.toString())) {
            activeUsers.add(member.userId.toString());
            _onlineUsersController.add(List.from(activeUsers));
          }
        },

        onMemberRemoved: (channelName, member) {
          print("🚫 Member Removed: ${member.userId}");
          activeUsers.remove(member.userId.toString());
          _onlineUsersController.add(List.from(activeUsers));
        },

        onError: (message, code, error) {
          print("❌ Pusher Error: $message");
        },
      );

      await pusher.connect();
      _isConnected = true;
    } catch (e) {
      print("🔴 Connection Error: $e");
    }
  }

  Future<void> subscribeToChannel(String channelName) async {
    try {
      await pusher.subscribe(channelName: channelName);
    } catch (e) {
      print("🔴 Subscription Error: $e");
    }
  }

  Future<dynamic> _onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      var response = await http.post(
        Uri.parse("$serverurl/broadcasting/auth"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthService.token}',
          'Accept': 'application/json',
          'X-Socket-ID': socketId,
        },
        body: jsonEncode({'socket_id': socketId, 'channel_name': channelName}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void _handlePresenceUpdate(dynamic data) {
    try {
      final decoded = data is String ? jsonDecode(data) : data;

      if (decoded['presence']?['ids'] != null) {
        activeUsers = List<String>.from(
          decoded['presence']['ids'].map((id) => id.toString()),
        );
        _onlineUsersController.add(activeUsers);
      }
    } catch (e) {
      print("📝 Presence Parsing failed: $e");
    }
  }
}
