import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentDetailsControllerTest extends GetxController {
  final ApartmentTest apartment;

  ApartmentDetailsControllerTest(this.apartment);

  // Reactive state
  final RxList<String> images = <String>[].obs;
  final RxInt currentCarouselIndex = 0.obs;
  final RxDouble scrollOffset = 0.0.obs;
  final RxString phone = ''.obs;
  RxBool isloading = false.obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  Rxn<DateTimeRange> selectedDateRange = Rxn<DateTimeRange>();

  late final ScrollController scrollController;

  @override
  void onInit() async {
    super.onInit();
    _initData();
    scrollController = ScrollController()..addListener(_onScroll);
    print(await storage.read(key: "token"));
  }

  void _initData() {
    images.assignAll(apartment.images.map((e) => e.url).toList());

    phone.value = apartment.owner.phone;
  }

  void _onScroll() {
    scrollOffset.value = scrollController.offset;
  }

  // 📍 الموقع
  LatLng get location {
    return LatLng(
      double.tryParse(apartment.address.latitude) ?? 33.5138,
      double.tryParse(apartment.address.longitude) ?? 36.2765,
    );
  }

  // 📞 اتصال
  Future<void> callOwner() async {
    String cleanPhone = phone.value.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleanPhone.startsWith('0')) {
      cleanPhone = '+963${cleanPhone.substring(1)}';
    }
    if (!cleanPhone.startsWith('+')) {
      cleanPhone = '+$cleanPhone';
    }

    final Uri telUri = Uri(scheme: 'tel', path: cleanPhone);

    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('خطأ', 'لا يمكن إجراء الاتصال');
    }
  }

  // 💬 واتساب
  Future<void> openWhatsApp() async {
    String waNumber = phone.value.replaceAll(RegExp(r'[^0-9]'), '');

    final Uri waUri = Uri.parse('https://wa.me/$waNumber');

    if (await canLaunchUrl(waUri)) {
      await launchUrl(waUri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('خطأ', 'لا يمكن فتح واتساب');
    }
  }

  // 📋 نسخ الرقم
  Future<void> copyPhone() async {
    await Clipboard.setData(ClipboardData(text: phone.value));
    Get.snackbar('تم', 'تم نسخ الرقم');
  }

  // 🗺️ خرائط
  Future<void> openExternalMaps() async {
    final lat = location.latitude;
    final lng = location.longitude;

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('خطأ', 'تعذر فتح الخرائط');
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  Future<void> booking() async {
    if (selectedDateRange.value == null) {
      Get.snackbar('تنبيه', 'يرجى اختيار تاريخ الحجز');
      return;
    }

    isloading.value = true;

    try {
    
      String formatDate(DateTime date) =>
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(formatDate(selectedDateRange.value!.start));
      final Map<String, dynamic> payload = {
        "apartment_id": apartment.id, 
        "start_date": formatDate(selectedDateRange.value!.start),
        "end_date": formatDate(selectedDateRange.value!.end),
      };

      final result = await ApiService.postRequest(
        url: urlClient["requestBooking"]!,
        useAuth: true,
        payload: payload,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];
      final message = body["message"]?.toString() ?? "";

      // -------------------------
      // SUCCESS CASE
      // -------------------------
      if ((statusCode == 200 || statusCode == 201) && body["status"] == 1) {
        showDialogWithLottie(
          title: "نجاح",
          message: "تم إرسال طلب الحجز بنجاح",
          lottieAsset: "assets/lottie/Success.json",
        );
        return;
      }

      // -------------------------
      // ERROR CASES
      // -------------------------
      if (statusCode == 401) {
        Get.snackbar('خطأ', 'غير مصرح لك');
        return;
      }

      if (statusCode == 409) {
        Get.snackbar('غير متاح', message);
        return;
      }

      showDialogWithLottie(
        title: "خطأ غير متوقع",
        message: "رمز الخطأ: $statusCode",
        lottieAsset: "assets/lottie/Alert.json",
      );
    } catch (e) {
      showDialogWithLottie(
        title: "استثناء",
        message: "حدث خطأ أثناء الحجز: $e",
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isloading.value = false;
    }
  }

  void showDialogWithLottie({
    required String title,
    required dynamic message,
    required String lottieAsset,
  }) {
    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          SizedBox(height: 150, child: Lottie.asset(lottieAsset)),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
      textConfirm: "dialog_confirm".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
