import 'package:apartment_rental_system/features/tenant/home/widget/priceTag.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
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

  // Logic for parallax movement based on hover/pointer
  void _onPointerMove(PointerEvent e) {
    setState(() {
      _dy =
          (e.localPosition.dy - 10.h) / 100.h; // Adjusted for responsive height
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
          curve: Curves.easeOut,
          margin: EdgeInsets.symmetric(vertical: 1.h), // Resize
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black45 : Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: Offset(0, 1.h), //
              ),
            ],
            border: isDark ? Border.all(color: Colors.white10, width: 1) : null,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              // 1. Image with Parallax Effect
              _buildParallaxImage(apartment),

              // 2. Gradient Overlay
              _buildGradientOverlay(isDark),

              // 3. Content and Texts
              _buildCardContent(context, apartment),

              // 4. Favorite Button
              _buildFavoriteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxImage(ApartmentTest apartment) {
    return Transform.scale(
      scale: 1.1,
      child: Transform.translate(
        offset: Offset(0, _dy * 5.h), // Resize parallax shift
        child: Image.network(
          apartment.images.isNotEmpty ? apartment.images[0].url : '',
          fit: BoxFit.cover,
          height: 25.h, // Resize image height
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 25.h,
            color: Colors.grey[800],
            child: Icon(Icons.broken_image, color: Colors.white24, size: 4.h),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay(bool isDark) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.5, 1.0],
            colors: [
              Colors.transparent,
              isDark
                  ? Colors.black.withOpacity(0.9)
                  : Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, ApartmentTest apartment) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(4.w), // Resize padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              apartment.title.tr, // Translation added
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 14.sp, // Resize font
                fontWeight: FontWeight.bold,
                shadows: [const Shadow(blurRadius: 10, color: Colors.black45)],
              ),
            ),
            SizedBox(height: 0.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white70, size: 1.8.h),
                    SizedBox(width: 1.w),
                    Text(
                      apartment.address.city.tr, // Translation added
                      style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                    ),
                  ],
                ),
                PriceTag(amount: double.tryParse(apartment.price) ?? 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 1.5.h,
      right: 3.w,
      child: CircleAvatar(
        radius: 2.2.h, // Resize avatar
        backgroundColor: Colors.black26,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.favorite_border, color: Colors.white, size: 2.5.h),
          onPressed: () {},
        ),
      ),
    );
  }
}
