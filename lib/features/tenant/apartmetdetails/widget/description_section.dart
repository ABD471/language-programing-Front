import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  final String description;
  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    // الحصول على بيانات الثيم الحالية
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوصف',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,

            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ReadMoreText(
          description,
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' عرض المزيد',
          trimExpandedText: ' عرض أقل',

          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            height: 1.6,

            color: isDark ? Colors.grey[300] : Colors.black87,
          ),

          moreStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          lessStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
