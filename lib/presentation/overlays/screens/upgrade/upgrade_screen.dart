import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/data/dto/enum/upgrade_menu.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/passive_item_widget.dart';
import 'package:big_apple/presentation/widgets/requirements_widget.dart';
import 'package:big_apple/presentation/widgets/resource_for_building_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({
    required this.game,
    super.key,
  });

  final CommonGame game;

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  UpgradeMenu _selectedCategory = UpgradeMenu.upgrade;

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
    return BackgroundBottomWidget<UpgradeMenu>(
      items: UpgradeMenu.values.map((e) => CategoryMenu(title: e.title, gradient: e.gradient, category: e)).toList(),
      onCategoryChange: (category) {
        setState(() {
          _selectedCategory = category.category;
        });
      },
      selectedCategory: CategoryMenu(
        title: _selectedCategory.title,
        gradient: _selectedCategory.gradient,
        category: _selectedCategory,
      ),
      onClose: () {
        _hideShop();
      },
      child: BlocBuilder<GameHudBloc, GameHudState>(
        builder: (context, state) {
          BuildingEntity building = state.selectedBuilding!;
          bool canBeUpgraded = state.gameStat.canBeBuilt(building.type, building.level + 1);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 142,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.colorPaleTaupe,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimension.s10)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.s14,
                    vertical: AppDimension.s10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        'Now [lvl ${building.level}]',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppDimension.s8),
                      ...building.type.getPassiveBenefitsByLevel(building.level).keys.map((receiveType) {
                        return PassiveItemWidget(
                          receiveItem: building.type.getPassiveBenefitsByLevel(building.level)[receiveType] ?? 0,
                          passiveBenefit: receiveType,
                          passiveDisadvantage: null,
                        );
                      }),
                      if ((building.type.getIncomeByLevel(building.level)) > 0) ...[
                        const SizedBox(height: AppDimension.s8),
                        PassiveItemWidget(
                          receiveItem: building.type.getIncomeByLevel(building.level).toInt(),
                          passiveBenefit: PassiveBenefit.income,
                          passiveDisadvantage: null,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppDimension.s12),
              Expanded(
                flex: 267,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.colorPaleTaupe,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimension.s10)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.s14,
                    vertical: AppDimension.s10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        'After [lvl ${building.level + 1}]',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppDimension.s8),
                      ...building.type.getPassiveBenefitsByLevel(building.level + 1).keys.map((receiveType) {
                        return PassiveItemWidget(
                          receiveItem: building.type.getPassiveBenefitsByLevel(building.level + 1)[receiveType] ?? 0,
                          passiveBenefit: receiveType,
                          passiveDisadvantage: null,
                        );
                      }),
                      if ((building.type.getIncomeByLevel(building.level + 1)) > 0) ...[
                        const SizedBox(height: AppDimension.s8),
                        PassiveItemWidget(
                          receiveItem: building.type.getIncomeByLevel(building.level + 1).toInt(),
                          passiveBenefit: PassiveBenefit.income,
                          passiveDisadvantage: null,
                        ),
                      ],
                      const SizedBox(height: AppDimension.s16),
                      RequirementsWidget(buildingType: building.type),
                      const SizedBox(height: AppDimension.s16),
                      TextWidget(
                        'Cost',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      Wrap(
                        spacing: AppDimension.s6,
                        runSpacing: AppDimension.s6,
                        children: building.type.getPriceByLevel(building.level + 1).keys.map((cost) {
                          int availabeResource = 0;

                          if (cost == ResourceType.gold) {
                            availabeResource = state.gameStat.gold.toInt();
                          } else if (cost == ResourceType.coal) {
                            availabeResource = state.gameStat.coal.toInt();
                          } else if (cost == ResourceType.iron) {
                            availabeResource = state.gameStat.iron.toInt();
                          } else if (cost == ResourceType.electricity) {
                            availabeResource = state.gameStat.electricity;
                          } else if (cost == ResourceType.population) {
                            availabeResource = state.gameStat.peoples;
                          }

                          return ResourceForBuildingWidget(
                            requiredValue: building.type.getPriceByLevel(building.level + 1)[cost] ?? 0,
                            availableValue: availabeResource,
                            resourceType: cost,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppDimension.s12),
              Expanded(
                flex: 254,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.colorPaleTaupe,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimension.s10)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.s14,
                    vertical: AppDimension.s10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextWidget(
                              building.type.title,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Container(
                            height: AppDimension.s20,
                            width: AppDimension.s96,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: AppDimension.s6, vertical: AppDimension.s2),
                            decoration: const BoxDecoration(
                              color: AppColors.colorAlabaster,
                              borderRadius: BorderRadius.all(Radius.circular(AppDimension.s6)),
                            ),
                            child: TextWidget(
                              '[next level - lvl ${building.level + 1}]',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.colorBronze,
                                height: 1,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.s6),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(building.type.imageDone(replacePath: false)),
                        ),
                      ),
                      const SizedBox(height: AppDimension.s6),
                      IgnorePointer(
                        ignoring: !canBeUpgraded,
                        child: ButtonWidget(
                          width: double.infinity,
                          height: AppDimension.s32,
                          borderRadius: AppDimension.r6,
                          gradient:
                              canBeUpgraded ? AppColors.blueGradientTopBottom : AppColors.disablesGradientTopBottom,
                          gradientPress: AppColors.darkBlueGradient,
                          shadowColor: canBeUpgraded ? AppColors.colorRoyalBlue : AppColors.colorSlateGray,
                          childShadowColor: AppColors.colorMediumTransparencyBlack,
                          childShadowOffset: const Offset(2, 2),
                          text: canBeUpgraded ? 'Upgrade' : 'Can’t be upgrade',
                          onPressed: () {
                            // TODO(Sasha071201): upgrade logic
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _hideShop() {
    context.read<GameHudBloc>().add(const GameHudEvent.hideBuilding());
  }
}
