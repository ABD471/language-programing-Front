import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';

class BookingsController extends GetxController {
  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isRatingLoading = false.obs;
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

  // إرسال التقييم إلى السيرفر
  Future<void> submitEvaluation({
    required int apartmentId,
    required double rating,
    required String comment,
  }) async {
    if (rating == 0) {
      _showErrorSnackbar('يرجى اختيار عدد النجوم أولاً');
      return;
    }

    isRatingLoading.value = true;
    try {
      final payload = {"rating": rating.toInt(), "comment": comment};

      final result = await ApiService.postRequest(
        url: "${urlClient['evaluations']}/$apartmentId",
        payload: payload,
        useAuth: true,
      );

      if (result["statusCode"] == 201 || result["statusCode"] == 200) {
        Get.back();
        Get.snackbar(
          'شكراً لك',
          'تم إرسال تقييمك بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        String msg = result["body"]?["message"] ?? 'لا يمكنك التقييم حالياً';
        _showErrorSnackbar(msg);
      }
    } catch (e) {
      _showErrorSnackbar('خطأ في الاتصال: $e');
    } finally {
      isRatingLoading.value = false;
    }
  }

  void openRatingDialog(Booking booking) {
    double selectedRating = 0;
    final TextEditingController commentController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("تقييم ${booking.apartment.title}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) => selectedRating = rating,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "اكتب تجربتك هنا (اختياري)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("إلغاء")),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: isRatingLoading.value
                  ? null
                  : () => submitEvaluation(
                      apartmentId: booking.apartmentId,
                      rating: selectedRating,
                      comment: commentController.text,
                    ),
              child: isRatingLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Text(
                      "إرسال التقييم",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
