import 'package:flutter/material.dart';

class AnimatedAuthCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset beginOffset;
  final double opacity;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const AnimatedAuthCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.beginOffset = const Offset(0, 0.2),
    this.opacity = 0.5,
    this.elevation = 10,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
    this.color,
  });

  @override
  State<AnimatedAuthCard> createState() => _AnimatedAuthCardState();
}

class _AnimatedAuthCardState extends State<AnimatedAuthCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          elevation: widget.elevation,
          color: (widget.color ?? Colors.white).withOpacity(widget.opacity),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
