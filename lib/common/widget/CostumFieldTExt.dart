import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Costumfiledtext extends StatefulWidget {
  final String hintText;
  final String label;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController Mycontroller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;

  const Costumfiledtext({
    super.key,
    required this.hintText,
    required this.Mycontroller,
    required this.validator,
    required this.label,
    required this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
  });

  @override
  State<Costumfiledtext> createState() => _CostumfiledtextState();
}

class _CostumfiledtextState extends State<Costumfiledtext>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 0.0), weight: 1),
    ]).animate(_controller);
  }

  void shake() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value, 0),
          child: TextFormField(
            controller: widget.Mycontroller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,

            
            style: textTheme.bodyLarge?.copyWith(fontSize: 15.sp),

            validator: (value) {
              final result = widget.validator(value);
              if (result != null) shake();
              return result;
            },

            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(23)),
              ),

              labelText: widget.label,
              labelStyle: textTheme.titleMedium?.copyWith(fontSize: 16.sp),
              hintText: widget.hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(fontSize: 14.sp),

            
              prefixIcon: IconTheme(
                data: theme.iconTheme.copyWith(size: 18.sp),
                child: widget.prefixIcon,
              ),

              
              suffixIcon: widget.suffixIcon != null
                  ? IconTheme(
                      data: theme.iconTheme.copyWith(size: 16.sp),
                      child: widget.suffixIcon!,
                    )
                  : null,

             
            ).applyDefaults(theme.inputDecorationTheme),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
