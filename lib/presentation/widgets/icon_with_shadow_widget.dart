import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class IconWithShadowWidget extends StatelessWidget {
  const IconWithShadowWidget({
    super.key,
    this.iconSize = AppDimension.s30,
    this.iconColor = Colors.white,
    this.shadowColor = AppColors.colorWineRed,
    this.shadowOffset = const Offset(2, 1),
    this.iconData,
    this.iconSvg,
  });

  final double iconSize;
  final Color iconColor;
  final Color shadowColor;
  final IconData? iconData;
  final SvgGenImage? iconSvg;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? Icon(
            iconData,
            color: iconColor,
            size: iconSize,
            shadows: [
              BoxShadow(
                color: shadowColor,
                offset: shadowOffset,
              ),
            ],
          )
        : Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: shadowOffset.dx,
                top: shadowOffset.dy,
                child: iconSvg!.svg(
                  width: iconSize,
                  height: iconSize,
                  colorFilter: ColorFilter.mode(shadowColor, BlendMode.srcIn),
                ),
              ),
              iconSvg!.svg(
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ],
          );
  }
}
