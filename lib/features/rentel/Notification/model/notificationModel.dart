class NotificationModel {
  String? id;
  String? title;
  String? message;
  String? bookingId;
  DateTime? createdAt;
  bool isRead;

  NotificationModel({this.id, this.title, this.message, this.bookingId, this.createdAt, this.isRead = false});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // الحقول التي وضعناها في دالة toDatabase في لارافيل تكون داخل json['data']
    var data = json['data'];
    return NotificationModel(
      id: json['id'],
      title: data['apartment_title'] ?? 'إشعار جديد',
      message: data['message'] ?? '',
      bookingId: data['booking_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['read_at'] != null,
    );
  }
}