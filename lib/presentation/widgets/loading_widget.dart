import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size,
    this.progressColor,
  });

  final double? size;
  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: RepaintBoundary(
        child: CircularProgressIndicator(
          color: progressColor ?? Theme.of(context).colorScheme.secondary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
