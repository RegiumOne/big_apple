import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flutter/material.dart';

class BuildingButton extends StatefulWidget {
  const BuildingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final String text;

  @override
  State<BuildingButton> createState() => _BuildingButtonState();
}

class _BuildingButtonState extends State<BuildingButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadiusResult = BorderRadius.circular(AppDimension.r10);
    final double bottomPadding = _isPressed ? 0 : AppDimension.s4;
    final double topPadding = _isPressed ? AppDimension.s4 : 0;
    return SizedBox(
      width: AppDimension.s64,
      height: AppDimension.s64,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            duration: AppDuration.defaultAnimationDuration,
            bottom: 0,
            right: 0,
            left: 0,
            top: topPadding,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: const Border(
                  left: BorderSide(
                    color: AppColors.colorMediumTransparencyBlack,
                    width: AppDimension.s2,
                  ),
                  right: BorderSide(
                    color: AppColors.colorMediumTransparencyBlack,
                    width: AppDimension.s2,
                  ),
                  top: BorderSide(
                    color: AppColors.colorMediumTransparencyBlack,
                    width: AppDimension.s2,
                  ),
                  bottom: BorderSide(
                    color: AppColors.colorMediumTransparencyBlack,
                    width: AppDimension.s6,
                  ),
                ),
                color: AppColors.colorMediumTransparencyBlack,
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
              margin: const EdgeInsets.all(2),
              duration: AppDuration.defaultAnimationDuration,
              decoration: BoxDecoration(
                // gradient: _isPressed ? AppColors.redGradient : AppColors.redGradient,
                // color: _isPressed ? AppColors.colorMediumTransparencyBlack : AppColors.colorMediumTransparencyBlack,
                borderRadius: BorderRadius.circular(AppDimension.r8),
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
                    setState(() => _isPressed = false);
                  },
                  onTapCancel: () {
                    setState(() => _isPressed = false);
                  },
                  borderRadius: borderRadiusResult,
                  onTap: widget.onPressed,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.icon,
                        const SizedBox(height: AppDimension.s4),
                        TextWidget(
                          widget.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.2,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
