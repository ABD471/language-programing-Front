import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/features/tenant/home/controller/homeController.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/parallaxApartmentCard.dart';

class ApartmentListWithShimmerTest extends StatelessWidget {
  final HomeTestController controller;
  final void Function(ApartmentTest)? onTap;

  const ApartmentListWithShimmerTest({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.isLoading.value) return _buildShimmerList(isDark);

      if (controller.filtered.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: _buildEmptyState(isDark),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final apt = controller.filtered[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ParallaxApartmentCardTest(
              apartment: apt,
              onTap: () => onTap?.call(apt),
            ),
          );
        }, childCount: controller.filtered.length),
      );
    });
  }

  Widget _buildShimmerList(bool isDark) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        childCount: 5,
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: isDark ? Colors.grey[700] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'no_results_found'.tr,
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.grey[500] : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
