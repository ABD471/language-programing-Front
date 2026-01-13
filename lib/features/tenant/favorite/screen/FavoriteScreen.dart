import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/home/buildEmptyState.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildAppBar.dart';
import 'package:apartment_rental_system/features/tenant/favorite/controller/FavoriteController.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomGlassAppBar(title: "favorites".tr),
      body: GradientBackground(
        child: Obx(() {
          if (controller.isloading.value) {
            return Center(
              child: CircularProgressIndicator(color: theme.primaryColor),
            );
          }

          if (controller.favoriteApartments.isEmpty) {
            return buildEmptyState(theme);
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: kToolbarHeight + 10.h,
              bottom: 2.h,
              left: 4.w,
              right: 4.w,
            ),
            itemCount: controller.favoriteApartments.length,
            itemBuilder: (context, index) {
              final ApartmentTest apartment =
                  controller.favoriteApartments[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: _buildFavoriteCard(
                  context,
                  apartment,
                  controller,
                  theme,
                  isDark,
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildFavoriteCard(
    BuildContext context,
    ApartmentTest apartment,
    FavoriteController controller,
    ThemeData theme,
    bool isDark,
  ) {
    final bool isRtl = Get.locale?.languageCode == 'ar';

    return GestureDetector(
      onTap: () => Get.toNamed('/apartment-details', arguments: apartment),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? theme.cardColor.withOpacity(0.4)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(18.sp),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.sp),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    apartment.images.isNotEmpty
                        ? apartment.images[0].url
                        : 'https://via.placeholder.com/400',
                    height: 22.h, // sizer
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    bottom: 1.5.h,
                    right: isRtl ? null : 4.w,
                    left: isRtl ? 4.w : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Text(
                        '${apartment.price} ${'currency'.tr}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 0.5.h,
                ),
                title: Text(
                  apartment.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 12.sp,
                      color: theme.primaryColor,
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Text(
                        apartment.address.city,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(
                            0.7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 22.sp,
                  ),
                  onPressed: () => controller.toggleFavorite(apartment),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 6.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => controller.toggleBooking(apartment),
                  child: Text(
                    'book_now'.tr,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
