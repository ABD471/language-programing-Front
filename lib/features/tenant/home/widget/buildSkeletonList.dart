import 'package:flutter/material.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/skeletonCard.dart';

Widget buildSkeletonList() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SkeletonCard(),
      ),
      childCount: 4,
    ),
  );
}