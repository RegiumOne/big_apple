import 'package:big_apple/presentation/overlays/hud/widgets/level_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/circle_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class BackgroundCenterWidget extends StatelessWidget {
  const BackgroundCenterWidget({
    super.key,
    this.level,
    required this.title,
    this.onClose,
    required this.child,
    this.firstBackgroundColor = AppColors.colorBronze,
    this.secondBackgroundColor = AppColors.colorAlabaster,
    this.dottedBorderColor = AppColors.colorBronze,
  });

  final int? level;
  final String title;
  final void Function()? onClose;
  final Widget child;
  final Color firstBackgroundColor;
  final Color secondBackgroundColor;
  final Color dottedBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 320,
            maxWidth: 482,
          ),
          padding: const EdgeInsets.only(
            top: AppDimension.s12,
            bottom: AppDimension.s14,
            left: AppDimension.s16,
            right: AppDimension.s16,
          ),
          decoration: BoxDecoration(
            color: firstBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r30)),
            boxShadow: const [AppColors.shadowSoftBlack],
          ),
          child: Container(
            padding: const EdgeInsets.all(AppDimension.s6),
            decoration: BoxDecoration(
              color: secondBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r20)),
              boxShadow: const [AppColors.shadowSoftBlack],
            ),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: dottedBorderColor,
              padding: EdgeInsets.zero,
              dashPattern: const [5, 5],
              radius: const Radius.circular(AppDimension.r16),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimension.s26,
                  bottom: AppDimension.s16,
                  left: AppDimension.s14,
                  right: AppDimension.s14,
                ),
                child: child,
              ),
            ),
          ),
        ),
        if (onClose != null)
          Positioned(
            top: -10,
            right: -10,
            child: CircleButtonWidget(
              iconSvg: Assets.icons.close,
              onTap: () {
                onClose?.call();
              },
            ),
          ),
        Positioned(
          top: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: AppDimension.s44,
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 166),
              decoration: const BoxDecoration(
                gradient: AppColors.sunriseGlowGradient,
                borderRadius: BorderRadius.all(Radius.circular(AppDimension.r20)),
                boxShadow: [AppColors.shadowElevatedSoft],
              ),
              child: TextWidget(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  shadows: [AppColors.shadowCrispEdge],
                ),
              ),
            ),
          ),
        ),
        if (level != null)
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Center(
              child: LevelIconWidget(level: level!),
            ),
          ),
      ],
    );
  }
}
