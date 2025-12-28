import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStartController extends GetxController {
  final SharedPreferences prefs;
  final FlutterSecureStorage storage;

  AppStartController(this.prefs, this.storage);

  final RxBool _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;

  bool get hasSeenOnboarding => prefs.getBool('onboarding_seen') ?? false;

  @override
  void onInit() {
    super.onInit();
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    await AuthService.loadToken();
    if (AuthService.token == null || AuthService.token!.isEmpty) {
      _isLoggedIn.value = false;
    } else {
      _isLoggedIn.value = true;
    }
  }

  String get initialRoute {
    if (!hasSeenOnboarding) {
      return '/onboardingScreen';
    } else if (!isLoggedIn) {
      return '/loginScreen';
    } else {
      return '/rental-home';
    }
  }
}
