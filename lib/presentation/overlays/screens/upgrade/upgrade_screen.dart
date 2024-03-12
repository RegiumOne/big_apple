import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/upgrade_menu.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/passive_item_widget.dart';
import 'package:big_apple/presentation/widgets/requirements_widget.dart';
import 'package:big_apple/presentation/widgets/resource_for_building_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          final building = state.selectedBuilding?.building;
          final nextBuilding = building?.copyWith(currentLevel: building.currentLevel + 1);
          bool canBuild = true;
          nextBuilding?.price.forEach((key, value) {
            if ((state.availableResources[key] ?? 0) < value) {
              canBuild = false;
            }
          });
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
                        'Now [lvl ${building?.currentLevel}]',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppDimension.s8),
                      ...?building?.passiveBenefits.keys.map((receiveType) {
                        return PassiveItemWidget(
                          receiveItem: building.passiveBenefits[receiveType] ?? 0,
                          passiveBenefit: receiveType,
                          passiveDisadvantage: null,
                        );
                      }),
                      if ((building?.income ?? 0) > 0) ...[
                        const SizedBox(height: AppDimension.s8),
                        PassiveItemWidget(
                          receiveItem: building?.income.toInt() ?? 0,
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
                        'After [lvl ${nextBuilding?.currentLevel}]',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppDimension.s8),
                      ...?nextBuilding?.passiveBenefits.keys.map((receiveType) {
                        return PassiveItemWidget(
                          receiveItem: nextBuilding.passiveBenefits[receiveType] ?? 0,
                          passiveBenefit: receiveType,
                          passiveDisadvantage: null,
                        );
                      }),
                      if ((nextBuilding?.income ?? 0) > 0) ...[
                        const SizedBox(height: AppDimension.s8),
                        PassiveItemWidget(
                          receiveItem: nextBuilding?.income.toInt() ?? 0,
                          passiveBenefit: PassiveBenefit.income,
                          passiveDisadvantage: null,
                        ),
                      ],
                      const SizedBox(height: AppDimension.s16),
                      if (nextBuilding != null) RequirementsWidget(building: nextBuilding),
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
                        children: nextBuilding?.price.keys.map((cost) {
                              return ResourceForBuildingWidget(
                                requiredValue: nextBuilding.price[cost] ?? 0,
                                availableValue: state.availableResources[cost] ?? 0,
                                resourceType: cost,
                              );
                            }).toList() ??
                            [],
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
                              building?.title ?? '',
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
                              '[next level - lvl ${nextBuilding?.currentLevel}]',
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
                          child: nextBuilding == null
                              ? const SizedBox.shrink()
                              : Image.asset(
                                  nextBuilding.imageDone(replacePath: false),
                                ),
                        ),
                      ),
                      const SizedBox(height: AppDimension.s6),
                      IgnorePointer(
                        ignoring: !canBuild,
                        child: ButtonWidget(
                          width: double.infinity,
                          height: AppDimension.s32,
                          borderRadius: AppDimension.r6,
                          gradient: canBuild ? AppColors.blueGradientTopBottom : AppColors.disablesGradientTopBottom,
                          gradientPress: AppColors.darkBlueGradient,
                          shadowColor: canBuild ? AppColors.colorRoyalBlue : AppColors.colorSlateGray,
                          childShadowColor: AppColors.colorMediumTransparencyBlack,
                          childShadowOffset: const Offset(2, 2),
                          text: canBuild ? 'Upgrade' : 'Can’t be upgrade',
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
    context.read<GameBloc>().add(const GameSelectBuildingEvent(null));
  }
}
