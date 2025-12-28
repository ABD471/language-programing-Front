import 'package:apartment_rental_system/features/rentel/Chat/screen/chatBoxScreen.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/rental_home_view.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/screen/incomingBookingsScreen.dart';
import 'package:flutter/material.dart';

import 'package:apartment_rental_system/features/tenant/settings/screen/settings.dart'; // يمكن إعادة استخدام نفس شاشة الإعدادات

class RentalMainWrapper extends StatefulWidget {
  const RentalMainWrapper({super.key});

  @override
  State<RentalMainWrapper> createState() => _RentalMainWrapperState();
}

class _RentalMainWrapperState extends State<RentalMainWrapper> {
  int _currentIndex = 0;

  // شاشات صاحب الشقة
  final List<Widget> _screens = [
    MyApartmentsScreen(), // الشاشة التي تعرض شققه (CRUD)
    IncomingBookingsScreen(), // الشاشة التي تعرض طلبات الحجز من المستأجرين
    ChatBoxScreen(), // شاشة المحادثات

    SettingsScreen(), // الملف الشخصي والإعدادات
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_work_outlined),
            selectedIcon: Icon(Icons.home_work),
            label: 'عقاراتي',
          ),
          NavigationDestination(
            icon: Icon(Icons.notification_important_outlined),
            selectedIcon: Icon(Icons.notification_important),
            label: 'الطلبات',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'المحادثات',
          ),
          NavigationDestination(
            icon: Icon(Icons.manage_accounts_outlined),
            selectedIcon: Icon(Icons.manage_accounts),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
