import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/widget/BookingListPage.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/widget/buildTab.dart';
import '../controller/incomingBookingController.dart';

class IncomingBookingsScreen extends StatelessWidget {
  const IncomingBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeControllers();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: CustomGlassAppBar(
          title: "booking_requests".tr,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8.h),
            child: _buildTabBar(),
          ),
        ),
        body: GradientBackground(
          child: const TabBarView(
            children: [
              BookingListPage<PendingController>(),
              BookingListPage<ConfirmedController>(),
              BookingListPage<CancelledController>(),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeControllers() {
    Get.put(PendingController());
    Get.put(ConfirmedController());
    Get.put(CancelledController());
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      isScrollable: true,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      tabAlignment: TabAlignment.start,
      tabs: [
        _buildAnimatedTab("new_requests".tr, Icons.bolt, 
            BaseBookingController.pendingCount, Colors.orange),
        _buildAnimatedTab("confirmed_requests".tr, Icons.check_circle, 
            BaseBookingController.confirmedCount, Colors.green),
        _buildAnimatedTab("cancelled_requests".tr, Icons.cancel, 
            BaseBookingController.cancelledCount, Colors.red),
      ],
    );
  }

  Widget _buildAnimatedTab(String label, IconData icon, RxInt count, Color color) {
    return Obx(() => buildTab(
          label,
          icon,
          count.value,
          color,
        ));
  }
}