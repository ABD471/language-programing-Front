import 'package:apartment_rental_system/common/features/Chat/screen/chatBoxScreen.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/rental_home_view.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/screen/incomingBookingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/common/features/settings/screen/settings.dart';

class RentalMainWrapper extends StatefulWidget {
  const RentalMainWrapper({super.key});

  @override
  State<RentalMainWrapper> createState() => _RentalMainWrapperState();
}

class _RentalMainWrapperState extends State<RentalMainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MyApartmentsScreen(),
    const IncomingBookingsScreen(),
    ChatBoxScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 8.h,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_work_outlined, size: 20.sp),
            selectedIcon: Icon(Icons.home_work, size: 20.sp),
            label: 'nav_my_apartments'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.notification_important_outlined, size: 20.sp),
            selectedIcon: Icon(Icons.notification_important, size: 20.sp),
            label: 'nav_requests'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline, size: 20.sp),
            selectedIcon: Icon(Icons.chat_bubble, size: 20.sp),
            label: 'nav_chats'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.manage_accounts_outlined, size: 20.sp),
            selectedIcon: Icon(Icons.manage_accounts, size: 20.sp),
            label: 'nav_profile'.tr,
          ),
        ],
      ),
    );
  }
}
