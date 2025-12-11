import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/mybooking/controller/myBookingController.dart';
import 'package:apartment_rental_system/features/mybooking/widget/booking_list.dart';
import 'package:apartment_rental_system/features/mybooking/widget/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookingsScreen extends StatelessWidget {
  MyBookingsScreen({super.key});

  final bookingsController = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حجوزاتي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: theme.primaryColor,
          elevation: 13,
          foregroundColor: Colors.black,

          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TabBarWidget(),
            ),
          ),
        ),
        body: GradientBackground(
          child: const TabBarView(
            children: [
              BookingList(status: BookingStatus.pending),
              BookingList(status: BookingStatus.completed),
              BookingList(status: BookingStatus.canceled),
            ],
          ),
        ),
      ),
    );
  }
}
