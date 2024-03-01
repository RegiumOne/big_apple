import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.maxValue,
    required this.currentValue,
    this.gradient = AppColors.greenGradient,
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
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorBronze,
          borderRadius: BorderRadius.circular(AppDimension.r30),
          boxShadow: const [AppColors.shadowSoftBlack],
        ),
        padding: const EdgeInsets.symmetric(vertical: AppDimension.s2, horizontal: AppDimension.s2),
        child: Container(
          alignment: alignment,
          decoration: BoxDecoration(
            gradient: AppColors.espressoSunriseGradient,
            borderRadius: BorderRadius.circular(AppDimension.r20),
            boxShadow: const [AppColors.shadowSoftBlack],
          ),
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
