import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  final String description;
  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ReadMoreText(
          description,
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' عرض المزيد',
          trimExpandedText: ' عرض أقل',
          style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
          moreStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
