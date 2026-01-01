import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/widget/booking_list.dart';
import '../controller/myBookingController.dart';

class MyBookingsScreen extends StatelessWidget {
  MyBookingsScreen({super.key});

  final bookingsController = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = isDark ? Colors.grey[900] : const Color(0xFF2196F3);
    final surfaceColor = isDark
        ? Colors.grey[800]
        : Colors.white.withOpacity(0.2);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Text(
            'my_bookings'.tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8.h),
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h, left: 4.w, right: 4.w),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: isDark ? Colors.white : const Color(0xFF2196F3),
                unselectedLabelColor: isDark ? Colors.white70 : Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
                tabs: [
                  Tab(text: 'pending_tab'.tr),
                  Tab(text: 'completed_tab'.tr),
                  Tab(text: 'cancelled_tab'.tr),
                ],
              ),
            ),
          ),
        ),
        body: GradientBackground(
          child: const TabBarView(
            children: [
              BookingList(status: BookingStatus.pending),
              BookingList(status: BookingStatus.confirmed),
              BookingList(status: BookingStatus.canceled),
            ],
          ),
        ),
      ),
    );
  }
}
