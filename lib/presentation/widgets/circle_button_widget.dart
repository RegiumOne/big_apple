import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/icon_with_shadow_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    super.key,
    required this.onTap,
    required this.iconSvg,
  });

  final void Function() onTap;
  final SvgGenImage iconSvg;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(AppDimension.r100));

    return Container(
      height: AppDimension.s44,
      width: AppDimension.s44,
      decoration: const BoxDecoration(
        gradient: AppColors.sunsetPassionGradient,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Center(
            child: IconWithShadowWidget(
              iconSvg: iconSvg,
              iconWidth: AppDimension.s16,
              shadowOffset: const Offset(2, 2),
              shadowColor: AppColors.colorLightSemiTransparentBlack,
            ),
          ),
        ),
      ),
    );
  }
}
