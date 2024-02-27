import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class IconWithShadowWidget extends StatelessWidget {
  const IconWithShadowWidget({
    super.key,
    this.size = AppDimension.s30,
    this.iconColor = Colors.white,
    this.shadowColor = AppColors.colorWineRed,
    this.iconData,
    this.iconSvg,
  });

  final double size;
  final Color iconColor;
  final Color shadowColor;
  final IconData? iconData;
  final SvgGenImage? iconSvg;

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? Icon(
            iconData,
            color: iconColor,
            size: size,
            shadows: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(2, 1),
              ),
            ],
          )
        : Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 2,
                top: 1,
                child: iconSvg!.svg(
                  width: size,
                  height: size,
                  colorFilter: ColorFilter.mode(shadowColor, BlendMode.srcIn),
                ),
              ),
              iconSvg!.svg(
                width: size,
                height: size,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ],
          );
  }
}
