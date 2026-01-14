import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';

import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContactCardTest extends StatelessWidget {
  final ApartmentDetailsControllerTest controller;
  const ContactCardTest({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'للتواصل مع المالك',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.phone.value,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton.filledTonal(
                  onPressed: controller.copyPhone,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.white10
                        : Colors.grey.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.chat_bubble_rounded,
                  label: 'محادثة',
                  color: theme.colorScheme.primary,
                  onTap: () {
                    Get.toNamed(
                      '/chatScreen',
                      arguments: {
                        'receiverId': controller.apartment.ownerId,
                        'receiverName': controller.apartment.owner.email,
                        'currentUserId': int.parse(AuthService.userId!),
                      },
                    );
                  },
                ),
                const SizedBox(width: 8),
                // زر الاتصال
                _buildActionButton(
                  context,
                  icon: Icons.call_rounded,
                  label: 'اتصال',
                  color: Colors.blue.shade600,
                  onTap: controller.callOwner,
                ),
                const SizedBox(width: 8),
               
                _buildActionButton(
                  context,
                  icon: Icons.message_rounded,
                  label: 'واتساب',
                  color: const Color(0xFF25D366),
                  onTap: controller.openWhatsApp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 1.2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
