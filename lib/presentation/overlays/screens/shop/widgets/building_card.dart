import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/common/utils/formatters.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

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
                return _PassiveItemWidget(
                  receiveItem: building.passiveBenefits[receiveType] ?? 0,
                  passiveBenefit: receiveType,
                  passiveDisadvantage: null,
                );
              }),
              if (building.income > 0) ...[
                const SizedBox(height: AppDimension.s8),
                _PassiveItemWidget(
                  receiveItem: building.income.toInt(),
                  passiveBenefit: PassiveBenefit.income,
                  passiveDisadvantage: null,
                ),
              ],
              const SizedBox(height: AppDimension.s20),
              TextWidget(
                'Requirements',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppDimension.s6),
              Wrap(
                spacing: AppDimension.s6,
                runSpacing: AppDimension.s6,
                children: [
                  ...building.requirements.keys.map((requirementType) {
                    return _RequirementsForBuildingWidget(
                      requiredValue: building.requirements[requirementType] ?? 0,
                      requirementType: requirementType,
                      passiveDisadvantage: null,
                    );
                  }),
                  ...building.passiveDisadvantages.keys.map((requirementType) {
                    return _RequirementsForBuildingWidget(
                      requiredValue: building.passiveDisadvantages[requirementType] ?? 0,
                      requirementType: null,
                      passiveDisadvantage: requirementType,
                    );
                  }),
                ],
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
                        return _ResourceForBuildingWidget(
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

class _PassiveItemWidget extends StatelessWidget {
  const _PassiveItemWidget({
    required this.receiveItem,
    required this.passiveBenefit,
    required this.passiveDisadvantage,
  });

  final int receiveItem;
  final PassiveBenefit? passiveBenefit;
  final PassiveDisadvantage? passiveDisadvantage;

  @override
  Widget build(BuildContext context) {
    final isBenefit = passiveBenefit != null;
    final theme = Theme.of(context);
    return Container(
      height: AppDimension.s22,
      decoration: BoxDecoration(
        gradient: isBenefit ? AppColors.greenGradientLeftRight : AppColors.redGradientLeftRight,
        borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r6)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.s6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextWidget(
              isBenefit
                  ? '+${formatNumber2(receiveItem.toInt())} ${passiveBenefit?.title}'
                  : '-${formatNumber2(receiveItem.toInt())} ${passiveDisadvantage?.title}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppDimension.s4),
          SvgPicture.asset(
            passiveBenefit?.icon(replacePath: false) ?? passiveDisadvantage!.icon(replacePath: false),
            width: AppDimension.s18,
            height: AppDimension.s18,
          ),
        ],
      ),
    );
  }
}

class _ResourceForBuildingWidget extends StatelessWidget {
  const _ResourceForBuildingWidget({
    required this.requiredValue,
    required this.availableValue,
    required this.resourceType,
  });

  final int requiredValue;
  final int availableValue;
  final ResourceType resourceType;

  @override
  Widget build(BuildContext context) {
    final canBuild = availableValue >= requiredValue;
    final theme = Theme.of(context);
    return Container(
      height: AppDimension.s22,
      decoration: BoxDecoration(
        gradient: canBuild ? AppColors.blueGradientLeftRight : AppColors.disablesGradientLeftRight,
        borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r6)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.s6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextWidget(
              formatNumber2(requiredValue.toInt()),
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppDimension.s4),
          SvgPicture.asset(
            resourceType.icon(replacePath: false),
            width: AppDimension.s18,
            height: AppDimension.s18,
          ),
        ],
      ),
    );
  }
}

class _RequirementsForBuildingWidget extends StatelessWidget {
  const _RequirementsForBuildingWidget({
    required this.requiredValue,
    required this.requirementType,
    required this.passiveDisadvantage,
  });

  final int requiredValue;
  final RequirementType? requirementType;
  final PassiveDisadvantage? passiveDisadvantage;

  @override
  Widget build(BuildContext context) {
    final title = requirementType?.title ?? passiveDisadvantage?.title ?? '';
    final theme = Theme.of(context);
    return Container(
      height: AppDimension.s22,
      decoration: const BoxDecoration(
        color: AppColors.colorAlabaster,
        borderRadius: BorderRadius.all(Radius.circular(AppDimension.r6)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.s6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextWidget(
              '${formatNumber2(requiredValue)}${title.isNotEmpty ? ' $title' : ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.black,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppDimension.s4),
          SvgPicture.asset(
            requirementType?.icon(replacePath: false) ?? passiveDisadvantage!.icon(replacePath: false),
            width: AppDimension.s18,
            height: AppDimension.s18,
          ),
        ],
      ),
    );
  }
}
