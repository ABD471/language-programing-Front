
import 'package:apartment_rental_system/testuils/model/apartment.dart';

class Apartments {
  final int currentPage;
  final List<ApartmentTest> data;
  final int total;
  final int perPage;

  Apartments({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.perPage,
  });

  factory Apartments.fromJson(Map<String, dynamic> json) {
    return Apartments(
      currentPage: json['current_page'],
      data: (json['data'] as List)
          .map((e) => ApartmentTest.fromJson(e))
          .toList(),
      total: json['total'],
      perPage: json['per_page'],
    );
  }
}
