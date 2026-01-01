import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';

class BookingsController extends GetxController {
  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() async {
    
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await ApiService.getRequest(
        url: urlClient['showBooking']!,
        useAuth: true,
      );

      if (result["body"]['status'] == 1 && result["statusCode"] == 200) {
        final List data = result["body"]['data']["data"];
        print("Raw Data from Server: ${data.map((e) => e['status']).toList()}");
        bookings.assignAll(data.map((b) => Booking.fromJson(b)).toList());
      } else {
        errorMessage.value = result['message'] ?? 'فشل جلب الحجوزات';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ: $e';
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  List<Booking> getBookingsByStatus(BookingStatus status) {
    return bookings.where((b) => b.status == status).toList();
  }

  Future<void> cancelBooking(Booking booking) async {
    isLoading.value = true;
    try {
      final payload = {"bookingId": booking.id};

      final result = await ApiService.deleteRequest(
        url: urlClient["cancelBooking"]!,
        payload: payload,
        useAuth: true,
      );

      if (result["statusCode"] == 204) {
        bookings.removeWhere((item) => item.id == booking.id);

        bookings.refresh();

        Get.snackbar(
          'نجاح',
          'تم حذف الحجز بنجاح',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          margin: const EdgeInsets.all(15),
        );
      } else {
        // رسالة خطأ في حال فشل الـ API
        _showErrorSnackbar(result['message'] ?? 'فشل إلغاء الحجز');
      }
    } catch (e) {
      _showErrorSnackbar('حدث خطأ أثناء الاتصال: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // دالة مساعدة لإظهار أخطاء الـ Snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }
}
