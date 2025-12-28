import 'package:apartment_rental_system/features/rentel/home/widget/home/buildAnimatedActionBtn.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/showDeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildApartmentCard(
  BuildContext context,
  apartment,
  ThemeData theme,
  bool isDark,
) {
  return InkWell(
    onTap: () {
      Get.toNamed('/apartment-details-rental', arguments: apartment);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(isDark ? 0.85 : 0.95),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'apt_${apartment.id}',
                  child: ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.4),
                      ],
                    ).createShader(rect),
                    blendMode: BlendMode.darken,
                    child: Image.network(
                      apartment.images[0].url,
                      height: 230,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 230,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image_rounded, size: 60),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor,
                          theme.primaryColor.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 8),
                      ],
                    ),
                    child: Text(
                      "${apartment.price} p.s",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apartment.title ?? "no_title".tr,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on_rounded,
                                size: 16,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),

                            Text(
                              (apartment.address != null)
                                  ? apartment.address!.city
                                  : "no_address".tr,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildAnimatedActionBtn(
                    icon: Icons.edit_note_rounded,
                    color: Colors.blueAccent,
                    onTap: () => Get.toNamed('/edit', arguments: apartment),
                  ),
                  const SizedBox(width: 12),
                  buildAnimatedActionBtn(
                    icon: Icons.delete_sweep_rounded,
                    color: Colors.redAccent,
                    onTap: () => showDeleteDialog(context, apartment.id!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
