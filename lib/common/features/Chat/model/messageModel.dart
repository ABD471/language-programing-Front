class MessageModel {
  int? id;
  String? message;
  int? senderId;
  int? receiverId;
  String? createdAt;
  String? lastMessage;
  int? unreadCount;
  bool? isOnline;
  int status; 
  Map<String, dynamic>? otherUser;
  bool isMe;
  bool isFailed;
  bool isSending;

  MessageModel({
    this.id,
    this.message,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.status = 0,
    this.otherUser,
    this.isMe = false,
    this.isFailed = false,
    this.isSending = false,
    this.lastMessage,
    this.unreadCount,
    this.isOnline,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: int.tryParse(json['id'].toString()), 
      message: json['message']?.toString() ?? "",
      lastMessage: json['last_message']?.toString(),
      unreadCount: int.tryParse(json['unread_count'].toString()) ?? 0,
      isOnline:
          json['is_online'] == 1 ||
          json['is_online'] == true ||
          json['is_online'] == "true",
      senderId: int.tryParse(json['sender_id'].toString()),
      receiverId: int.tryParse(json['receiver_id'].toString()),
      createdAt: json['created_at'],
      status: int.tryParse(json['status'].toString()) ?? 0,
      otherUser: json['other_user'] != null
          ? Map<String, dynamic>.from(json['other_user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'created_at': createdAt,
      'status': status,
    };
  }
}
