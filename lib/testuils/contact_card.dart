import 'package:apartment_rental_system/testuils/contreeelrer.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContactCardTest extends StatelessWidget {
  final ApartmentDetailsControllerTest controller;
  const ContactCardTest({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  child: Icon(Icons.person, color: AppTheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'للتواصل مع المالك',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.phone.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'متاح الآن للمراسلة أو الاتصال',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // زر النسخ تم نقله هنا لترتيب المساحة في الأسفل
                IconButton(
                  onPressed: controller.copyPhone,
                  icon: const Icon(Icons.copy, color: Colors.grey, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // صف أزرار التواصل
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        '/chatScreen',
                        arguments: {
                          'receiverId': controller.apartment.ownerId,
                          'receiverName': controller.apartment.owner.email,
                          'currentUserId': int.parse(AuthService.userId!),
                        },
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('محادثة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // زر الاتصال
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.callOwner,
                    icon: const Icon(Icons.call, size: 18),
                    label: const Text('اتصال'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // زر واتساب
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.openWhatsApp,
                    icon: const Icon(Icons.message, size: 18),
                    label: const Text('واتساب'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
