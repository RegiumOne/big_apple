import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/passive_item_widget.dart';
import 'package:big_apple/presentation/widgets/requirements_widget.dart';
import 'package:big_apple/presentation/widgets/resource_for_building_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class BuildingCardWidget extends StatefulWidget {
  const BuildingCardWidget({
    super.key,
    required this.building,
    required this.availableMoney,
    required this.onBuild,
  });

  final Building building;
  final double availableMoney;
  final void Function() onBuild;

  @override
  State<BuildingCardWidget> createState() => _BuildingCardWidgetState();
}

class _BuildingCardWidgetState extends State<BuildingCardWidget> {
  final FlipCardController _controller = FlipCardController();

  @override
  void didUpdateWidget(covariant BuildingCardWidget oldWidget) {
    if (_controller.state?.isFront == false) {
      _controller.flipcard();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: _controller,
      rotateSide: RotateSide.right,
      onTapFlipping: true,
      animationDuration: AppDuration.defaultAnimationDuration,
      backWidget: _BackWidget(
        building: widget.building,
        onInfo: () {
          _controller.flipcard();
        },
      ),
      frontWidget: _FrontWidget(
        building: widget.building,
        availableResources: {
          ResourceType.coin: widget.availableMoney.toInt(),
        },
        onBuild: widget.onBuild,
        onInfo: () {
          _controller.flipcard();
        },
      ),
    );
  }
}

class _BackWidget extends StatelessWidget {
  const _BackWidget({
    required this.building,
    required this.onInfo,
  });

  final Building building;
  final void Function() onInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: AppDimension.s142,
          constraints: const BoxConstraints(
            maxHeight: AppDimension.s260,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorPaleTaupe,
            borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
          ),
          padding: const EdgeInsets.only(
            top: AppDimension.s10,
            left: AppDimension.s14,
            right: AppDimension.s14,
            bottom: AppDimension.s12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppDimension.s22),
                child: TextWidget(
                  building.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: AppDimension.s8),
              TextWidget(
                building.description,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.colorDimGray,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppDimension.s12),
              ...building.passiveBenefits.keys.map((receiveType) {
                return PassiveItemWidget(
                  receiveItem: building.passiveBenefits[receiveType] ?? 0,
                  passiveBenefit: receiveType,
                  passiveDisadvantage: null,
                );
              }),
              if (building.income > 0) ...[
                const SizedBox(height: AppDimension.s8),
                PassiveItemWidget(
                  receiveItem: building.income.toInt(),
                  passiveBenefit: PassiveBenefit.income,
                  passiveDisadvantage: null,
                ),
              ],
              const SizedBox(height: AppDimension.s20),
              RequirementsWidget(building: building),
            ],
          ),
        ),
        Positioned(
          top: AppDimension.s6,
          right: AppDimension.s6,
          child: ButtonWidget(
            height: AppDimension.s22,
            width: AppDimension.s22,
            gradient: AppColors.blueGradientTopBottom,
            gradientPress: AppColors.darkBlueGradient,
            shadowOffsetBottom: AppDimension.s2,
            shadowColor: AppColors.colorRoyalBlue,
            iconSize: AppDimension.s12,
            childShadowColor: AppColors.colorMediumTransparencyBlack,
            childShadowOffset: const Offset(1, 1),
            iconSvg: Assets.icons.info,
            onPressed: onInfo,
          ),
        ),
      ],
    );
  }
}

class _FrontWidget extends StatelessWidget {
  const _FrontWidget({
    required this.building,
    required this.availableResources,
    required this.onBuild,
    required this.onInfo,
  });

  final Building building;
  final Map<ResourceType, int> availableResources;
  final void Function() onBuild;
  final void Function() onInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool canBuild = true;
    building.price.forEach((key, value) {
      if ((availableResources[key] ?? 0) < value) {
        canBuild = false;
      }
    });

    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: AppDimension.s142,
          constraints: const BoxConstraints(
            maxHeight: AppDimension.s260,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorPaleTaupe,
            borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
          ),
          padding: const EdgeInsets.only(
            top: AppDimension.s10,
            left: AppDimension.s6,
            right: AppDimension.s6,
            bottom: AppDimension.s12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 115,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimension.s12),
                        child: Image.asset(
                          building.imageDone(replacePath: false),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -AppDimension.s28,
                    child: Wrap(
                      spacing: AppDimension.s6,
                      runSpacing: AppDimension.s6,
                      children: building.price.keys.map((cost) {
                        return ResourceForBuildingWidget(
                          requiredValue: building.price[cost] ?? 0,
                          availableValue: availableResources[cost] ?? 0,
                          resourceType: cost,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.s28),
              const SizedBox(height: AppDimension.s6),
              TextWidget(
                building.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppDimension.s2),
              Expanded(
                child: TextWidget(
                  'Building time  - ${building.buildingDurationInSeconds.toInt().toTimeText()}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.colorDimGray,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: AppDimension.s4),
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
                  text: canBuild ? 'Build' : 'Can’t be build',
                  onPressed: onBuild,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: AppDimension.s6,
          right: AppDimension.s6,
          child: ButtonWidget(
            height: AppDimension.s22,
            width: AppDimension.s22,
            gradient: AppColors.blueGradientTopBottom,
            gradientPress: AppColors.darkBlueGradient,
            shadowOffsetBottom: AppDimension.s2,
            shadowColor: AppColors.colorRoyalBlue,
            iconSize: AppDimension.s12,
            childShadowColor: AppColors.colorMediumTransparencyBlack,
            childShadowOffset: const Offset(1, 1),
            iconSvg: Assets.icons.info,
            onPressed: onInfo,
          ),
        ),
      ],
    );
  }
}
