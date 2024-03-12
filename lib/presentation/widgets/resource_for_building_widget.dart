import 'package:big_apple/common/utils/formatters.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResourceForBuildingWidget extends StatelessWidget {
  const ResourceForBuildingWidget({
    super.key,
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
