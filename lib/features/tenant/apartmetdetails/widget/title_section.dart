import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/model/Apartment.dart';

class TitleSection extends StatelessWidget {
  final Apartment apartment;
  const TitleSection({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            apartment.title!,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${apartment.price?.toInt()} ل.س',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text('في الليلة', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }
}
