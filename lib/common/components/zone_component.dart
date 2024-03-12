import 'dart:developer';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:flame/components.dart';

class ZoneComponent extends PositionComponent with HasWorldReference<MainWorld>, HasGameReference<BigAppleGame> {
  ZoneComponent({
    required this.tileSize,
    required this.isAvailable,
    required this.isWater,
  }) {
    // debugMode = true;
  }

  final Vector2 tileSize;
  final bool isWater;
  bool isAvailable;

  Future<void> addBuilding(Building building) async {
    if (isWater) return;
    final objectPosition = position + Vector2(32, 0);
    if (!isAvailable) {
      log('There is already a building here');
      return;
    }
    isAvailable = false;

    final buildingInfo = BuildingInfo(
      coordinates: Coordinates(x: objectPosition.x, y: objectPosition.y),
      building: building,
      constructionTimeLeft: building.buildingDurationInSeconds,
    );

    final money = game.gameBloc.state.money - (buildingInfo.building.price[ResourceType.coin] ?? 0);
    if (money < 0 || game.gameBloc.state.availableBuilders.isEmpty) return;

    game.gameBloc.add(GameAddBuildingEvent(buildingInfo));

    final mill = BuildingComponent(
      building: buildingInfo,
      size: tileSize,
    );
    await world.add(mill);
    AudioService.instance.playConstructionMusic();
  }
}
