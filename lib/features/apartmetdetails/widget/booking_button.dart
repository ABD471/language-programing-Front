import 'package:apartment_rental_system/features/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingButton extends StatelessWidget {
  final ApartmentDetailsController controller;
  const BookingButton({super.key, required this.controller});

  void _showConfirmation() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 72),
            const SizedBox(height: 12),
            Text(
              'طلب الحجز تم إرساله!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'تم إرسال طلبك للمالك. سيتم التواصل معك قريباً',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('تم'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final apt = controller.apartment;
    return SafeArea(
      minimum: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Get.snackbar('مفضلة', 'تم إضافة للمفضلة'),
                icon: const Icon(
                  Icons.star_border_rounded,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _showConfirmation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${apt.price?.toInt()}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        const Text('ل.س'),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.shopping_bag_rounded),
                        SizedBox(width: 8),
                        Text(
                          'احجز الآن',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
