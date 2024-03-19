import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/shop/widgets/building_card.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';

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

  String getTitleByCategory(BuildingCategory category) {
    switch (category) {
      case BuildingCategory.apartments:
        return 'Apartments';
      case BuildingCategory.commercial:
        return 'Commercial';
      case BuildingCategory.manufactory:
        return 'Manufactory';
      case BuildingCategory.road:
        return 'Road';
    }
  }

  Gradient getGradientByCategory(BuildingCategory category) {
    switch (category) {
      case BuildingCategory.apartments:
        return AppColors.blueGradientLeftRight;
      case BuildingCategory.commercial:
        return AppColors.greenGradientLeftRight;
      case BuildingCategory.manufactory:
        return AppColors.orangeGradientLeftRight;
      case BuildingCategory.road:
        return AppColors.brownGradientLeftRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BuildingType> buildings = BuildingCategory.getBuildings(_selectedCategory);

    return BackgroundBottomWidget<BuildingCategory>(
      items: BuildingCategory.values
          .map(
            (category) => CategoryMenu(
              title: getTitleByCategory(category),
              gradient: getGradientByCategory(category),
              category: category,
            ),
          )
          .toList(),
      onCategoryChange: (category) {
        setState(() {
          _selectedCategory = category.category;
        });
      },
      selectedCategory: CategoryMenu(
        title: getTitleByCategory(_selectedCategory),
        gradient: getGradientByCategory(_selectedCategory),
        category: _selectedCategory,
      ),
      onClose: () {
        _hideShop();
      },
      child: BlocBuilder<GameHudBloc, GameHudState>(
        builder: (context, state) => Row(
          children: List.generate(
            buildings.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: index == buildings.length - 1 ? 0 : AppDimension.s16),
              child: BuildingCardWidget(
                type: buildings[index],
                availableMoney: state.gameStat.gold,
                onBuild: () {
                  _hideShop();
                  widget.game.placeBuilding(buildings[index]);
                },
              ),
            ),
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
