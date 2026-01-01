import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CustomChoiceChip extends StatefulWidget {
  final String label;
  final bool selected;
  const CustomChoiceChip({
    super.key,
    required this.label,
    this.selected = false,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    if (widget.selected) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(CustomChoiceChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      widget.selected ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;

        final backgroundColor = Color.lerp(
          isDark ? Colors.grey[900] : theme.colorScheme.surface,
          theme.colorScheme.primary.withOpacity(isDark ? 0.3 : 0.15),
          t,
        )!;

        final textColor = Color.lerp(
          isDark ? Colors.grey[400] : Colors.black87,
          theme.colorScheme.primary,
          t,
        );

        return Transform.scale(
          scale: 1.0 + (t * 0.05),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              border: Border.all(
                color: Color.lerp(
                  isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                  theme.colorScheme.primary.withOpacity(0.5),
                  t,
                )!,
                width: 1.2,
              ),
              boxShadow: t > 0 && !isDark
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 0.5.h),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              widget.label.tr,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: textColor,
                fontWeight: t > 0.5 ? FontWeight.bold : FontWeight.w500,
                fontSize: 11.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
