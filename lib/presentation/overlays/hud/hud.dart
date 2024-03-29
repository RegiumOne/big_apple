import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/di/injector.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/services/building_service.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/bloc/building/building_bloc.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/ecology_level_widget.dart';
import 'package:big_apple/presentation/widgets/building_button.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/level_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/main_info_widget.dart';
import 'package:big_apple/presentation/overlays/hud/widgets/resource_with_progress_bar_widget.dart';
import 'package:big_apple/presentation/widgets/safe_area_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
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
          child: BlocBuilder<GameHudBloc, GameHudState>(
            builder: (context, hudState) {
              double level = hudState.gameStat.ecologyLevel;
              double currentLvlValue = level - level.floor();

              bool buildingSelected = hudState.selectedBuilding != null;
              final buildingCategory = hudState.selectedBuilding == null
                  ? null
                  : BuildingCategory.getCategoryFromBuildingType(hudState.selectedBuilding!.type);

              bool isDisabledOtherButtons = buildingPreparing || buildingSelected;

              final noIncome = hudState.selectedBuilding == null
                  ? true
                  : (hudState.selectedBuilding!.type.getIncomeByLevel(hudState.selectedBuilding!.level) > 0);
              return Stack(
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
                              right: AppDimension.s20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LevelWidget(
                                  maxLvlValue: 1,
                                  currentLvlValue: currentLvlValue,
                                  level: level.floor(),
                                ),
                                const SizedBox(height: AppDimension.s10),
                                const EcologyLevelWidget(
                                  level: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 482,
                          child: Center(
                            child: MainInfoWidget(gameStat: hudState.gameStat),
                          ),
                        ),
                        Expanded(
                          flex: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimension.s8,
                              left: AppDimension.s22,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ResourceWithProgressBarWidget(
                                  value: hudState.gameStat.gold,
                                  maxValue: hudState.gameStat.maxGold,
                                  icon: Assets.icons.coin,
                                ),
                                const SizedBox(height: AppDimension.s6),
                                ResourceWithProgressBarWidget(
                                  value: hudState.gameStat.iron,
                                  maxValue: hudState.gameStat.maxIron,
                                  icon: Assets.icons.metal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (buildingSelected)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildingButton(
                            icon: Assets.images.infoBlue.image(
                              width: AppDimension.s30,
                              height: AppDimension.s30,
                            ),
                            text: 'Info',
                            onPressed: null,
                          ),
                          const SizedBox(width: AppDimension.s6),
                          BuildingButton(
                            icon: Assets.images.upgrade.image(
                              width: AppDimension.s30,
                              height: AppDimension.s30,
                            ),
                            text: 'Upgrade',
                            onPressed: buildingCategory?.maxLevel == hudState.selectedBuilding?.level
                                ? null
                                : () {
                                    game.overlays.remove(Overlays.hud.name);
                                    game.overlays.add(Overlays.upgrade.name);
                                  },
                          ),
                          const SizedBox(width: AppDimension.s6),
                          if (buildingCategory != BuildingCategory.apartments &&
                              buildingCategory != BuildingCategory.road)
                            BuildingButton(
                              icon: Assets.images.coinWithShadow.image(
                                width: AppDimension.s30,
                                height: AppDimension.s30,
                              ),
                              text: 'Collect',
                              // TODO(Sasha071201): Add collect income
                              onPressed: noIncome ? () {} : null,
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
                              context
                                  .read<BuildingBloc>()
                                  .add(CancelBuildingEvent(buildingEntity: state.buildingEntity));
                            },
                          ),
                          const SizedBox(width: AppDimension.s6),
                          BuildingButton(
                            icon: Assets.icons.checkmark.svg(),
                            text: 'Build',
                            onPressed: () {
                              context
                                  .read<BuildingBloc>()
                                  .add(BuildBuildingEvent(buildingEntity: state.buildingEntity));
                            },
                          ),
                        ],
                      ),
                    ),
                  if (!isDisabledOtherButtons)
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
                  if (!isDisabledOtherButtons)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(height: AppDimension.s12),
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
                            onPressed: () {
                              game.overlays.remove(Overlays.hud.name);
                              game.overlays.add(Overlays.portImport.name);
                            },
                          ),
                          const SizedBox(height: AppDimension.s12),
                          _PortButtonWidget(
                            game: game,
                            amount: 1,
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _PortButtonWidget extends StatelessWidget {
  const _PortButtonWidget({
    required this.game,
    required this.amount,
  });

  final CommonGame game;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
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
            game.overlays.add(Overlays.portStorage.name);
          },
        ),
        if (amount > 0)
          Positioned(
            top: -4,
            right: -9,
            child: IgnorePointer(
              child: Container(
                height: AppDimension.s22,
                width: AppDimension.s22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColors.sunsetPassionGradient,
                  borderRadius: BorderRadius.circular(AppDimension.r100),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.colorLightSemiTransparentBlack,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextWidget(
                  '$amount',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    height: 1,
                    shadows: [
                      const BoxShadow(
                        color: AppColors.colorMediumTransparencyBlack,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
