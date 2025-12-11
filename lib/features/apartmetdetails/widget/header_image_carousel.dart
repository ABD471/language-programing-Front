import 'package:apartment_rental_system/features/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/full_screen_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderImageCarousel extends StatelessWidget {
  final ApartmentDetailsController controller;
  const HeaderImageCarousel({super.key, required this.controller});

  void _openGallery(BuildContext context, int initial) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageGallery(
          images: controller.images,
          initialIndex: initial,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final images = controller.images;
      return SizedBox(
        height: 360,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (ctx, idx, realIdx) {
                final url = images[idx];
                return GestureDetector(
                  onTap: () => _openGallery(context, idx),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, __) => Container(color: Colors.grey[300]),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, size: 48),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                height: 360,
                autoPlay: true,
                onPageChanged: (i, r) =>
                    controller.currentCarouselIndex.value = i,
              ),
            ),
            // Overlay & controls
            Positioned(
              left: 12,
              top: 24,
              child: SafeArea(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(
                  () => Text(
                    '${controller.currentCarouselIndex.value + 1}/${controller.images.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
