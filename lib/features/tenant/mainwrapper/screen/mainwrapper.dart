import 'package:apartment_rental_system/features/rentel/Chat/screen/chatBoxScreen.dart';
import 'package:apartment_rental_system/features/tenant/home/screen/homepage.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/screen/mybooking.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/settings.dart';
import 'package:apartment_rental_system/testuils/homepage.dart';
import 'package:flutter/material.dart';

// ------------------- الحاوية الرئيسية (Bottom Navigation) -------------------
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeTest(),
    MyBookingsScreen(),
    ChatBoxScreen(), // شاشة المحادثات
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'اكتشف'),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'حجوزاتي',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'المحادثات',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'ملفي',
          ),
        ],
      ),
    );
  }
}
