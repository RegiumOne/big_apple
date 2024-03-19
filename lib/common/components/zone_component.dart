import 'dart:developer';

import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
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

  Future<void> addBuildingWithoutConstruction(BuildingEntity buildingEntity) async {
    if (!isAvailable || isWater) {
      log('There is no available space for a building');
    }
    isAvailable = false;

    BuildingComponent buildingComponent = BuildingComponent(
      building: buildingEntity,
      markAsBuild: true,
    );

    await world.add(buildingComponent);
  }

  Future<BuildingEntity?> addBuilding(BuildingType type) async {
    if (!isAvailable || isWater) {
      log('There is no available space for a building');
      return null;
    }

    double centeredX = position.x - position.x % 256;
    double centeredY = position.y - position.y % 128;

    BuildingEntity buildingEntity = BuildingEntity.initial(
      id: DateTime.now().millisecondsSinceEpoch,
      x: centeredX,
      y: centeredY,
      type: type,
    );

    BuildingComponent buildingComponent = BuildingComponent(building: buildingEntity);

    await world.add(buildingComponent);

    AudioService.instance.playConstructionMusic();

    return buildingEntity;
  }
}
