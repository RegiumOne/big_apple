import 'package:big_apple/common/utils/formatters.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RequirementsWidget extends StatelessWidget {
  const RequirementsWidget({
    super.key,
    required this.buildingType,
  });

  final BuildingType buildingType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            ...buildingType.getRequirementsByLevel(1).keys.map(
                  (requirementType) => _RequirementsForBuildingWidget(
                    requiredValue: buildingType.getRequirementsByLevel(1)[requirementType] ?? 0,
                    requirementType: requirementType,
                    passiveDisadvantage: null,
                  ),
                ),
            ...buildingType.getPassiveDisadvantagesByLevel(1).keys.map(
                  (requirementType) => _RequirementsForBuildingWidget(
                    requiredValue: buildingType.getPassiveDisadvantagesByLevel(1)[requirementType] ?? 0,
                    requirementType: null,
                    passiveDisadvantage: requirementType,
                  ),
                ),
          ],
        ),
      ],
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
