import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/resource_with_text_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class PortStorageContentWidget extends StatelessWidget {
  const PortStorageContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          child: Wrap(
            spacing: AppDimension.s6,
            runSpacing: AppDimension.s8,
            children: ResourceType.mainResources.map((e) {
              return Container(
                width: AppDimension.s110,
                height: AppDimension.s96,
                decoration: const BoxDecoration(
                  color: AppColors.colorPaleTaupe,
                  borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResourceWithTextWidget(
                      resourceTypeIcon: e.icon(),
                      value: 100,
                    ),
                    const SizedBox(height: AppDimension.s8),
                    TextWidget(
                      e.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
