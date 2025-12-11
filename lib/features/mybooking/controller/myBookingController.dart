import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:get/get.dart';

enum BookingStatus { pending, completed, canceled }

class Booking {
  final Apartment apartment;
  final String dates;
  final String price;
  final BookingStatus status;

  Booking({
    required this.apartment,
    required this.dates,
    required this.price,
    required this.status,
  });
}

class BookingsController extends GetxController {
  var bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() {
    // هنا يمكنك جلب البيانات من API أو قاعدة بيانات
    bookings.assignAll([
      Booking(
        apartment: dummyApartments[0],
        dates: '2023-12-15 إلى 2023-12-20',
        price: '120 دينار/ليلة',
        status: BookingStatus.pending,
      ),
      Booking(
        apartment: dummyApartments[1],
        dates: '2023-12-10 إلى 2023-12-14',
        price: '95 دينار/ليلة',
        status: BookingStatus.completed,
      ),
      Booking(
        apartment: dummyApartments[0],
        dates: '2023-11-25 إلى 2023-11-30',
        price: '110 دينار/ليلة',
        status: BookingStatus.canceled,
      ),
    ]);
  }

  List<Booking> getBookingsByStatus(BookingStatus status) {
    return bookings.where((b) => b.status == status).toList();
  }
}
