import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
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
    this.gradient = AppColors.redGradientTopBottom,
    this.gradientPress = AppColors.darkRedGradient,
    this.shadowColor = AppColors.colorWineRed,
    this.borderRadius = AppDimension.r6,
    required this.onPressed,
    this.color,
    this.colorPress,
    this.iconSvg,
    this.text,
    this.gap = AppDimension.s4,
    this.shadowOffsetBottom = AppDimension.s4,
    this.builder,
    this.iconPadding,
    this.childShadowOffset = const Offset(2, 1),
    this.childShadowColor = AppColors.colorWineRed,
  });

  factory ButtonWidget.oneStatus({
    double width = AppDimension.s66,
    double height = AppDimension.s64,
    double iconSize = AppDimension.s30,
    Gradient? gradient = AppColors.redGradientTopBottom,
    Color? shadowColor = AppColors.colorWineRed,
    double borderRadius = AppDimension.r6,
    required void Function()? onPressed,
    Color? color,
    Color? colorPress,
    SvgGenImage? iconSvg,
    String? text,
    Widget Function(bool isPressed)? builder,
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
        colorPress: colorPress,
        iconSvg: iconSvg,
        text: text,
        builder: builder,
      );

  factory ButtonWidget.withColor({
    double width = AppDimension.s66,
    double height = AppDimension.s64,
    double iconSize = AppDimension.s30,
    Color? shadowColor = AppColors.colorWineRed,
    double borderRadius = AppDimension.r6,
    required void Function()? onPressed,
    Color? color,
    Color? colorPress,
    SvgGenImage? iconSvg,
    String? text,
    Widget Function(bool isPressed)? builder,
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
        colorPress: colorPress,
        iconSvg: iconSvg,
        text: text,
        builder: builder,
      );

  factory ButtonWidget.iconWithTextRow({
    double width = double.infinity,
    double height = AppDimension.s40,
    Gradient? gradient = AppColors.autumnBlazeGradient,
    Color? color,
    Color? shadowColor = AppColors.colorRust,
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
        builder: (_) => Padding(
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
    Gradient? gradient = AppColors.blueGradientTopBottom,
    Color? color,
    Color? shadowColor = AppColors.colorRoyalBlue,
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
        builder: (_) => iconSvg.svg(
          width: iconWidth,
          height: iconHeight,
        ),
      );

  factory ButtonWidget.withText({
    double width = double.infinity,
    double height = AppDimension.s38,
    Color color = AppColors.colorAlmondMilk,
    Color? colorPressBackground,
    Color? colorPressText,
    Color? shadowColor = AppColors.colorLightSemiTransparentBlack,
    required void Function()? onPressed,
    required String text,
    required TextStyle? style,
  }) =>
      ButtonWidget.withColor(
        width: width,
        height: height,
        color: onPressed == null ? AppColors.colorSilver : color,
        colorPress: colorPressBackground,
        shadowColor: onPressed == null ? null : shadowColor,
        onPressed: onPressed,
        text: text,
        builder: (isPressed) => Text(
          text,
          style: style?.copyWith(
            color: onPressed == null
                ? AppColors.colorDoveGray
                : isPressed
                    ? colorPressText ?? style.color
                    : style.color,
          ),
        ),
      );

  factory ButtonWidget.flat({
    double width = AppDimension.s30,
    double height = AppDimension.s30,
    double borderRadius = AppDimension.r8,
    double iconSize = AppDimension.s10,
    Offset shadowOffset = const Offset(2, 1),
    Color iconShadowColor = AppColors.colorWineRed,
    Color? color,
    Color? colorPress,
    Gradient? gradient = AppColors.greenGradientTopBottom,
    required void Function() onPressed,
    required SvgGenImage? iconSvg,
  }) =>
      ButtonWidget(
        width: width,
        height: height,
        color: color,
        colorPress: colorPress,
        gradient: gradient,
        shadowColor: null,
        borderRadius: borderRadius,
        iconSize: iconSize,
        childShadowColor: iconShadowColor,
        onPressed: onPressed,
        iconSvg: iconSvg,
        childShadowOffset: shadowOffset,
      );

  final void Function()? onPressed;
  final double borderRadius;
  final double iconSize;
  final Color? shadowColor;
  final Color childShadowColor;
  final Gradient? gradient;
  final Gradient? gradientPress;
  final Color? color;
  final Color? colorPress;
  final double width;
  final double height;
  final SvgGenImage? iconSvg;
  final String? text;
  final Widget Function(bool isPressed)? builder;
  final double gap;
  final EdgeInsets? iconPadding;
  final Offset childShadowOffset;
  final double shadowOffsetBottom;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadiusResult = BorderRadius.all(Radius.circular(widget.borderRadius));
    final double bottomPadding = widget.shadowColor != null
        ? _isPressed
            ? 0
            : widget.shadowOffsetBottom
        : 0;
    final double topPadding = widget.shadowColor != null
        ? _isPressed
            ? widget.shadowOffsetBottom
            : 0
        : 0;
    return IgnorePointer(
      ignoring: widget.onPressed == null,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (widget.shadowColor != null)
              AnimatedPositioned(
                duration: AppDuration.defaultAnimationDuration,
                bottom: 0,
                right: 0,
                left: 0,
                top: topPadding,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.shadowColor,
                    borderRadius: borderRadiusResult,
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: AppDuration.defaultAnimationDuration,
              bottom: bottomPadding,
              left: 0,
              right: 0,
              top: topPadding,
              child: AnimatedContainer(
                duration: AppDuration.defaultAnimationDuration,
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
                      AudioService.instance.playSound(AudioFile.mouseClick);
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
                      child: widget.builder?.call(_isPressed) ??
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.iconSvg != null)
                                Padding(
                                  padding: widget.iconPadding ?? EdgeInsets.zero,
                                  child: IconWithShadowWidget(
                                    iconSvg: widget.iconSvg!,
                                    iconWidth: widget.iconSize,
                                    shadowOffset: widget.childShadowOffset,
                                    shadowColor: widget.childShadowColor,
                                  ),
                                ),
                              if (widget.iconSvg != null && widget.text != null) SizedBox(height: widget.gap),
                              if (widget.text != null)
                                TextWidget(
                                  widget.text!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.2,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        color: widget.childShadowColor,
                                        offset: const Offset(2, 2),
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
        ),
      ),
    );
  }
}
