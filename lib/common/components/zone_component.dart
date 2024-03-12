import 'dart:developer';

import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:flame/components.dart';

class ZoneComponent extends PositionComponent with HasWorldReference<MainWorld> {
  ZoneComponent({
    required this.tileSize,
    required this.isAvailable,
    required this.isWater,
  }) {
    // debugMode = true;
    if (isWater) {
      isAvailable = false;
    }
  }

  final Vector2 tileSize;
  final bool isWater;
  bool isAvailable;

  void changeAvailability(bool availability) {
    isAvailable = availability;
  }

  Future<void> addBuildingWithoutConstruction(BuildingInfo info) async {
    if (!isAvailable || isWater) {
      log('There is no available space for a building');
    }
    isAvailable = false;

    BuildingComponent buildingComponent = BuildingComponent(
      building: info,
      markAsBuild: true,
      size: Vector2.all(tileSize.x),
    );

    await world.add(buildingComponent);
  }

  Future<BuildingInfo?> addBuilding(Building type) async {
    if (!isAvailable || isWater) {
      log('There is no available space for a building');
      return null;
    }

    double centeredX = position.x - position.x % 256;
    double centeredY = position.y - position.y % 128;

    BuildingInfo buildingInfo = BuildingInfo(
      id: DateTime.now().millisecondsSinceEpoch,
      coordinates: Coordinates(x: centeredX, y: centeredY - 22),
      building: type,
      constructionTimeLeft: type.buildingDurationInSeconds,
    );

    BuildingComponent buildingComponent = BuildingComponent(
      building: buildingInfo,
      size: tileSize,
    );

    await world.add(buildingComponent);

    AudioService.instance.playConstructionMusic();

    return buildingInfo;
  }
}
