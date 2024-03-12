import 'dart:developer';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/building.dart';
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

  Future<int?> addBuilding(Building type) async {
    if (isWater) return null;
    if (!isAvailable) {
      log('There is already a building here');
      return null;
    }
    isAvailable = false;

    double centeredX = position.x - position.x % 256;
    double centeredY = position.y - position.y % 128;

    final buildingInfo = BuildingInfo(
      coordinates: Coordinates(x: centeredX, y: centeredY),
      building: type,
      constructionTimeLeft: type.buildingDurationInSeconds,
    );

    // final money = game.gameBloc.state.money - building.type.cost;
    // if (money < 0 || game.gameBloc.state.availableBuilders.isEmpty) return;

    game.gameBloc.add(GameAddBuildingEvent(buildingInfo));

    int id = DateTime.now().millisecondsSinceEpoch;

    final buildingComponent = BuildingComponent(
      id: id,
      building: buildingInfo,
      size: tileSize,
    );

    await world.add(buildingComponent);

    AudioService.instance.playConstructionMusic();

    return id;
  }
}
