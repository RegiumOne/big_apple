import 'package:big_apple/common/utils/formatters.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PassiveItemWidget extends StatelessWidget {
  const PassiveItemWidget({
    super.key,
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
