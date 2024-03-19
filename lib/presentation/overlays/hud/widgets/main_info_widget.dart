import 'package:big_apple/common/utils/screen_size.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/common/utils/formatters.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class MainInfoWidget extends StatelessWidget {
  const MainInfoWidget({
    required this.gameStat,
    super.key,
  });

  final GameStatistic gameStat;

  @override
  Widget build(BuildContext context) =>
      isLargeScreen(context) ? _LandscapeWidget(gameStat: gameStat) : _PortraitWidget(gameStat: gameStat);
}

class _LandscapeWidget extends StatelessWidget {
  const _LandscapeWidget({
    required this.gameStat,
  });

  final GameStatistic gameStat;

  @override
  Widget build(BuildContext context) {
    return _BackgroundWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppDimension.s128,
            child: ResourceWidget(
              icon: Assets.icons.clover,
              value: '${gameStat.clover}',
            ),
          ),
          const SizedBox(width: AppDimension.s14),
          SizedBox(
            width: AppDimension.s82,
            child: ResourceWidget(
              icon: Assets.icons.energy,
              value: '${gameStat.electricity}',
              iconHeight: AppDimension.s32,
              iconWidth: AppDimension.s34,
              iconTopPadding: 0,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s36,
            ),
          ),
          const SizedBox(width: AppDimension.s14),
          SizedBox(
            width: AppDimension.s96,
            child: ResourceWidget(
              icon: Assets.icons.worker,
              value: '${gameStat.builders}/${gameStat.maxBuilders}',
              iconHeight: AppDimension.s32,
              iconWidth: AppDimension.s28,
              iconLeftPadding: AppDimension.s12,
              iconTopPadding: AppDimension.s2,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s28,
            ),
          ),
          const SizedBox(width: AppDimension.s14),
          SizedBox(
            width: AppDimension.s82,
            child: ResourceWidget(
              icon: Assets.icons.population,
              value: formatNumber(gameStat.peoples),
              iconHeight: AppDimension.s36,
              iconWidth: AppDimension.s30,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s42,
            ),
          ),
        ],
      ),
    );
  }
}

class _PortraitWidget extends StatelessWidget {
  const _PortraitWidget({
    required this.gameStat,
  });

  final GameStatistic gameStat;

  @override
  Widget build(BuildContext context) {
    return _BackgroundWidget(
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: ResourceWidget(
              icon: Assets.icons.clover,
              value: '${gameStat.clover}',
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 6,
            child: ResourceWidget(
              icon: Assets.icons.energy,
              value: '${gameStat.electricity}',
              iconHeight: AppDimension.s32,
              iconWidth: AppDimension.s34,
              iconTopPadding: 0,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s36,
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 5,
            child: ResourceWidget(
              icon: Assets.icons.worker,
              value: '${gameStat.builders}/${gameStat.maxBuilders}',
              iconHeight: AppDimension.s32,
              iconWidth: AppDimension.s28,
              iconLeftPadding: AppDimension.s12,
              iconTopPadding: AppDimension.s2,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s28,
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 6,
            child: ResourceWidget(
              icon: Assets.icons.population,
              value: formatNumber(gameStat.peoples),
              iconHeight: AppDimension.s36,
              iconWidth: AppDimension.s30,
              iconBottomPadding: 0,
              textLeftPadding: AppDimension.s42,
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceWidget extends StatelessWidget {
  const ResourceWidget({
    super.key,
    required this.icon,
    required this.value,
    this.width = double.infinity,
    this.iconWidth = AppDimension.s46,
    this.iconHeight = AppDimension.s34,
    this.textLeftPadding = AppDimension.s46,
    this.iconLeftPadding = AppDimension.s14,
    this.iconTopPadding = AppDimension.s2,
    this.iconBottomPadding = AppDimension.s2,
    this.onAdd,
  });

  final SvgGenImage icon;
  final double width;
  final double iconWidth;
  final double iconHeight;
  final double textLeftPadding;
  final double iconLeftPadding;
  final double iconTopPadding;
  final double iconBottomPadding;
  final String value;
  final void Function()? onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: AppDimension.s30,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: iconLeftPadding,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: AppDimension.s30,
                      decoration: BoxDecoration(
                        color: AppColors.colorCopperBrown,
                        border: Border.all(
                          color: AppColors.colorTaupeGray,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(AppDimension.r10),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -iconTopPadding,
                    bottom: -iconBottomPadding,
                    child: icon.svg(
                      width: iconWidth,
                      height: iconHeight,
                    ),
                  ),
                  Positioned(
                    left: textLeftPadding,
                    top: 0,
                    bottom: 0,
                    right: 6,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          value,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            shadows: [AppColors.shadowSubtleElegance],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (onAdd != null)
            ButtonWidget.flat(
              width: AppDimension.s32,
              height: AppDimension.s32,
              iconSvg: Assets.icons.plus,
              shadowOffset: const Offset(1, 1),
              iconShadowColor: AppColors.colorBlackWithMediumTransparency,
              onPressed: () => onAdd?.call(),
            ),
        ],
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 482),
      decoration: const BoxDecoration(
        color: AppColors.colorBronze,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimension.r30),
          bottomRight: Radius.circular(AppDimension.r30),
        ),
        boxShadow: [AppColors.shadowSoftBlack],
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: AppDimension.s12,
              left: AppDimension.s10,
              right: AppDimension.s10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.s12,
              vertical: AppDimension.s10,
            ),
            decoration: const BoxDecoration(
              color: AppColors.colorAlabaster,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimension.r20),
                bottomRight: Radius.circular(AppDimension.r20),
              ),
              boxShadow: [AppColors.shadowSoftBlack],
            ),
            child: child,
          ),
          Positioned(
            top: -30,
            bottom: 16,
            right: 16,
            left: 16,
            child: IgnorePointer(
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: AppColors.colorBronze,
                padding: EdgeInsets.zero,
                dashPattern: const [5, 5],
                radius: const Radius.circular(AppDimension.r16),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
