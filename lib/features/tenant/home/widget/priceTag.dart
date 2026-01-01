import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class PriceTag extends StatelessWidget {
  final double amount;
  const PriceTag({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    // تنسيق الأرقام (إضافة الفواصل)
    final formatter = NumberFormat('#,###');
    final formattedAmount = formatter.format(amount);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h), // Resize
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withBlue(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8), // الحواف متناسقة مع التصميم
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 0.4.h), // Resize shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formattedAmount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp, // Resize font
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: 1.5.w), // Resize spacing
          Text(
            'currency'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.sp, // Resize font
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
