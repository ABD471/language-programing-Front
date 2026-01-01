import 'package:apartment_rental_system/features/rentel/home/widget/home/buildAnimatedActionBtn.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/showDeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(isDark ? 0.85 : 0.95),
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 6.w,
            offset: Offset(0, 1.5.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
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
                      height: 28.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 28.h,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image_rounded, size: 40.sp),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 2.h,
                  left: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
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
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 8),
                      ],
                    ),
                    child: Text(
                      "${apartment.price} " + "price_unit".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
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
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on_rounded,
                                size: 15.sp,
                                color: theme.primaryColor,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              (apartment.address != null)
                                  ? apartment.address!.city
                                  : "no_address".tr,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
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
                  SizedBox(width: 3.w),
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
