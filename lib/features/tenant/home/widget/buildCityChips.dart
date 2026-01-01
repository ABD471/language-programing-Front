import 'package:apartment_rental_system/features/tenant/home/controller/homeController.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String allText = 'all'.tr;
    final List<String> allOptions = [allText, ...cities];

    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: allOptions.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final city = allOptions[i];

          return Obx(() {
            final isSelected =
                (city == allText && controller.selectedCity.value.isEmpty) ||
                controller.selectedCity.value == city;

            return ChoiceChip(
              label: Text(city),
              selected: isSelected,
              onSelected: (_) =>
                  controller.changeCity(city == allText ? "" : city),
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.grey[300] : Colors.black87),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
              selectedColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? theme.primaryColor
                      : (isDark ? Colors.white10 : Colors.transparent),
                ),
              ),
              elevation: isSelected ? 4 : 0,
              shadowColor: theme.primaryColor.withOpacity(0.4),
            );
          });
        },
      ),
    );
  }
}
