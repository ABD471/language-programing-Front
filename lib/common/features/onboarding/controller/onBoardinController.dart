import 'package:apartment_rental_system/main.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  void finishOnboarding() {
    sharedPreferences.setBool('onboarding_seen', true);
    Get.offAllNamed('/loginScreen');
  }
}
