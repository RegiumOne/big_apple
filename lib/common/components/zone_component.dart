import 'dart:developer';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
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

  Future<void> addBuilding(BuildingType type) async {
    if (isWater) return;
    final objectPosition = position + Vector2(32, 0);
    if (!isAvailable) {
      log('There is already a building here');
      return;
    }
    isAvailable = false;

    final building = Building(
      coordinates: Coordinates(x: objectPosition.x, y: objectPosition.y),
      type: type,
      constructionTimeLeft: type.constructionTimeInSeconds,
    );

    final money = game.gameBloc.state.money - (building.type.cost[ResourceType.coin] ?? 0);
    if (money < 0 || game.gameBloc.state.availableBuilders.isEmpty) return;

    game.gameBloc.add(GameAddBuildingEvent(building));

    final mill = BuildingComponent(
      building: building,
      size: tileSize,
    );
    await world.add(mill);
    AudioService.instance.playConstructionMusic();
  }
}
