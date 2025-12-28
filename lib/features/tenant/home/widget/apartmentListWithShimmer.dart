import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'parallaxApartmentCard.dart'; // بطاقة الشقة الحقيقية
import '../controller/homeController.dart';
import 'package:get/get.dart';

class ApartmentListWithShimmer extends StatelessWidget {
  final HomeController controller;
  final void Function(Apartment)? onTap;
  const ApartmentListWithShimmer({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filtered = controller.filtered;

      // أثناء التحميل: عرض shimmer
      if (controller.isLoading.value) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              );
            },
            childCount: 4, // عدد بطاقات shimmer أثناء التحميل
          ),
        );
      }

      // بعد التحميل: عرض البطاقات الحقيقية
      if (filtered.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              'لا توجد نتائج',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final apt = filtered[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ParallaxApartmentCard(
              apartment: apt,
              onTap: () {
                onTap!(apt);
              },
            ),
          );
        }, childCount: filtered.length),
      );
    });
  }
}
