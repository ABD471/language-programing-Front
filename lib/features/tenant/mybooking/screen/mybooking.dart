import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/widget/booking_list.dart';
import '../controller/myBookingController.dart';

class MyBookingsScreen extends StatelessWidget {
  MyBookingsScreen({super.key});

  final bookingsController = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // استخدام خلفية بيضاء مع تدرج خفيف كما في الصور
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          // إزالة أيقونة الإشعارات كما طلبت
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(
            0xFF2196F3,
          ), // لون الـ AppBar الأزرق من صورك
          centerTitle: true,
          title: const Text(
            'حجوزاتي',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.2,
                ), // خلفية شبه شفافة للتبابات
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white, // مؤشر أبيض صريح كما في شاشة "حجوزاتي"
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: const Color(
                  0xFF2196F3,
                ), // لون النص المختار (نفس لون الـ AppBar)
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'قيد الانتظار'),
                  Tab(text: 'مكتملة'),
                  Tab(text: 'ملغاة'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          // إضافة تدرج خلفية يشبه الموجود في صورك
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF2196F3).withOpacity(0.1), Colors.white],
            ),
          ),
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
