import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int totalReviews;

  const RatingStars({super.key, required this.rating, this.totalReviews = 0});

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // النجوم
        Row(
          children: List.generate(5, (i) {
            IconData iconData;
            if (i < full) {
              iconData = Icons.star_rounded;
            } else if (i == full && half) {
              iconData = Icons.star_half_rounded;
            } else {
              iconData = Icons.star_outline_rounded;
            }

            return Icon(iconData, color: Colors.amber[600], size: 18);
          }),
        ),
        const SizedBox(width: 8),

        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        if (totalReviews > 0) ...[
          const SizedBox(width: 4),
          Text(
            '($totalReviews+)',
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
