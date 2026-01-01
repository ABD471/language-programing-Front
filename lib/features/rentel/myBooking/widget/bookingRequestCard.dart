import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/controller/incomingBookingController.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/model/rentelbookingmodel.dart';

class BookingRequestCard extends StatelessWidget {
  final BookingModel booking;

  const BookingRequestCard({super.key, required this.booking});

  BaseBookingController _getController() {
    String status = booking.status.toLowerCase();
    if (status == 'confirmed') return Get.find<ConfirmedController>();
    if (status == 'cancelled') return Get.find<CancelledController>();
    return Get.find<PendingController>();
  }

  @override
  Widget build(BuildContext context) {
    final status = booking.status.toLowerCase();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeController = _getController();

    return Container(
      margin: EdgeInsets.only(bottom: 2.h, left: 4.w, right: 4.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.sp),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: _buildCardDecoration(isDark),
            child: Column(
              children: [
                _buildGlassHeader(status),
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(),
                      SizedBox(height: 2.h),
                      _buildStayGlassInfo(),
                      SizedBox(height: 2.h),
                      _buildTenantSection(),
                      if (status == 'pending') ...[
                        SizedBox(height: 2.5.h),
                        _buildActionButtons(activeController),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark
          ? Colors.black.withOpacity(0.4)
          : Colors.white.withOpacity(0.6),
      borderRadius: BorderRadius.circular(20.sp),
      border: Border.all(
        color: isDark
            ? Colors.white.withOpacity(0.2)
            : Colors.grey.withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Row(
      children: [
        _buildGlowingIcon(),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            booking.apartment.title,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassHeader(String status) {
    var config = _getStatusConfig(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: (config['color'] as Color).withOpacity(0.15),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(config['icon'], color: config['color'], size: 20.sp),
              SizedBox(width: 2.w),
              Text(
                config['label'],
                style: TextStyle(
                  color: config['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Text(
            "#${booking.id}",
            style: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildStayGlassInfo() {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoColumn("check_in".tr, _formatDate(booking.startDate)),
          _divider(),
          _infoColumn("duration".tr, "${_calculateNights()} ${"nights".tr}"),
          _divider(),
          _infoColumn("check_out".tr, _formatDate(booking.endDate)),
        ],
      ),
    );
  }

  Widget _buildTenantSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.sp,
          backgroundColor: Colors.blueGrey.withOpacity(0.2),
          child: Icon(Icons.person, color: Colors.blueGrey, size: 20.sp),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.tenant.email,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                booking.tenant.phone,
                style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () => launchUrl(Uri.parse("tel:${booking.tenant.phone}")),
          icon: Icon(Icons.call, size: 20.sp),
          style: IconButton.styleFrom(
            backgroundColor: Colors.green.withOpacity(0.2),
            foregroundColor: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BaseBookingController activeController) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _customButton(
            label: "accept_booking".tr,
            color: Colors.green,
            onTap: () => _showConfirmDialog(
              activeController: activeController,
              title: "accept_booking".tr,
              message: "confirm_accept_msg".tr,
              confirmText: "yes_confirm".tr,
              color: Colors.green,
              onConfirm: () => activeController.handleAccept(booking.id),
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _customButton(
            label: "reject".tr,
            color: Colors.red,
            isOutlined: true,
            onTap: () => _showConfirmDialog(
              activeController: activeController,
              title: "cancel_booking".tr,
              message: "confirm_cancel_msg".tr,
              confirmText: "yes_reject".tr,
              color: Colors.red,
              onConfirm: () => activeController.handleCancel(booking.id),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.transparent : color,
        foregroundColor: isOutlined ? color : Colors.white,
        side: isOutlined ? BorderSide(color: color.withOpacity(0.3)) : null,
        elevation: isOutlined ? 0 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
      ),
    );
  }

  void _showConfirmDialog({
    required BaseBookingController activeController,
    required String title,
    required String message,
    required String confirmText,
    required Color color,
    required VoidCallback onConfirm,
  }) {
    // معرفة حالة الثيم داخل الدالة
    final bool isDark = Get.isDarkMode;

    Get.dialog(
      Obx(() {
        final bool isBusy =
            activeController.isConfirming.value ||
            activeController.isRejecting.value;

        return PopScope(
          canPop: !isBusy,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AlertDialog(
              // تغيير الخلفية بناءً على الوضع
              backgroundColor: isDark
                  ? Colors.grey[900]!.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
                side: BorderSide(
                  color: isDark ? Colors.white10 : Colors.black12,
                  width: 1,
                ),
              ),
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: color, // يبقى لون الأكشن (أخضر للقبول، أحمر للرفض)
                  fontSize: 16.sp,
                ),
              ),
              content: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                if (!isBusy)
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: isBusy ? null : onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    minimumSize: Size(35.w, 5.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                  ),
                  child: isBusy
                      ? SizedBox(
                          width: 14.sp,
                          height: 14.sp,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          confirmText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      }),
      barrierDismissible: false,
    );
  }

  // الدوال المساعدة للتحويلات والحسابات
  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'confirmed':
        return {
          'color': Colors.green,
          'label': 'confirmed_requests'.tr,
          'icon': Icons.check_circle,
        };
      case 'cancelled':
        return {
          'color': Colors.red,
          'label': 'cancelled_requests'.tr,
          'icon': Icons.cancel,
        };
      default:
        return {
          'color': Colors.orange,
          'label': 'new_requests'.tr,
          'icon': Icons.watch_later,
        };
    }
  }

  int _calculateNights() {
    try {
      DateTime start = DateTime.parse(booking.startDate);
      DateTime end = DateTime.parse(booking.endDate);
      return end.difference(start).inDays;
    } catch (e) {
      return 0;
    }
  }

  String _formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Widget _infoColumn(String label, String val) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
        ),
        SizedBox(height: 0.5.h),
        Text(
          val,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 3.h, color: Colors.white.withOpacity(0.2));

  Widget _buildGlowingIcon() {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.amber.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Icon(Icons.home_work, color: Colors.amber, size: 22.sp),
    );
  }
}
