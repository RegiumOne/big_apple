import 'package:big_apple/presentation/widgets/progress_bar_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/icon_with_shadow_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.maxLvlValue,
    required this.currentLvlValue,
    required this.level,
  });

  final double maxLvlValue;
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
            top: 0,
            left: 23,
            right: 0,
            bottom: 0,
            child: Center(
              child: SizedBox(
                height: AppDimension.s30,
                child: ProgressBarWidget(maxValue: maxLvlValue, currentValue: currentLvlValue),
              ),
            ),
          ),
          LevelIconWidget(level: level),
        ],
      ),
    );
  }
}

class LevelIconWidget extends StatelessWidget {
  const LevelIconWidget({
    super.key,
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconWithShadowWidget(
          iconSvg: Assets.icons.level,
          iconHeight: AppDimension.s52,
          iconWidth: AppDimension.s52,
          iconColor: null,
          shadowOffset: const Offset(2, 2),
          shadowColor: AppColors.colorMediumTransparencyBlack,
        ),
        Positioned.fill(
          child: Center(
            child: TextWidget(
              level.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                shadows: [
                  const Shadow(
                    color: AppColors.colorMediumTransparencyBlack,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
