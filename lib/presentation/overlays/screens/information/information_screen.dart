import 'dart:ui';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/circle_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  void initState() {
    AudioService.instance.playPopupWindowMusic();
    super.initState();
  }

  @override
  void dispose() {
    widget.game.checkMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: _BackgroundWidget(
          title: 'Information',
          onClose: () {
            widget.game.overlays.remove(Overlays.information.name);
            widget.game.overlays.add(Overlays.hud.name);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _FirstColumnWidget(theme: theme)),
              const SizedBox(width: AppDimension.s8),
              Expanded(child: _SecondColumnWidget(theme: theme)),
              const SizedBox(width: AppDimension.s16),
              Expanded(child: _ThirdColumnWidget(theme: theme)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstColumnWidget extends StatelessWidget {
  const _FirstColumnWidget({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorPaleSilver,
            borderRadius: BorderRadius.circular(AppDimension.r10),
          ),
          padding: const EdgeInsets.only(
            left: AppDimension.s14,
            right: AppDimension.s14,
            top: AppDimension.s10,
            bottom: AppDimension.s14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Game rules',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.colorBronze,
                  height: 1,
                ),
              ),
              const SizedBox(height: AppDimension.s4),
              TextWidget(
                'The main goal of the game is to create a dream city, to maintain a balance between convenience, innovation and environmental friendliness.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.colorTaupe,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimension.s8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorPaleSilver,
            borderRadius: BorderRadius.circular(AppDimension.r10),
          ),
          padding: const EdgeInsets.only(
            left: AppDimension.s14,
            right: AppDimension.s14,
            top: AppDimension.s10,
            bottom: AppDimension.s14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    'Ecology level',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.colorBronze,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: AppDimension.s8),
                  Assets.icons.lvl.svg(
                    width: AppDimension.s24,
                    height: AppDimension.s24,
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.s4),
              TextWidget(
                'The level of environmental friendliness is the main parameter that reflects your success in the game. Unlike the usual level in games - it can even decrease.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.colorTaupe,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondColumnWidget extends StatelessWidget {
  const _SecondColumnWidget({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorPaleSilver,
            borderRadius: BorderRadius.circular(AppDimension.r10),
          ),
          padding: const EdgeInsets.only(
            left: AppDimension.s14,
            right: AppDimension.s14,
            top: AppDimension.s10,
            bottom: AppDimension.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Resources',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.colorBronze,
                  height: 1,
                ),
              ),
              TextWidget(
                'that can be earned and spent',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.colorTaupe,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppDimension.s6),
              Wrap(
                spacing: AppDimension.s10,
                runSpacing: AppDimension.s10,
                children: [
                  ...ResourceType.values.map(
                    (e) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          e.icon(isWhite: false),
                          height: AppDimension.s22,
                          width: AppDimension.s22,
                        ),
                        const SizedBox(width: AppDimension.s4),
                        TextWidget(
                          e.title,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.colorTaupe,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimension.s8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorPaleSilver,
            borderRadius: BorderRadius.circular(AppDimension.r10),
          ),
          padding: const EdgeInsets.only(
            left: AppDimension.s14,
            right: AppDimension.s14,
            top: AppDimension.s10,
            bottom: AppDimension.s14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    'EcoCoins',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.colorBronze,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: AppDimension.s8),
                  Assets.icons.clover.svg(
                    width: AppDimension.s20,
                    height: AppDimension.s20,
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.s6),
              TextWidget(
                'a special resource with which you can buy special houses and or cards',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.colorTaupe,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThirdColumnWidget extends StatelessWidget {
  const _ThirdColumnWidget({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppDimension.s20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Playing',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.colorBronze,
              height: 1,
            ),
          ),
          const SizedBox(height: AppDimension.s6),
          TextWidget(
            'The game is an economic strategy in which the player must build the most ecological city while satisfying all the wishes of the residents as much as possible. To achieve this goal, the player has two types of resources: those that can be used and those that cannot be used.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.colorTaupe,
              height: 1.2,
            ),
          ),
          const Spacer(),
          ButtonWidget.withText(
            onPressed: () {},
            text: 'Play tutorial',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.colorBronze,
              height: 1.18,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({
    required this.title,
    required this.onClose,
    required this.child,
  });

  final String title;
  final void Function() onClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 340,
            maxWidth: 728,
          ),
          padding: const EdgeInsets.only(
            top: AppDimension.s12,
            bottom: AppDimension.s14,
            left: AppDimension.s16,
            right: AppDimension.s16,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorBronze,
            borderRadius: BorderRadius.all(Radius.circular(AppDimension.r30)),
            boxShadow: [AppColors.shadowSoftBlack],
          ),
          child: Container(
            padding: const EdgeInsets.all(AppDimension.s6),
            decoration: const BoxDecoration(
              color: AppColors.colorAlabaster,
              borderRadius: BorderRadius.all(Radius.circular(AppDimension.r20)),
              boxShadow: [AppColors.shadowSoftBlack],
            ),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: AppColors.colorBronze,
              padding: EdgeInsets.zero,
              dashPattern: const [5, 5],
              radius: const Radius.circular(AppDimension.r16),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimension.s30,
                  bottom: AppDimension.s14,
                  left: AppDimension.s14,
                  right: AppDimension.s14,
                ),
                child: child,
              ),
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: CircleButtonWidget(
            iconSvg: Assets.icons.close,
            onTap: onClose,
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
      ],
    );
  }
}
