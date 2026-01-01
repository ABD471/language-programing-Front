import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
        offset: _visible ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.image, 
              height: 35.h, 
              fit: BoxFit.contain
            ),

            SizedBox(height: 5.h),

            Text(
              widget.title.tr,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontSize: 22.sp,
                color: colors.primary,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                widget.description.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                  color: colors.primary.withOpacity(0.85),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}