import 'package:apartment_rental_system/features/tenant/mybooking/controller/myBookingController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import 'booking_card.dart';

class BookingList extends StatelessWidget {
  final BookingStatus status;
  const BookingList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingsController>();

    return Obx(() {
      if (controller.isLoading.value && controller.bookings.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty && controller.bookings.isEmpty) {
        return _buildScrollableEmptyState(
          controller,
          icon: Icons.error_outline,
          message: controller.errorMessage.value.tr,
        );
      }

      final bookings = controller.getBookingsByStatus(status);

      if (bookings.isEmpty) {
        return _buildScrollableEmptyState(
          controller,
          icon: Icons.event_busy_rounded,
          message: 'no_bookings_found'.tr,
        );
      }

      return RefreshIndicator(
        onRefresh: controller.fetchBookings,
        displacement: 4.h,
        edgeOffset: 2.h,
        child: AnimationLimiter(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  curve: Curves.easeOutCubic,
                  child: FadeInAnimation(
                    child: BookingCard(booking: bookings[index]),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildScrollableEmptyState(
    BookingsController controller, {
    required IconData icon,
    required String message,
  }) {
    return RefreshIndicator(
      onRefresh: controller.fetchBookings,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          SizedBox(height: 25.h),
          Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 50.sp, color: Colors.grey.shade400),
                ),
                SizedBox(height: 2.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'pull_to_refresh'.tr,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
