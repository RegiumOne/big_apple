import 'package:big_apple/presentation/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/icon_with_shadow_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.currentLvlValue,
    required this.level,
  });

  final double currentLvlValue;
  final int level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 6,
            left: 26,
            right: 0,
            bottom: 6,
            child: ProgressBarWidget(maxValue: 1, currentValue: currentLvlValue),
          ),
          Positioned(
            right: -14,
            bottom: -6,
            child: _LabelWidget(level: level),
          ),
          const _IconWidget(),
        ],
      ),
    );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimension.s10, vertical: AppDimension.s4),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradientLeftRight,
        borderRadius: BorderRadius.circular(AppDimension.r100),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$level',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                height: 1,
              ),
            ),
            TextSpan(
              text: ' lvl',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimension.s42,
      width: AppDimension.s42,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: AppDimension.s2),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradientTopBottom,
        borderRadius: BorderRadius.circular(AppDimension.r10),
      ),
      child: IconWithShadowWidget(
        iconSvg: Assets.icons.lvl,
        iconHeight: AppDimension.s28,
        iconWidth: AppDimension.s32,
        iconColor: null,
        shadowOffset: const Offset(2, 2),
        shadowColor: AppColors.colorLightSemiTransparentBlack,
      ),
    );
  }
}
