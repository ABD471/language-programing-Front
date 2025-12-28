import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

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
  late bool _selected;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    if (_selected) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
          if (_selected)
            _controller.forward();
          else
            _controller.reverse();
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          final color = Color.lerp(
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.primary.withOpacity(.22),
            t,
          )!;
          final scale = 1.0 + (t * 0.04);
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                boxShadow: t > 0
                    ? [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: t > 0.4
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
