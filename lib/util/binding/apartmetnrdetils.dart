import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';

import 'package:get/get.dart';

class ApartmentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    if (args == null) {
      throw Exception('Apartment model must be passed via Get.arguments');
    }

    Get.lazyPut(() => ApartmentDetailsControllerTest(args));
  }
}
