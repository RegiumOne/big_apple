import 'package:big_apple/di/injector.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/services/building_service.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/bloc/building/building_bloc.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/building_button.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/level_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/main_info_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/resource_with_progress_bar_widget.dart';
import 'package:big_apple/presentation/widgets/safe_area_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flame/components.dart';
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
    return BlocConsumer<BuildingBloc, BuildingState>(
      listener: (context, state) async {
        if (state is BuidlingCancelled) {
          game.removeBuildingById(state.buildingEntity.id);
        } else if (state is BuidlingBuild) {
          Vector2? newCooridantes = await game.buildBuildingById(state.buildingEntity.id);
          if (newCooridantes != null) {
            BuildingEntity building = state.buildingEntity.copyWith(
              x: newCooridantes.x,
              y: newCooridantes.y,
            );

            inject<BuildingService>().build(building);
          }
        }
      },
      builder: (context, state) {
        bool buildingPreparing = state is BuildingPreparing;

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
                            BlocBuilder<GameBloc, GameState>(
                              builder: (context, state) {
                                double level = state.gameStat.ecologyLevel;
                                double currentLvlValue = level - level.floor();
                                return LevelWidget(
                                  currentLvlValue: currentLvlValue,
                                  level: level.floor(),
                                );
                              },
                            ),
                            const SizedBox(height: AppDimension.s10),
                            Row(
                              children: [
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
                                const SizedBox(width: AppDimension.s8),
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
                                  iconSvg: Assets.icons.info,
                                  onPressed: () {
                                    game.overlays.remove(Overlays.hud.name);
                                    game.overlays.add(Overlays.information.name);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 482,
                      child: Center(
                        child: BlocBuilder<GameBloc, GameState>(
                          builder: (context, state) => MainInfoWidget(gameStat: state.gameStat),
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
                          builder: (context, state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResourceWithProgressBarWidget(
                                value: state.gameStat.gold,
                                maxValue: state.gameStat.maxGold,
                                icon: Assets.icons.coin,
                              ),
                              const SizedBox(height: AppDimension.s6),
                              ResourceWithProgressBarWidget(
                                value: state.gameStat.coal,
                                maxValue: state.gameStat.maxCoal,
                                icon: Assets.icons.stone,
                              ),
                              const SizedBox(height: AppDimension.s6),
                              ResourceWithProgressBarWidget(
                                value: state.gameStat.iron,
                                maxValue: state.gameStat.maxIron,
                                icon: Assets.icons.metal,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (buildingPreparing)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildingButton(
                        icon: Assets.icons.cancel.svg(),
                        text: 'Cancel',
                        onPressed: () {
                          context.read<BuildingBloc>().add(CancelBuildingEvent(buildingEntity: state.buildingEntity));
                        },
                      ),
                      const SizedBox(width: AppDimension.s6),
                      BuildingButton(
                        icon: Assets.icons.checkmark.svg(),
                        text: 'Build',
                        onPressed: () {
                          context.read<BuildingBloc>().add(BuildBuildingEvent(buildingEntity: state.buildingEntity));
                        },
                      ),
                    ],
                  ),
                ),
              if (!buildingPreparing)
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
              if (!buildingPreparing)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
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
                        onPressed: () {
                          game.overlays.remove(Overlays.hud.name);
                          game.overlays.add(Overlays.port.name);
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
