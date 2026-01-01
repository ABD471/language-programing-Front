import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case BookingStatus.canceled:
        statusColor = isDark ? Colors.redAccent : Colors.red;
        statusIcon = Iconsax.close_circle;
        statusText = 'status_cancelled'.tr;
        break;
      case BookingStatus.confirmed:
        statusColor = isDark ? Colors.greenAccent : Colors.green;
        statusIcon = Iconsax.tick_circle;
        statusText = 'status_completed'.tr;
        break;
      case BookingStatus.pending:
        statusColor = isDark ? Colors.orangeAccent : Colors.orange;
        statusIcon = Iconsax.clock;
        statusText = 'status_pending'.tr;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: isDark
            ? Border.all(color: statusColor.withOpacity(0.3), width: 0.5)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 12.sp, color: statusColor),
          SizedBox(width: 1.5.w),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 10.sp,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
