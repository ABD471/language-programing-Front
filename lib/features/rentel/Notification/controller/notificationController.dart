import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/rentel/Notification/model/notificationModel.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;

  bool get hasUnread => notifications.any((n) => !n.isRead);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  /// جلب الإشعارات من السيرفر
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      final response = await ApiService.getRequest(
        url: urlClient['notifications']!,
        useAuth: true,
      );

      if (response["statusCode"] == 200) {
        final List data = response['body']['data']["data"];
        final List<NotificationModel> fetchedList = data
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        notifications.assignAll(fetchedList);
      }
    } catch (e) {
      _showErrorSnackbar("error_fetching_notifications".tr);
    } finally {
      isLoading.value = false;
    }
  }

  /// تعليم إشعار كمقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1 && !notifications[index].isRead) {
        notifications[index].isRead = true;
        notifications.refresh();
      }

      await ApiService.postRequest(
        url: "${urlClient['notifications']}/$notificationId/mark-as-read",
        useAuth: true,
      );
    } catch (e) {
      _showErrorSnackbar("error_marking_notification_read".tr);
      print("Error in markAsRead: $e");
    }
  }

  /// حذف إشعار
  Future<void> deleteNotification(String notificationId) async {
    NotificationModel? deletedItem;
    int? deletedIndex;

    try {
      deletedIndex = notifications.indexWhere((n) => n.id == notificationId);
      if (deletedIndex != -1) {
        deletedItem = notifications[deletedIndex];
        notifications.removeAt(deletedIndex);
      }

      final response = await ApiService.deleteRequest(
        url: "${urlClient['notifications']}/$notificationId",
        useAuth: true,
      );

      if (response['statusCode'] != 200) {
        throw Exception("Failed to delete");
      }
    } catch (e) {
      if (deletedItem != null && deletedIndex != null) {
        notifications.insert(deletedIndex, deletedItem);
      }
      _showErrorSnackbar("error_deleting_notification".tr);
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "error_title".tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
