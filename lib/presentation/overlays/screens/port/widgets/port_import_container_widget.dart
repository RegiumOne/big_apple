import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/resource_with_text_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PortImportContainerWidget extends StatelessWidget {
  const PortImportContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 259,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r10)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 258),
              child: Assets.images.portStorage.image(
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppDimension.s12),
        Expanded(
          flex: 404,
          child: Column(
            children: [
              _ResourceItemWidget(
                resourceType: ResourceType.wood,
                amount: 10,
                orderingTimeSec: 10,
                cost: 100,
                onPressed: () {},
              ),
              const SizedBox(height: AppDimension.s8),
              _ResourceItemWidget(
                resourceType: ResourceType.coal,
                amount: 10,
                orderingTimeSec: 10,
                cost: 100,
                isProgress: true,
                onPressed: () {},
              ),
              const SizedBox(height: AppDimension.s8),
              _ResourceItemWidget(
                resourceType: ResourceType.iron,
                amount: 50,
                orderingTimeSec: 10 * 60,
                cost: 1000,
                isFullStorage: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResourceItemWidget extends StatelessWidget {
  const _ResourceItemWidget({
    required this.resourceType,
    required this.amount,
    required this.orderingTimeSec,
    required this.cost,
    required this.onPressed,
    this.isProgress = false,
    this.isFullStorage = false,
  });

  final ResourceType resourceType;
  final int amount;
  final int orderingTimeSec;
  final int cost;
  final bool isProgress;
  final bool isFullStorage;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppDimension.s54,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.colorPaleTaupe,
        borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.s10,
        vertical: AppDimension.s10,
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(AppDimension.r6)),
                child: Assets.images.resourseBackground.image(
                  width: AppDimension.s32,
                  height: AppDimension.s32,
                ),
              ),
              SvgPicture.asset(
                resourceType.icon(replacePath: false, isWhite: true),
                width: AppDimension.s24,
                height: AppDimension.s24,
              ),
            ],
          ),
          const SizedBox(width: AppDimension.s8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithBorderWidget(
                  text: '$amount ${resourceType.title.toLowerCase()}',
                  style: theme.textTheme.titleMedium,
                ),
                TextWidget(
                  'Ordering time  - ${orderingTimeSec.toTimeText()}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.colorDimGray,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimension.s8),
          isProgress
              ? const _ProgressWidget()
              : IgnorePointer(
                  ignoring: isFullStorage,
                  child: ButtonWidget(
                    width: AppDimension.s140,
                    height: AppDimension.s32,
                    borderRadius: AppDimension.r6,
                    gradient: isFullStorage ? AppColors.disablesGradientTopBottom : AppColors.blueGradientTopBottom,
                    gradientPress: AppColors.darkBlueGradient,
                    shadowColor: isFullStorage ? AppColors.colorSlateGray : AppColors.colorRoyalBlue,
                    childShadowColor: AppColors.colorMediumTransparencyBlack,
                    childShadowOffset: const Offset(2, 2),
                    text: null,
                    onPressed: onPressed,
                    builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimension.s8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(
                            isFullStorage ? 'Full storage' : 'Order by $cost',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1,
                              color: Colors.white,
                              shadows: [
                                const BoxShadow(
                                  color: AppColors.colorMediumTransparencyBlack,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          if (!isFullStorage) ...[
                            const SizedBox(width: AppDimension.s4),
                            Assets.icons.coinWhite.svg(
                              width: AppDimension.s18,
                              height: AppDimension.s18,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _ProgressWidget extends StatefulWidget {
  const _ProgressWidget();

  @override
  State<_ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<_ProgressWidget> {
  double _fillPercentage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _fillPercentage = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          width: AppDimension.s140,
          height: AppDimension.s32,
          decoration: const BoxDecoration(
            color: AppColors.blackGlass,
            borderRadius: BorderRadius.all(Radius.circular(AppDimension.r6)),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            child: AnimatedFractionallySizedBox(
              duration: const Duration(seconds: 1),
              widthFactor: _fillPercentage,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.greenGradientTopBottom,
                  borderRadius: BorderRadius.circular(AppDimension.r6),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: TextWidget(
              'Ordering in process',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
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
      ],
    );
  }
}
