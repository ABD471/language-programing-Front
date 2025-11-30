
import 'package:apartment_rental_system/common/model/Apartment.dart';

class Booking {
  final String id;
  final Apartment apartment;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'pending', 'confirmed', 'cancelled', 'completed'

  Booking({
    required this.id,
    required this.apartment,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
}
