import 'package:apartment_rental_system/features/rentel/home/controller/rental_home_controller.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/rental_home_view.dart';
import 'package:get/get.dart';

class RentalHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyApartmentsScreen());
  }
}
