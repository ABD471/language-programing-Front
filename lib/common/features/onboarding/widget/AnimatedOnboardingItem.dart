import 'package:flutter/material.dart';

class AnimatedOnboardingItem extends StatefulWidget {
  final String image;
  final String title;
  final String description;

  const AnimatedOnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  State<AnimatedOnboardingItem> createState() => _AnimatedOnboardingItemState();
}

class _AnimatedOnboardingItemState extends State<AnimatedOnboardingItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---------------- Image ----------------
            Image.asset(widget.image, height: 260, fit: BoxFit.contain),

            const SizedBox(height: 40),

            // ---------------- Title ----------------
            Text(
              widget.title,
              style: theme.textTheme.headlineLarge?.copyWith(
                color: colors.primary,
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 14),

            // ---------------- Description ----------------
            Text(
              widget.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.primary.withOpacity(0.85),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
