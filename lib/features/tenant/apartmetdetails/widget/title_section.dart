import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSectionTest extends StatelessWidget {
  final ApartmentTest apartment;
  const TitleSectionTest({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    // استدعاء بيانات الثيم الحالية
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            apartment.title!,

            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${apartment.price} ل.س',
              style: TextStyle(
                fontSize: 20,
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'في الليلة',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
