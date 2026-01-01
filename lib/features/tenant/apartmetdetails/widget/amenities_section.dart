import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:flutter/material.dart';

class AmenitiesSectionTest extends StatelessWidget {
  final ApartmentTest apartment;
  const AmenitiesSectionTest({super.key, required this.apartment});

  Widget _buildChip(BuildContext context, String text) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(
        left: 8,
        bottom: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
       
        color: isDark
            ? theme.colorScheme.surfaceBright.withOpacity(0.1)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        
        border: Border.all(
          color: isDark
              ? theme.colorScheme.outline.withOpacity(0.2)
              : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
       
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final amenities = [
      '🛏 ${apartment.bedrooms} غرف',
      '🚿 ${apartment.bathrooms} حمامات',
      '📐 ${apartment.area} م²',
    ];

    return Wrap(
      // استخدام النص العربي (Right-to-Left)
      alignment: WrapAlignment.start,
      children: amenities.map((item) => _buildChip(context, item)).toList(),
    );
  }
}
