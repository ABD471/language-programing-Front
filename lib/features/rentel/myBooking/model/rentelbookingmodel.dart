class BookingModel {
  final int id;
  final String status;
  final String startDate;
  final String endDate;
  final ApartmentData apartment;
  final TenantData tenant;

  BookingModel({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.apartment,
    required this.tenant,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      status: json['status'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      apartment: ApartmentData.fromJson(json['apartment']),
      tenant: TenantData.fromJson(json['tenant']),
    );
  }
}

class TenantData {
  final int id;
  final String email;
  final String phone;

  TenantData({required this.id, required this.email, required this.phone});

  factory TenantData.fromJson(Map<String, dynamic> json) {
    return TenantData(
      id: json['id'],
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
    );
  }
}

class ApartmentData {
  final int id;
  final String title;
  final String description;
  final String price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final int ownerId;
  final int addressId;
  final String paymentInformation;
  final String createdAt;

  ApartmentData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.ownerId,
    required this.addressId,
    required this.paymentInformation,
    required this.createdAt,
  });

  // تحويل JSON القادم من Laravel إلى Object في Flutter
  factory ApartmentData.fromJson(Map<String, dynamic> json) {
    return ApartmentData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price']
          .toString(), // نحولها لـ String لنتجنب مشاكل الـ Decimal
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] ?? 0,
      ownerId: json['owner_id'] ?? 0,
      addressId: json['address_id'] ?? 0,
      paymentInformation: json['payment_information'] ?? 'Cash',
      createdAt: json['created_at'] ?? '',
    );
  }

  // في حال احتجت لإرسال البيانات مجدداً للسيرفر (اختياري)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'owner_id': ownerId,
      'address_id': addressId,
      'payment_information': paymentInformation,
    };
  }
}
// افترضنا وجود ApartmentData مسبقاً لديك