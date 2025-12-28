import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/model/rentelbookingmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseBookingController extends GetxController {
  var list = <BookingModel>[].obs;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var isConfirming = false.obs;
  var isRejecting = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;

  static var pendingCount = 0.obs;
  static var confirmedCount = 0.obs;
  static var cancelledCount = 0.obs;

  String get status;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> handleAccept(int bookingId) async {
    try {
      isConfirming(true);
      final response = await ApiService.postRequest(
        url: urlClient['bookings_accept']!,
        payload: {'booking_id': bookingId},
        useAuth: true,
      );

      if (response['body']['status'] == 1) {
        Get.back();
        list.removeWhere((item) => item.id == bookingId);
        _updateCounts(response['body']['counts']);

        _refreshOtherController<ConfirmedController>();

        Get.snackbar(
          "success".tr,
          "booking_accepted".tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } finally {
      isConfirming(false);
    }
  }

  Future<void> handleCancel(int bookingId) async {
    try {
      isRejecting(true);
      final response = await ApiService.postRequest(
        url: urlClient['bookings_cancel']!,
        payload: {'booking_id': bookingId},
        useAuth: true,
      );

      if (response['body']['status'] == 1) {
        Get.back();
        list.removeWhere((item) => item.id == bookingId);
        _updateCounts(response['body']['counts']);

        _refreshOtherController<CancelledController>();

        Get.snackbar(
          "warning".tr,
          "booking_rejected".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isRejecting(false);
    }
  }

  void _refreshOtherController<T extends BaseBookingController>() {
    if (Get.isRegistered<T>()) {
      Get.find<T>().fetchData();
    }
  }

  void _updateCounts(Map<String, dynamic>? counts) {
    if (counts != null) {
      pendingCount.value = counts['pending'] ?? 0;
      confirmedCount.value = counts['confirmed'] ?? 0;
      cancelledCount.value = counts['cancelled'] ?? 0;
    }
  }

  Future<void> fetchData({bool isRefresh = true}) async {
    try {
      if (isRefresh) {
        _resetPagination();
        isLoading(true);
      }

      final String url =
          "${urlClient['bookings_incoming']}?status=$status&page=$currentPage";
      final response = await ApiService.getRequest(url: url, useAuth: true);
      final serverResponse = response['body'];

      if (serverResponse != null && serverResponse['status'] == 1) {
        _updateCounts(serverResponse['counts']);
        _handleListData(serverResponse['data'], isRefresh);
      }
    } catch (e) {
      debugPrint("Error fetching $status: $e");
    } finally {
      isLoading(false);
      isLoadMore(false);
    }
  }

  void _resetPagination() {
    currentPage = 1;
    hasMoreData = true;
  }

  void _handleListData(Map<String, dynamic> data, bool isRefresh) {
    List rawData = data['data'];
    final List<BookingModel> mappedList = rawData
        .map((item) => BookingModel.fromJson(item))
        .toList();

    if (isRefresh) {
      list.assignAll(mappedList);
    } else {
      list.addAll(mappedList);
    }

    hasMoreData = data['next_page_url'] != null;
  }

  Future<void> loadMore() async {
    if (isLoadMore.value || !hasMoreData) return;
    isLoadMore(true);
    currentPage++;
    await fetchData(isRefresh: false);
  }
}

class PendingController extends BaseBookingController {
  @override
  String get status => 'pending';
}

class ConfirmedController extends BaseBookingController {
  @override
  String get status => 'confirmed';
}

class CancelledController extends BaseBookingController {
  @override
  String get status => 'cancelled';
}
