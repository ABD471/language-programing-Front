import 'package:apartment_rental_system/features/tenant/mybooking/controller/bookingDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookingEditSheet extends StatelessWidget {
  final BookingDetailsController controller;

  const BookingEditSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.sp)),
          boxShadow: isDark
              ? [
                  const BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.6.h,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'edit_booking_date'.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              _buildDateTile(
                context,
                icon: Icons.calendar_today,
                title: 'start_date'.tr,
                date: controller.startDate.toString().split(' ')[0],
                onTap: () => controller.pickDate(context, true),
              ),
              const Divider(height: 1),
              _buildDateTile(
                context,
                icon: Icons.calendar_month,
                title: 'end_date'.tr,
                date: controller.endDate.toString().split(' ')[0],
                onTap: () => controller.pickDate(context, false),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.updateBooking,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'save_changes'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String date,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor, size: 18.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 10.sp, color: Theme.of(context).hintColor),
      ),
      subtitle: Text(
        date,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).hintColor,
        size: 18.sp,
      ),
      onTap: onTap,
    );
  }
}
