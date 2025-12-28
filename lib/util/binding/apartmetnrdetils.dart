import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/testuils/contreeelrer.dart';
import 'package:get/get.dart';

class ApartmentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // يتوقع أن يتم تمرير الـ Apartment عبر Get.arguments عند التنقل للشاشة
    // مثال: Get.toNamed('/apartment', arguments: apartment);
    final args = Get.arguments;
    if (args == null) {
      throw Exception('Apartment model must be passed via Get.arguments');
    }
    // apartment should be the correct type
    Get.lazyPut(() => ApartmentDetailsControllerTest(args));
  }
}
