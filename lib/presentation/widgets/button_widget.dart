import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/icon_with_shadow_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.width = AppDimension.s66,
    this.height = AppDimension.s64,
    this.iconSize = AppDimension.s30,
    this.gradient = AppColors.gradientWarmSunset,
    this.gradientPress = AppColors.gradientVelvetWine,
    this.shadowColor = AppColors.colorWineRed,
    this.borderRadius = AppDimension.r6,
    required this.onPressed,
    this.color,
    this.colorPress,
    this.iconSvg,
    this.text,
    this.child,
  });

  factory ButtonWidget.oneStatus({
    double width = AppDimension.s66,
    double height = AppDimension.s64,
    double iconSize = AppDimension.s30,
    Gradient? gradient = AppColors.gradientWarmSunset,
    Color shadowColor = AppColors.colorWineRed,
    double borderRadius = AppDimension.r6,
    required void Function() onPressed,
    Color? color,
    SvgGenImage? iconSvg,
    String? text,
    Widget? child,
  }) =>
      ButtonWidget(
        width: width,
        height: height,
        iconSize: iconSize,
        gradient: gradient,
        gradientPress: gradient,
        shadowColor: shadowColor,
        borderRadius: borderRadius,
        onPressed: onPressed,
        color: color,
        colorPress: color,
        iconSvg: iconSvg,
        text: text,
        child: child,
      );

  factory ButtonWidget.withColor({
    double width = AppDimension.s66,
    double height = AppDimension.s64,
    double iconSize = AppDimension.s30,
    Color shadowColor = AppColors.colorWineRed,
    double borderRadius = AppDimension.r6,
    required void Function() onPressed,
    Color? color,
    SvgGenImage? iconSvg,
    String? text,
    Widget? child,
  }) =>
      ButtonWidget.oneStatus(
        width: width,
        height: height,
        iconSize: iconSize,
        gradient: null,
        shadowColor: shadowColor,
        borderRadius: borderRadius,
        onPressed: onPressed,
        color: color,
        iconSvg: iconSvg,
        text: text,
        child: child,
      );

  factory ButtonWidget.iconWithTextRow({
    double width = double.infinity,
    double height = AppDimension.s40,
    Gradient? gradient = AppColors.gradientAutumnBlaze,
    Color? color,
    Color shadowColor = AppColors.colorRust,
    EdgeInsets? padding = const EdgeInsets.all(AppDimension.s8),
    required void Function() onPressed,
    required SvgGenImage iconSvg,
    required double iconWidth,
    required double iconHeight,
    required double gap,
    required String text,
    required TextStyle? style,
  }) =>
      ButtonWidget.oneStatus(
        width: width,
        height: height,
        gradient: gradient,
        color: color,
        shadowColor: shadowColor,
        onPressed: onPressed,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconSvg.svg(
                width: iconWidth,
                height: iconHeight,
              ),
              SizedBox(width: gap),
              TextWidget(
                text,
                style: style,
              ),
            ],
          ),
        ),
      );

  factory ButtonWidget.icon({
    double width = AppDimension.s30,
    double height = AppDimension.s32,
    Gradient? gradient = AppColors.gradientDeepOceanGlide,
    Color? color,
    Color shadowColor = AppColors.colorRoyalBlue,
    required void Function() onPressed,
    required SvgGenImage iconSvg,
    double iconHeight = AppDimension.s18,
    double iconWidth = AppDimension.s18,
  }) =>
      ButtonWidget.oneStatus(
        width: width,
        height: height,
        gradient: gradient,
        shadowColor: shadowColor,
        onPressed: onPressed,
        color: color,
        iconSvg: iconSvg,
        child: iconSvg.svg(
          width: iconWidth,
          height: iconHeight,
        ),
      );

  factory ButtonWidget.withText({
    double width = double.infinity,
    double height = AppDimension.s38,
    Color color = AppColors.colorAlmondMilk,
    Color shadowColor = AppColors.colorLightSemiTransparentBlack,
    required void Function() onPressed,
    required String text,
    required TextStyle? style,
  }) =>
      ButtonWidget.withColor(
        width: width,
        height: height,
        color: color,
        shadowColor: shadowColor,
        onPressed: onPressed,
        text: text,
        child: Text(
          text,
          style: style,
        ),
      );

  final void Function() onPressed;
  final double borderRadius;
  final double iconSize;
  final Color shadowColor;
  final Gradient? gradient;
  final Gradient? gradientPress;
  final Color? color;
  final Color? colorPress;
  final double width;
  final double height;
  final SvgGenImage? iconSvg;
  final String? text;
  final Widget? child;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadiusResult = BorderRadius.all(Radius.circular(widget.borderRadius));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.shadowColor,
            borderRadius: borderRadiusResult,
          ),
        ),
        AnimatedPositioned(
          duration: AppDuration.defaultAnimationDuration,
          bottom: _isPressed ? 0 : AppDimension.s4,
          left: 0,
          right: 0,
          top: 0,
          child: AnimatedContainer(
            duration: AppDuration.defaultAnimationDuration,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: _isPressed ? widget.gradientPress : widget.gradient,
              color: _isPressed ? widget.colorPress : widget.color,
              borderRadius: borderRadiusResult,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTapDown: (_) {
                  setState(() {
                    _isPressed = true;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _isPressed = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _isPressed = false;
                  });
                },
                borderRadius: borderRadiusResult,
                onTap: widget.onPressed,
                child: Center(
                  child: widget.child ??
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.iconSvg != null)
                            IconWithShadowWidget(iconSvg: widget.iconSvg!, iconSize: widget.iconSize),
                          if (widget.iconSvg != null && widget.text != null) const SizedBox(height: AppDimension.s4),
                          if (widget.text != null)
                            TextWidget(
                              widget.text!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.2,
                                color: Colors.white,
                                shadows: [
                                  const BoxShadow(
                                    color: AppColors.colorWineRed,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
