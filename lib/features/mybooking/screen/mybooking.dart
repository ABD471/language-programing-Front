// ------------------- شاشة حجوزاتي (Tabs) -------------------
import 'package:apartment_rental_system/main.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حجوزاتي'),
          bottom: const TabBar(
            labelColor: AppTheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppTheme.primary,
            tabs: [
              Tab(text: 'الحالية'),
              Tab(text: 'السابقة'),
              Tab(text: 'الملغاة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingList(status: 'بانتظار الموافقة'),
            _buildBookingList(status: 'مكتملة'),
            _buildBookingList(status: 'ملغاة'),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList({required String status}) {
    // قائمة وهمية للحجوزات
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2, // عنصرين للتجربة
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  dummyApartments[index].imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dummyApartments[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '12-10-2023 إلى 15-10-2023',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'ملغاة'
                            ? Colors.red.withOpacity(0.1)
                            : (status == 'مكتملة'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: status == 'ملغاة'
                              ? Colors.red
                              : (status == 'مكتملة'
                                    ? Colors.green
                                    : Colors.orange),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}