import 'package:apartment_rental_system/testuils/model/apartment.dart';

enum BookingStatus { pending, confirmed, canceled }

class Booking {
  final int id;
  final int apartmentId;
  BookingStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final Apartment apartment;

  Booking({
    required this.id,
    required this.apartmentId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.apartment,
  });

  factory Booking.fromJson(
    Map<String, dynamic> json, {
    Apartment? existingApartment,
  }) {
    return Booking(
      id: json['id'],
      apartmentId: json['apartment_id'],
      status: _statusFromString(json['status']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      apartment: json['apartment'] != null
          ? Apartment.fromJson(json['apartment'])
          : existingApartment!, // استخدام الـ apartment الحالي إذا لم يرسل السيرفر
    );
  }

  static BookingStatus _statusFromString(String s) {
    // التعديل هنا ليتوافق مع Enum قاعدة البيانات
    switch (s.toLowerCase()) {
      case 'pending':
      case 'modification_pending':
        return BookingStatus.pending;

      case 'confirmed':
        return BookingStatus.confirmed; // تم الربط مع الحالة القادمة من السيرفر
      case 'cancelled': // السيرفر يرسلها بـ LL كما في الـ Schema
      case 'canceled':
        return BookingStatus.canceled;
      default:
        return BookingStatus.pending;
    }
  }

  Booking copyWith({DateTime? startDate, DateTime? endDate}) {
    return Booking(
      id: id,
      apartmentId: apartmentId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status,
      apartment: apartment,
    );
  }
}

class Apartment {
  final int id;
  final String title;
  final String description;
  final String price;
  final int bedrooms;
  final int bathrooms;
  final int area;

  Apartment({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] ?? 0,
    );
  }
}
