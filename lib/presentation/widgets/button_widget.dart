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
    this.gradient = AppColors.gradientWarmSunset,
    this.gradientPress = AppColors.gradientVelvetWine,
    this.shadowColor = AppColors.colorWineRed,
    this.borderRadius = AppDimension.r6,
    required this.onPressed,
    this.iconSvg,
    this.text,
  });

  final void Function() onPressed;
  final double borderRadius;
  final Color shadowColor;
  final Gradient gradient;
  final Gradient gradientPress;
  final double width;
  final double height;
  final SvgGenImage? iconSvg;
  final String? text;

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
          child: AnimatedContainer(
            duration: AppDuration.defaultAnimationDuration,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: _isPressed ? widget.gradientPress : widget.gradient,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.iconSvg != null) IconWithShadowWidget(iconSvg: widget.iconSvg!),
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
