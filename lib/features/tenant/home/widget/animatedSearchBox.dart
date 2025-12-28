import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

class AnimatedSearchBox extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const AnimatedSearchBox({super.key, this.onChanged});

  @override
  State<AnimatedSearchBox> createState() => _AnimatedSearchBoxState();
}

class _AnimatedSearchBoxState extends State<AnimatedSearchBox>
    with SingleTickerProviderStateMixin {
  late final FocusNode _focusNode;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus)
        _controller.forward();
      else
        _controller.reverse();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 0.02);
        return Transform.scale(scale: scale, child: child);
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        child: TextField(
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: 'ابحث عن مدينة، منطقة أو ميزة...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => FocusScope.of(context).unfocus(),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
