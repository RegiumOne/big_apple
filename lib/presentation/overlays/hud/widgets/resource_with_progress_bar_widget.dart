import 'package:big_apple/presentation/widgets/progress_bar_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class ResourceWithProgressBarWidget extends StatelessWidget {
  const ResourceWithProgressBarWidget({
    super.key,
    required this.maxValue,
    required this.value,
    required this.icon,
  });

  final double maxValue;
  final double value;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 2,
            left: 0,
            right: 8,
            bottom: 2,
            child: Center(
              child: ProgressBarWidget(
                maxValue: maxValue,
                currentValue: value,
                alignment: Alignment.centerRight,
                gradient: AppColors.greenGradientTopBottom,
              ),
            ),
          ),
          Positioned(
            right: 36,
            bottom: 0,
            top: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextWidget(
                value.toStringAsFixed(0),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  shadows: [AppColors.shadowSubtleElegance],
                ),
              ),
            ),
          ),
          icon.svg(
            width: AppDimension.s32,
            height: AppDimension.s32,
          ),
        ],
      ),
    );
  }
}
