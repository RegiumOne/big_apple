import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/widgets/circle_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

class BackgroundBottomWidget<T extends Enum> extends StatelessWidget {
  const BackgroundBottomWidget({
    super.key,
    required this.child,
    required this.onClose,
    required this.selectedCategory,
    required this.onCategoryChange,
    required this.items,
  });

  final Widget child;
  final void Function() onClose;
  final CategoryMenu<T> selectedCategory;
  final List<CategoryMenu<T>> items;
  final void Function(CategoryMenu<T> category) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: List.generate(
                  items.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: index == items.length - 1 ? 0 : AppDimension.s6),
                    child: _CategoryWidget(
                      category: items[index],
                      isSelected: items[index] == selectedCategory,
                      onCategoryChange: onCategoryChange,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 740,
                maxHeight: 300,
              ),
              margin: const EdgeInsets.only(
                top: AppDimension.s46,
              ),
              decoration: const BoxDecoration(
                color: AppColors.colorBronze,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimension.r30),
                  topRight: Radius.circular(AppDimension.r30),
                ),
                boxShadow: [AppColors.shadowSoftBlack],
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: AppDimension.s12,
                      left: AppDimension.s16,
                      right: AppDimension.s16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.s20,
                      vertical: AppDimension.s22,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.colorAlabaster,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimension.r20),
                        topRight: Radius.circular(AppDimension.r20),
                      ),
                      boxShadow: [AppColors.shadowSoftBlack],
                    ),
                    child: child,
                  ),
                  Positioned(
                    bottom: -30,
                    top: 18,
                    right: 20,
                    left: 20,
                    child: IgnorePointer(
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppColors.colorBronze,
                        padding: EdgeInsets.zero,
                        dashPattern: const [5, 5],
                        radius: const Radius.circular(AppDimension.r16),
                        child: const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: CircleButtonWidget(
                iconSvg: Assets.icons.close,
                onTap: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryMenu<T extends Enum> {
  const CategoryMenu({
    required this.title,
    required this.gradient,
    required this.category,
  });
  final String title;
  final Gradient gradient;
  final T category;

  @override
  bool operator ==(covariant CategoryMenu<T> other) {
    if (identical(this, other)) return true;

    return other.title == title && other.gradient == gradient && other.category == category;
  }

  @override
  int get hashCode => title.hashCode ^ gradient.hashCode ^ category.hashCode;
}

class _CategoryWidget<T extends Enum> extends StatelessWidget {
  const _CategoryWidget({
    required this.category,
    required this.isSelected,
    required this.onCategoryChange,
  });

  final CategoryMenu<T> category;
  final bool isSelected;
  final void Function(CategoryMenu<T> category) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(AppDimension.r10),
      topRight: Radius.circular(AppDimension.r10),
    );
    return Container(
      height: AppDimension.s86,
      margin: EdgeInsets.only(
        top: isSelected ? 0 : AppDimension.s14,
      ),
      decoration: BoxDecoration(
        gradient: category.gradient,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            AudioService.instance.playSound(AudioFile.mouseClick);
            onCategoryChange(category);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.s20,
              vertical: AppDimension.s10,
            ),
            child: TextWidget(
              category.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                height: 1.2,
                shadows: [AppColors.shadowCrispEdge],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
