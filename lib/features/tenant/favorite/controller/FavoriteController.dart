import 'dart:convert';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FavoriteController extends GetxController {
  RxList<ApartmentTest> favoriteApartments = <ApartmentTest>[].obs;
  var isloading = false.obs;
  var selectedDateRange = Rx<DateTimeRange?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  void _loadFavorites() {
    List<String>? savedJsonList = sharedPreferences.getStringList(
      'favorite_apartments',
    );
    if (savedJsonList != null) {
      try {
        favoriteApartments.assignAll(
          savedJsonList
              .map((item) => ApartmentTest.fromJson(jsonDecode(item)))
              .toList(),
        );
      } catch (e) {
        print("Error decoding favorites: $e");
      }
    }
  }

  Future<void> _saveToPrefs() async {
    List<String> jsonList = favoriteApartments
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await sharedPreferences.setStringList('favorite_apartments', jsonList);
  }

  void toggleFavorite(ApartmentTest apartment) async {
    int index = favoriteApartments.indexWhere(
      (element) => element.id == apartment.id,
    );
    if (index != -1) {
      favoriteApartments.removeAt(index);
    } else {
      favoriteApartments.add(apartment);
    }
    await _saveToPrefs();
  }

  Future<void> toggleBooking(ApartmentTest apartment) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: selectedDateRange.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDateRange.value = picked;
      await _executeBookingRequest(apartment);
    } else {
      Get.snackbar('notify'.tr, 'booking_cancelled'.tr);
    }
  }

  Future<void> _executeBookingRequest(ApartmentTest apartment) async {
    if (selectedDateRange.value == null) return;
    isloading.value = true;

    try {
      String formatDate(DateTime date) =>
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

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

      if ((statusCode == 200 || statusCode == 201) && body["status"] == 1) {
        showDialogWithLottie(
          title: "success_title".tr,
          message: "booking_success_msg".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
      } else if (statusCode == 401) {
        Get.snackbar('error_title'.tr, 'unauthorized_error'.tr);
      } else if (statusCode == 409) {
        Get.snackbar('conflict_title'.tr, message);
      } else {
        showDialogWithLottie(
          title: "error_title".tr,
          message: message.isNotEmpty
              ? message
              : "${'error_code'.tr}: $statusCode",
          lottieAsset: "assets/lottie/Alert.json",
        );
      }
    } catch (e) {
      showDialogWithLottie(
        title: "exception_title".tr,
        message: "${'error_occurred'.tr}: $e",
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
      buttonColor: Get.theme.primaryColor,
      onConfirm: () => Get.back(),
    );
  }

  bool isFavorite(String id) {
    int? numericId = int.tryParse(id);
    if (numericId == null) return false;

    bool isfa = favoriteApartments.any((element) => element.id == numericId);

    return isfa;
  }
}
