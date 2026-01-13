import 'package:apartment_rental_system/features/tenant/favorite/controller/FavoriteController.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/priceTag.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/ratingStars.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ParallaxApartmentCardTest extends StatefulWidget {
  final ApartmentTest apartment;
  final VoidCallback? onTap;

  const ParallaxApartmentCardTest({
    super.key,
    required this.apartment,
    this.onTap,
  });

  @override
  State<ParallaxApartmentCardTest> createState() =>
      _ParallaxApartmentCardState();
}

class _ParallaxApartmentCardState extends State<ParallaxApartmentCardTest> {
  double _dy = 0;

  void _onPointerMove(PointerEvent e) {
    setState(() {
      _dy = (e.localPosition.dy - 10.h) / 100.h;
    });
  }

  void _onPointerExit(PointerEvent e) => setState(() => _dy = 0);

  @override
  Widget build(BuildContext context) {
    final apartment = widget.apartment;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onExit: _onPointerExit,
      onHover: _onPointerMove,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E26) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black87 : Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _buildParallaxImage(apartment),
                  _buildFavoriteButton(),
                  _buildPriceOverlay(apartment),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            apartment.title.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                          ),
                        ),

                        Transform.scale(
                          scale: 1.2,
                          child: RatingStars(
                            rating: apartment.averageRating,
                            totalReviews: apartment.reviewsCount,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppTheme.primary,
                          size: 2.4.h,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          apartment.address.city.tr,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 1.2,
                        height: 1,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeatureIcon(
                          Icons.king_bed_rounded,
                          "${apartment.bedrooms} ${'beds'.tr}",
                        ),
                        _buildFeatureIcon(
                          Icons.shower_rounded,
                          "${apartment.bathrooms} ${'baths'.tr}",
                        ),
                        _buildFeatureIcon(
                          Icons.straighten_rounded,
                          "${apartment.area} m²",
                        ),
                      ],
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

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 2.8.h, color: Colors.blueGrey[700]),
        SizedBox(width: 1.5.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceOverlay(ApartmentTest apartment) {
    return Positioned(
      bottom: 2.h,
      left: 4.w,
      child: Transform.scale(
        scale: 1.2,
        child: PriceTag(amount: double.tryParse(apartment.price) ?? 0),
      ),
    );
  }

  Widget _buildParallaxImage(ApartmentTest apartment) {
    return SizedBox(
      height: 25.h,
      width: double.infinity,
      child: Transform.scale(
        scale: 1.15,
        child: Transform.translate(
          offset: Offset(0, _dy * 4.h),
          child: Image.network(
            apartment.images.isNotEmpty ? apartment.images[0].url : '',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: Icon(Icons.broken_image, color: Colors.grey, size: 5.h),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    final FavoriteController favController = Get.find<FavoriteController>();
    final String apartmentId = widget.apartment.id.toString();

    return Positioned(
      top: 2.h,
      right: 4.w,
      child: Obx(() {
        bool isFav = favController.isFavorite(apartmentId);
        return GestureDetector(
          onTap: () => favController.toggleFavorite(widget.apartment),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.grey[800],
              size: 2.8.h,
            ),
          ),
        );
      }),
    );
  }
}
