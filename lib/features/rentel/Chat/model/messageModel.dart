class MessageModel {
  int? id;
  String? message;
  int? senderId;
  int? receiverId;
  String? createdAt;
  // سنخزن بيانات الشخص الآخر هنا كـ Map لعدم وجود موديل مستخدم
  Map<String, dynamic>? otherUser; 
  // متغير محلي لتحديد جهة الرسالة في شاشة الشات
  bool isMe; 

  MessageModel({
    this.id,
    this.message,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.otherUser,
    this.isMe = false,
  });

  // تحويل JSON القادم من Laravel إلى Object في Flutter
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      createdAt: json['created_at'],
      // نتحقق من وجود بيانات 'other_user' (تأتي في قائمة المحادثات فقط)
      otherUser: json['other_user'] != null ? Map<String, dynamic>.from(json['other_user']) : null,
    );
  }

  // في حال احتجت تحويل الموديل إلى JSON لإرساله للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'created_at': createdAt,
    };
  }
}