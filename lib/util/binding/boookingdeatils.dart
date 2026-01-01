import 'package:apartment_rental_system/features/tenant/mybooking/controller/bookingDetailsController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:get/get.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final initialBooking =
        Get.arguments as Booking;
    Get.lazyPut<BookingDetailsController>(
      () => BookingDetailsController(initialBooking),
    );
  }
}
