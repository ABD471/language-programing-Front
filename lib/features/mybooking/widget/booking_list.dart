import 'package:apartment_rental_system/features/mybooking/controller/myBookingController.dart';
import 'package:apartment_rental_system/features/mybooking/widget/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class BookingList extends StatelessWidget {
  final BookingStatus status;
  const BookingList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingsController>();
    return Obx(() {
      final bookings = controller.getBookingsByStatus(status);
      return AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: BookingCard(booking: bookings[index]),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
