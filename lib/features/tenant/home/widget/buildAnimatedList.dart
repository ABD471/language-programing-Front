import 'package:flutter/material.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/openDetails.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/parallaxApartmentCard.dart';

Widget buildAnimatedList({
  required List<ApartmentTest> filtered,
  required AnimationController animationController,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      final apt = filtered[index];

      final double start = (index * 0.1).clamp(0.0, 0.5);
      final double end = (start + 0.4).clamp(0.0, 1.0);

      final anim = CurvedAnimation(
        parent: animationController,
        curve: Interval(start, end, curve: Curves.easeOutQuad),
      );

      return AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return Opacity(
            opacity: anim.value,
            child: Transform.translate(
              offset: Offset(0, (1 - anim.value) * 20),
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ParallaxApartmentCardTest(
            apartment: apt,
            onTap: () => openDetails(context, apt),
          ),
        ),
      );
    }, childCount: filtered.length),
  );
}
