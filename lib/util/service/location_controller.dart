import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  final RxString city = 'جاري تحديد الموقع...'.obs;

  @override
  void onInit() {
    super.onInit();
    _detectLocation();
  }

  Future<void> _detectLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        city.value = 'الموقع غير مفعل';
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          city.value = 'تم رفض الإذن';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        city.value = 'الإذن مرفوض دائمًا';
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
            'غير معروف';
      } else {
        city.value = 'غير معروف';
      }
    } catch (e) {
      city.value = 'خطأ في تحديد الموقع';
    }
  }
}
