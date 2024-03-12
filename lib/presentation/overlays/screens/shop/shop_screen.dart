import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/apartment.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/commercial.dart';
import 'package:big_apple/data/dto/enum/apartment_type.dart';
import 'package:big_apple/data/dto/enum/building_category.dart';
import 'package:big_apple/data/dto/enum/commercial_type.dart';
import 'package:big_apple/data/dto/enum/manufactory_type.dart';
import 'package:big_apple/data/dto/enum/road_type.dart';
import 'package:big_apple/data/dto/manufactory.dart';
import 'package:big_apple/data/dto/road.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/shop/widgets/building_card.dart';
import 'package:big_apple/presentation/widgets/background_bottom_widget.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
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

    return BackgroundBottomWidget<BuildingCategory>(
      items:
          BuildingCategory.values.map((e) => CategoryMenu(title: e.title, gradient: e.gradient, category: e)).toList(),
      onCategoryChange: (category) {
        setState(() {
          _selectedCategory = category.category;
        });
      },
      selectedCategory: CategoryMenu(
        title: _selectedCategory.title,
        gradient: _selectedCategory.gradient,
        category: _selectedCategory,
      ),
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
    );
  }

  void _hideShop() {
    widget.game.overlays.add(Overlays.hud.name);
    widget.game.overlays.remove(Overlays.shop.name);
  }
}
