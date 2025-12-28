import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      children: List.generate(5, (i) {
        if (i < full)
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        if (i == full && half)
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        return const Icon(Icons.star_border, color: Colors.amber, size: 16);
      }),
    );
  }
}
