import 'package:flutter/material.dart';

class Costumfiledtext extends StatefulWidget {
  final String hintText;
  final String label;
  final Widget IconData;
  final Widget? hide;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController Mycontroller;
  final String? Function(String?) validator;
  TextInputType? keyboardType;

  Costumfiledtext({
    super.key,
    this.keyboardType,
    required this.hintText,
    required this.Mycontroller,
    required this.validator,
    required this.label,
    required this.IconData,
    required this.obscureText,
    this.hide,
    this.focusNode,
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
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(_controller);
  }

  void shake() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tt = theme.textTheme;

    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value, 0),
          child: TextFormField(
            controller: widget.Mycontroller,
            obscureText: widget.obscureText,
            style: tt.bodyMedium,
            keyboardType: widget.keyboardType,
            validator: (value) {
              final result = widget.validator(value);
              if (result != null) shake(); // يهتز عند الخطأ
              return result;
            },
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hintText,
              prefixIcon: IconTheme(
                data: IconThemeData(color: theme.colorScheme.primary),
                child: widget.IconData,
              ),
              suffixIcon: widget.hide,
              floatingLabelStyle: tt.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              errorStyle: tt.bodySmall?.copyWith(color: Colors.yellow),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.yellow, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.yellow, width: 1.5),
              ),
            ),
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
