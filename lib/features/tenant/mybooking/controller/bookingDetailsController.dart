import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/controller/myBookingController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../model/bookingModel.dart';

class BookingDetailsController extends GetxController {
  late Rx<Booking> booking;

  RxBool isLoading = false.obs;

  BookingDetailsController(Booking initialBooking) {
    booking = initialBooking.obs;
  }

  /// اختصار للوصول
  Apartment get apartment => booking.value.apartment;

  DateTime get startDate => booking.value.startDate;
  DateTime get endDate => booking.value.endDate;

  /// لون الحالة
  Color get statusColor {
    switch (booking.value.status.name) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  /// اختيار تاريخ
  Future<void> pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final current = booking.value;

      booking.value = current.copyWith(
        startDate: isStart ? picked : current.startDate,
        endDate: isStart
            ? (picked.isAfter(current.endDate)
                  ? picked.add(const Duration(days: 1))
                  : current.endDate)
            : picked,
      );
    }
  }

  Future<void> cancelBooking() async {
    // أولًا نعرض رسالة تأكيد
    Get.defaultDialog(
      title: 'تأكيد الإلغاء',
      middleText: 'هل أنت متأكد من إلغاء الحجز؟',
      textCancel: 'لا',
      textConfirm: 'نعم، إلغاء',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back(); // إغلاق الديالوج

        isLoading.value = true;
        try {
          final payload = {"bookingId": booking.value.id};

          final result = await ApiService.deleteRequest(
            url: urlClient["cancelBooking"]!,
            payload: payload,
            useAuth: true,
          );

          if (result["statusCode"] == 204) {
            Get.back();
            final bookingsController = Get.find<BookingsController>();
            bookingsController.bookings.removeWhere(
              (b) => b.id == booking.value.id,
            );
            bookingsController.bookings.refresh();
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
      },
    );
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

  /// حفظ التعديل

  Future<void> updateBooking() async {
    isLoading.value = true;

    try {
      final payload = {
        "bookingId": booking.value.id,
        "start_date": booking.value.startDate.toIso8601String(),
        "end_date": booking.value.endDate.toIso8601String(),
      };

      final result = await ApiService.postRequest(
        url: urlClient['updateBooking']!,
        useAuth: true,
        payload: payload,
      );

      if (result["body"]['status'] == 1 && result["statusCode"] == 202) {
        // إذا كان هناك تعديل في انتظار الموافقة (Tenant)
        final message = result["body"]['message'] ?? 'تم تعديل الحجز بنجاح';

        // تحديث بيانات الحجز محليًا
        if (result["body"]['data'] != null) {
          booking.value = Booking.fromJson(
            result["body"]['data'],
            existingApartment: booking.value.apartment,
          );
        }

        Get.back(); // إغلاق الـ BottomSheet
        Get.snackbar(
          'نجاح',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          margin: const EdgeInsets.all(15),
        );
      } else {
        // رسالة خطأ من السيرفر
        _showErrorSnackbar(result['message'] ?? 'فشل تعديل الحجز');
      }
    } catch (e) {
      _showErrorSnackbar('حدث خطأ أثناء الاتصال: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
