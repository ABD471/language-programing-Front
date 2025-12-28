import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/testuils/model/apartment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalApartmentController extends GetxController {
  var isLoading = false.obs;
  var apartmentsList = <ApartmentTest>[].obs;

  @override
  void onInit() {
    fetchMyApartments();
    super.onInit();
  }

  Future<void> fetchMyApartments() async {
    try {
      isLoading(true);
      final response = await ApiService.getRequest(
        url: urlClient["renterApartments"]!,
        useAuth: true,
      );

      if (response['statusCode'] == 200) {
        var jsonData = response['body']['apartments']['data'] as List;
        apartmentsList.value = jsonData
            .map((e) => ApartmentTest.fromJson(e))
            .toList();
      } else {
        _showStyledSnackbar(
          title: "error".tr,
          message: "fetch_failed".tr,
          isError: true,
        );
      }
    } catch (e) {
      _showStyledSnackbar(
        title: "error".tr,
        message: "connection_error".tr,
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteApartment(int id) async {
    try {
      isLoading.value = true;
      final response = await ApiService.deleteRequest(
        url: "${urlClient["delete"]!}$id",
        useAuth: true,
      );

      if (response['statusCode'] == 200) {
        apartmentsList.removeWhere((item) => item.id == id);
        _showStyledSnackbar(
          title: "success_title".tr,
          message: "delete_success".tr,
          isError: false,
        );
      } else {
        _showStyledSnackbar(
          title: "error".tr,
          message: "delete_failed".tr,
          isError: true,
        );
      }
    } catch (e) {
      _showStyledSnackbar(
        title: "error".tr,
        message: "connection_error".tr,
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }

  void _showStyledSnackbar({
    required String title,
    required String message,
    required bool isError,
  }) {
    final context = Get.context!;
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDark
          ? (isError
                ? Colors.redAccent.withOpacity(0.8)
                : theme.colorScheme.surface.withOpacity(0.9))
          : (isError ? Colors.red : theme.primaryColor),
      colorText: Colors.white,
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
        size: 28,
      ),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.6 : 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      overlayBlur: isDark ? 1.2 : 0,
    );
  }
}
