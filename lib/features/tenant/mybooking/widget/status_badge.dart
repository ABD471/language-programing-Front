import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.orange;
    Color statusBgColor = Colors.orange.withOpacity(0.1);
    IconData statusIcon = Iconsax.clock;
    String statusText = 'بانتظار الموافقة';

    switch (status) {
      case BookingStatus.canceled:
        statusColor = Colors.red;
        statusBgColor = Colors.red.withOpacity(0.1);
        statusIcon = Iconsax.close_circle;
        statusText = 'ملغاة';
        break;
      case BookingStatus.confirmed:
        statusColor = Colors.green;
        statusBgColor = Colors.green.withOpacity(0.1);
        statusIcon = Iconsax.tick_circle;
        statusText = 'مكتملة';
        break;
      case BookingStatus.pending:
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withOpacity(0.1);
        statusIcon = Iconsax.clock;
        statusText = 'بانتظار الموافقة';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(statusIcon, size: 14, color: statusColor),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 12,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
