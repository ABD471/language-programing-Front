import 'package:apartment_rental_system/features/tenant/home/widget/customChoiceChipState.dart';
import 'package:apartment_rental_system/testuils/controoler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityChipsTest extends StatelessWidget {
  final List<String> cities;
  final HomeTestController controller;

  const CityChipsTest({
    super.key,
    required this.cities,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: cities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final city = cities[i];
          return Obx(() {
            final selected = controller.selectedCity.value == city;
            return GestureDetector(
              onTap: () => controller.changeCity(city),
              child: CustomChoiceChip(label: city, selected: selected),
            );
          });
        },
      ),
    );
  }
}
