import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/icon_with_shadow_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class EcologyLevelWidget extends StatelessWidget {
  const EcologyLevelWidget({
    super.key,
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimension.s40,
      constraints: const BoxConstraints(
        maxWidth: AppDimension.s104,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.s14,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.greenGradientTopBottom,
        borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
      ),
      child: Row(
        children: [
          IconWithShadowWidget(
            iconSvg: Assets.icons.ecologyLevel,
            iconHeight: AppDimension.s24,
            iconWidth: AppDimension.s30,
            iconColor: null,
            shadowOffset: const Offset(2, 2),
            shadowColor: AppColors.colorLightSemiTransparentBlack,
          ),
          const SizedBox(width: AppDimension.s6),
          TextWidget(
            '$level%',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              shadows: [
                const BoxShadow(
                  color: AppColors.colorMediumTransparencyBlack,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
