import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      _focusNode.hasFocus ? _controller.forward() : _controller.reverse();
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_controller.value * 0.015),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: _focusNode.hasFocus
                      ? theme.primaryColor.withOpacity(isDark ? 0.15 : 0.1)
                      : Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                  blurRadius: _focusNode.hasFocus ? 15 : 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'search_hint_detailed'.tr,
          hintStyle: TextStyle(
            color: theme.hintColor.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: _focusNode.hasFocus ? theme.primaryColor : theme.hintColor,
          ),
          suffixIcon: _focusNode.hasFocus
              ? IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => _focusNode.unfocus(),
                )
              : null,
          filled: true,
          fillColor: isDark
              ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.5)
              : theme.colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          enabledBorder: _buildBorder(
            isDark ? Colors.white10 : Colors.grey.shade200,
          ),
          focusedBorder: _buildBorder(
            theme.primaryColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
