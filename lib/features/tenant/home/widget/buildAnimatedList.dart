import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/openDetails.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/parallaxApartmentCard.dart';
import 'package:flutter/material.dart';

Widget buildAnimatedList({
  required List<Apartment> filtered,
  required AnimationController animationController,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      final apt = filtered[index];
      final start = (index / (filtered.length + 1)).clamp(0.0, 1.0);
      final interval = Interval(start, 1.0, curve: Curves.easeOut);
      final anim = CurvedAnimation(
        parent: animationController,
        curve: interval,
      );

      return AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return Opacity(
            opacity: anim.value,
            child: Transform.translate(
              offset: Offset(0, (1 - anim.value) * 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: ParallaxApartmentCard(
                  apartment: apt,
                  onTap: () => openDetails(context, apt),
                ),
              ),
            ),
          );
        },
      );
    }, childCount: filtered.length),
  );
}
