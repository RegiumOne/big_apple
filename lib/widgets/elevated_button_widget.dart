import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    Key? key,
    this.minWidth = 0.0,
    this.minHeight = 0.0,
    this.maxWidth = double.infinity,
    this.maxHeight = AppDimension.buttonHeight,
    required this.onPressed,
    required this.child,
    this.alignment,
  }) : super(key: key);

  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final VoidCallback? onPressed;
  final Widget child;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
        maxWidth: maxWidth,
        minWidth: minWidth,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
