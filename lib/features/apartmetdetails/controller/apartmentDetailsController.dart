import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../../../common/model/Apartment.dart';

class ApartmentDetailsController extends GetxController {
  final Apartment apartment;

  ApartmentDetailsController(this.apartment);

  // Reactive state
  final RxList<String> images = <String>[].obs;
  final RxInt currentCarouselIndex = 0.obs;
  final RxDouble scrollOffset = 0.0.obs;
  final RxList<DateTime> bookedDates = <DateTime>[].obs;
  final RxString phone = ''.obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;

  ScrollController? scrollController;

  @override
  void onInit() async {
    print(await storage.read(key: "token"));
    super.onInit();
    _initData();
    scrollController = ScrollController()..addListener(_onScroll);
  }

  void _initData() {
    images.assignAll(_buildImages());
    phone.value = _initialPhone();
    loadBookedDates();
  }

  List<String> _buildImages() {
    return [
      if ((apartment.imageUrl ?? '').isNotEmpty) apartment.imageUrl!,
      "https://images.unsplash.com/photo-1502672023488-70e25813eb80",
      "https://images.unsplash.com/photo-1527030280862-64139fba04ca",
      "https://images.unsplash.com/photo-1505691938895-1758d7feb511",
    ];
  }

  String _initialPhone() {
    if (apartment.phoneNumber != null && apartment.phoneNumber!.isNotEmpty) {
      return apartment.phoneNumber!;
    }

    return '+963999999999';
  }

  void _onScroll() {
    scrollOffset.value = scrollController?.offset ?? 0.0;
  }

  // Booked dates loader (handles List<DateTime> or List<String>)
  void loadBookedDates() {
    try {
      if (apartment.bookedDates != null && apartment.bookedDates!.isNotEmpty) {
        bookedDates.assignAll(apartment.bookedDates!);
      } else if (apartment.bookedDatesString != null &&
          apartment.bookedDatesString!.isNotEmpty) {
        bookedDates.assignAll(
          apartment.bookedDatesString!.map((s) => DateTime.parse(s)).toList(),
        );
      }

      // fallback sample data if empty (optional)
      if (bookedDates.isEmpty) {
        final now = DateTime.now();
        bookedDates.assignAll([
          now.add(const Duration(days: 2)),
          now.add(const Duration(days: 3)),
          now.add(const Duration(days: 7)),
          now.add(const Duration(days: 8)),
        ]);
      }
    } catch (e) {
      // safe fallback
      bookedDates.clear();
      debugPrint('Error parsing booked dates: $e');
    }
  }

  bool isDateBooked(DateTime date) {
    return bookedDates.any(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
  }

  LatLng get location {
    // استبدل بهذه الإحداثيات إذا كانت متوفرة في الموديل
    return apartment.latitude != null && apartment.longitude != null
        ? LatLng(apartment.latitude!, apartment.longitude!)
        : const LatLng(33.5138, 36.2765);
  }

  // ------- Actions: call, whatsapp, copy, open maps -------
  Future<void> callOwner() async {
    String rawPhone = phone.value.trim();

    // تنظيف الرقم من أي أحرف غير رقمية
    String cleanPhone = rawPhone.replaceAll(RegExp(r'[^0-9+]'), '');

    // إذا بدأ الرقم بـ 0 نحوله إلى كود سوريا
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '+963${cleanPhone.substring(1)}';
    }

    // إذا لم يبدأ بـ +، أضفه
    if (!cleanPhone.startsWith('+')) {
      cleanPhone = '+$cleanPhone';
    }

    final Uri telUri = Uri(scheme: 'tel', path: cleanPhone);

    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'خطأ',
          'لا يوجد تطبيق هاتف على الجهاز أو المحاكي',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء محاولة الاتصال: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> openWhatsApp() async {
    String rawPhone = phone.value.trim();
    String cleanPhone = rawPhone.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleanPhone.startsWith('0')) {
      cleanPhone = '+963${cleanPhone.substring(1)}';
    }

    if (!cleanPhone.startsWith('+')) {
      cleanPhone = '+$cleanPhone';
    }

    // إزالة علامة + للواتساب
    String waNumber = cleanPhone.replaceFirst('+', '');
    final Uri waUri = Uri.parse('https://wa.me/$waNumber');

    try {
      if (await canLaunchUrl(waUri)) {
        await launchUrl(waUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'خطأ',
          'لا يمكن فتح واتساب على هذا الجهاز',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء فتح واتساب: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> copyPhone() async {
    await Clipboard.setData(ClipboardData(text: phone.value));
    Get.snackbar(
      'تم',
      'تم نسخ الرقم إلى الحافظة',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> openExternalMaps() async {
    final lat = location.latitude;
    final lng = location.longitude;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'خطأ',
        'تعذر فتح الخرائط',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    scrollController?.removeListener(_onScroll);
    scrollController?.dispose();
    super.onClose();
  }
}
