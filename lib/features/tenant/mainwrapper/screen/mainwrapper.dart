import 'package:apartment_rental_system/common/features/Chat/screen/chatBoxScreen.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/screen/mybooking.dart';
import 'package:apartment_rental_system/common/features/settings/screen/settings.dart';
import 'package:apartment_rental_system/features/tenant/home/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  
  final List<Widget> _screens = [
    const HomeTest(),
   MyBookingsScreen(),
    ChatBoxScreen(), 
     SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        height: 8.h, 
        elevation: 0,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.search, size: 2.8.h), 
            label: 'nav_explore'.tr, 
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border, size: 2.8.h),
            selectedIcon: Icon(Icons.bookmark, size: 2.8.h),
            label: 'nav_bookings'.tr, 
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline, size: 2.8.h),
            selectedIcon: Icon(Icons.chat_bubble, size: 2.8.h),
            label: 'nav_chats'.tr, 
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: 2.8.h),
            selectedIcon: Icon(Icons.person, size: 2.8.h),
            label: 'nav_profile'.tr, 
          ),
        ],
      ),
    );
  }
}