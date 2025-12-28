import 'package:apartment_rental_system/testuils/model/apartment.dart';
import 'package:flutter/material.dart';

class AmenitiesSectionTest extends StatelessWidget {
  final ApartmentTest apartment;
  const AmenitiesSectionTest({super.key, required this.apartment});

  Widget _buildChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final amenities = [
      '🛏 ${apartment.bedrooms} غرف',
      '🚿 ${apartment.bathrooms} حمامات',
      '📐 ${apartment.area} م²',
    ];

    return Wrap(children: amenities.map(_buildChip).toList());
  }
}
