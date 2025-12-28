import 'package:flutter/material.dart';

class AmenitiesSection extends StatelessWidget {
  final List<String> amenities;
  const AmenitiesSection({super.key, required this.amenities});

  Widget _buildChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: amenities.map(_buildChip).toList());
  }
}
