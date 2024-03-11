import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/level_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/main_info_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/resource_with_progress_bar_widget.dart';
import 'package:big_apple/presentation/widgets/safe_area_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimension.s8,
                      right: AppDimension.s38,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LevelWidget(
                          maxLvlValue: 100,
                          currentLvlValue: 50,
                          level: 2,
                        ),
                        const SizedBox(height: AppDimension.s10),
                        ButtonWidget(
                          height: AppDimension.s42,
                          width: AppDimension.s42,
                          gradient: AppColors.blueGradientTopBottom,
                          gradientPress: AppColors.darkBlueGradient,
                          shadowColor: AppColors.colorRoyalBlue,
                          iconSize: AppDimension.s24,
                          childShadowColor: AppColors.colorMediumTransparencyBlack,
                          childShadowOffset: const Offset(2, 2),
                          iconPadding: const EdgeInsets.only(left: AppDimension.s2),
                          iconSvg: Assets.icons.settings,
                          onPressed: () {
                            game.overlays.remove(Overlays.hud.name);
                            game.overlays.add(Overlays.settings.name);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 482,
                  child: Center(
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return MainInfoWidget(
                          clover: 300,
                          energy: 300,
                          population: 999000,
                          totalBuilders: state.builders.length,
                          availableBuilders: state.availableBuilders.length,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimension.s8,
                      left: AppDimension.s20,
                    ),
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResourceWithProgressBarWidget(
                              maxValue: 1000,
                              value: state.money,
                              icon: Assets.icons.coin,
                            ),
                            const SizedBox(height: AppDimension.s6),
                            ResourceWithProgressBarWidget(
                              maxValue: 500,
                              value: 150,
                              icon: Assets.icons.stone,
                            ),
                            const SizedBox(height: AppDimension.s6),
                            ResourceWithProgressBarWidget(
                              maxValue: 1000,
                              value: 1000,
                              icon: Assets.icons.metal,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  borderRadius: AppDimension.r10,
                  iconSvg: Assets.icons.store,
                  childShadowColor: AppColors.colorMediumTransparencyBlack,
                  text: 'Cancel',
                  onPressed: () {},
                ),
                const SizedBox(width: AppDimension.s6),
                ButtonWidget(
                  borderRadius: AppDimension.r10,
                  iconSvg: Assets.icons.store,
                  childShadowColor: AppColors.colorMediumTransparencyBlack,
                  text: 'Build',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ButtonWidget(
              borderRadius: AppDimension.r10,
              iconSvg: Assets.icons.store,
              childShadowColor: AppColors.colorMediumTransparencyBlack,
              text: 'Store',
              onPressed: () {
                game.overlays.remove(Overlays.hud.name);
                game.overlays.add(Overlays.shop.name);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Column(
              children: [
                ButtonWidget(
                  gap: AppDimension.s2,
                  borderRadius: AppDimension.r10,
                  iconSvg: Assets.icons.storage,
                  gradient: AppColors.blueGradientTopBottom,
                  gradientPress: AppColors.darkBlueGradient,
                  shadowColor: AppColors.colorRoyalBlue,
                  childShadowColor: AppColors.colorMediumTransparencyBlack,
                  childShadowOffset: const Offset(2, 2),
                  text: 'Storage',
                  onPressed: () {},
                ),
                const SizedBox(height: AppDimension.s12),
                ButtonWidget(
                  gap: AppDimension.s2,
                  borderRadius: AppDimension.r10,
                  iconSvg: Assets.icons.port,
                  gradient: AppColors.blueGradientTopBottom,
                  gradientPress: AppColors.darkBlueGradient,
                  shadowColor: AppColors.colorRoyalBlue,
                  childShadowColor: AppColors.colorMediumTransparencyBlack,
                  childShadowOffset: const Offset(2, 2),
                  text: 'Port',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
