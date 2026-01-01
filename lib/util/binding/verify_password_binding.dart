import 'package:apartment_rental_system/common/features/settings/controller/verifyPasswrodrequiredController.dart';
import 'package:get/get.dart';

class VerifyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyPasswordRequiredController>(
      () => VerifyPasswordRequiredController(),
    );
  }
}
