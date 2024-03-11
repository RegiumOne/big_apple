import 'dart:ui';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/apartment.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/commercial.dart';
import 'package:big_apple/data/dto/enum/apartment_type.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/data/dto/enum/building_category.dart';
import 'package:big_apple/data/dto/enum/commercial_type.dart';
import 'package:big_apple/data/dto/enum/manufactory_type.dart';
import 'package:big_apple/data/dto/enum/road_type.dart';
import 'package:big_apple/data/dto/manufactory.dart';
import 'package:big_apple/data/dto/road.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/shop/widgets/building_card.dart';
import 'package:big_apple/presentation/widgets/circle_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    required this.game,
    super.key,
  });

  final CommonGame game;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  BuildingCategory _selectedCategory = BuildingCategory.apartments;

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

  List<Building> _getBuildingsForSelectedCategory(BuildingCategory category) {
    switch (category) {
      case BuildingCategory.apartments:
        return ApartmentType.values.map((e) => Apartment(currentLevel: 1, type: e)).toList();
      case BuildingCategory.commercial:
        return CommercialType.values.map((e) => Commercial(currentLevel: 1, type: e)).toList();
      case BuildingCategory.manufactory:
        return ManufactoryType.values.map((e) => Manufactory(currentLevel: 1, type: e)).toList();
      case BuildingCategory.road:
        return RoadType.values.map((e) => Road(currentLevel: 1, type: e)).toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Building> buildings = _getBuildingsForSelectedCategory(_selectedCategory);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: _BackgroundWidget(
          onCategoryChange: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
          selectedCategory: _selectedCategory,
          onClose: () {
            _hideShop();
          },
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Row(
                children: List.generate(buildings.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index == buildings.length - 1 ? 0 : AppDimension.s16),
                    child: BuildingCardWidget(
                      building: buildings[index],
                      availableMoney: state.money,
                      onBuild: () {
                        _hideShop();
                        widget.game.placeBuilding(buildings[index]);
                      },
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  void _hideShop() {
    widget.game.overlays.add(Overlays.hud.name);
    widget.game.overlays.remove(Overlays.shop.name);
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({
    required this.child,
    required this.onClose,
    required this.selectedCategory,
    required this.onCategoryChange,
  });

  final Widget child;
  final void Function() onClose;
  final BuildingCategory selectedCategory;
  final void Function(BuildingCategory category) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Row(
            children: List.generate(
              BuildingCategory.values.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: index == BuildingCategory.values.length - 1 ? 0 : AppDimension.s6),
                child: _CategoryWidget(
                  category: BuildingCategory.values[index],
                  isSelected: BuildingCategory.values[index] == selectedCategory,
                  onCategoryChange: onCategoryChange,
                ),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 740,
            maxHeight: 380,
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
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({
    required this.category,
    required this.isSelected,
    required this.onCategoryChange,
  });

  final BuildingCategory category;
  final bool isSelected;
  final void Function(BuildingCategory category) onCategoryChange;

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
