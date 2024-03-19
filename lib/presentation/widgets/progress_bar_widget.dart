import 'dart:ui';

import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.maxValue,
    required this.currentValue,
    this.gradient = AppColors.greenGradientTopBottom,
    this.alignment = Alignment.centerLeft,
  });

  final double maxValue;
  final double currentValue;
  final Alignment alignment;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final double fillPercentage = maxValue != 0
        ? maxValue < currentValue
            ? 1
            : currentValue / maxValue
        : 0;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blackGlass,
        borderRadius: BorderRadius.circular(AppDimension.r20),
        border: Border.all(
          color: AppColors.colorSemiTransparentCharcoal,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: _BlurredWidget(
        child: Container(
          alignment: alignment,
          child: FractionallySizedBox(
            widthFactor: fillPercentage,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppDimension.r20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BlurredWidget extends StatelessWidget {
  const _BlurredWidget({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimension.r30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: child,
      ),
    );
  }
}
