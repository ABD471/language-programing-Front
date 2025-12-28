import 'package:apartment_rental_system/features/tenant/home/widget/skeletonCard.dart';
import 'package:flutter/material.dart';

Widget buildSkeletonList() {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SkeletonCard(),
      );
    }, childCount: 4),
  );
}
