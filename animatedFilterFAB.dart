import 'package:flutter/material.dart';

class AnimatedFilterFAB extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback? onTap;
  const AnimatedFilterFAB({super.key, required this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
