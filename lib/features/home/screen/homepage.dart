import 'package:apartment_rental_system/features/home/widget/apartmentcard.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = 'الكل';
  RangeValues priceRange = const RangeValues(0, 500000);

  @override
  Widget build(BuildContext context) {
    // تصفية القائمة بناءً على المدينة (محاكاة)
    final filteredApartments = selectedCity == 'الكل'
        ? dummyApartments
        : dummyApartments.where((a) => a.city == selectedCity).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'مرحباً، أحمد 👋',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'ابحث عن شقتك القادمة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط المدن الأفقي
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: ['الكل', 'دمشق', 'اللاذقية', 'حلب', 'طرطوس'].map((
                city,
              ) {
                final isSelected = selectedCity == city;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(city),
                    selected: isSelected,
                    onSelected: (bool value) {
                      setState(() {
                        selectedCity = city;
                      });
                    },
                    selectedColor: AppTheme.primary.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.primary : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // قائمة الشقق
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredApartments.length,
              itemBuilder: (context, index) {
                return ApartmentCard(apartment: filteredApartments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تصفية النتائج',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('نطاق السعر (ل.س)'),
              RangeSlider(
                values: priceRange,
                min: 0,
                max: 1000000,
                divisions: 20,
                labels: RangeLabels(
                  '${priceRange.start.round()}',
                  '${priceRange.end.round()}',
                ),
                onChanged: (values) {
                  setState(
                    () => priceRange = values,
                  ); // تحديث الحالة يحتاج StateManagement حقيقي هنا
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('تطبيق'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}