import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/screen/apartmentdetails.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentTest apartment;
  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () =>
          Get.to(() => ApartmentDetailsScreenTest(apartment: apartment)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isDark ? Border.all(color: Colors.white10) : null,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(isDark),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apartment.title ?? 'no_title'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailsRow(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(bool isDark) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Image.network(
        apartment.images.first.url ?? '',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 200,
          color: isDark ? Colors.grey[800] : Colors.grey[300],
          child: Icon(
            Icons.image_not_supported,
            color: isDark ? Colors.grey[600] : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsRow(bool isDark) {
    final subColor = isDark ? Colors.grey[400] : Colors.grey;
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 16, color: subColor),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            apartment.address.city ?? 'unknown_location'.tr,
            style: TextStyle(color: subColor),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${apartment.price} ${'currency'.tr}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.primary,
              ),
            ),
            Text(
              '/ ${'per_night'.tr}',
              style: TextStyle(
                color: isDark ? Colors.grey[500] : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
