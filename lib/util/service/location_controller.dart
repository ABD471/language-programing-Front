import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  final RxString city = 'detecting_location'.tr.obs;

  @override
  void onInit() {
    super.onInit();
    _detectLocation();
  }

  Future<void> _detectLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        city.value = 'location_service_disabled'.tr;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          city.value = 'location_permission_denied'.tr;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        city.value = 'location_permission_forever'.tr;
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        city.value =
            placemarks.first.locality ??
            placemarks.first.administrativeArea ??
            'unknown_location'.tr;
      } else {
        city.value = 'unknown_location'.tr;
      }
    } catch (e) {
      city.value = 'location_error'.tr;
    }
  }
}
