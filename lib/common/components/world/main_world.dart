import 'dart:async';
import 'dart:developer';

import 'package:big_apple/common/components/small_building_component.dart';
import 'package:big_apple/common/components/zone_component.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MainWorld extends World {
  MainWorld({
    double tileWidth = 256,
    double tileHeight = 128,
  }) : tileSize = Vector2(tileWidth, tileHeight);

  final Vector2 tileSize;

  double get worldWidth => _worldWidth;
  double get worldHeight => _worldHeight;
  int get columnCount => (_worldWidth / tileSize.x).floor();
  int get rowCount => (_worldHeight / tileSize.y * 2).floor();

  double _worldWidth = -1;
  double _worldHeight = -1;

  late TiledComponent<FlameGame<World>> tiledMap;

  final List<Vector2> _initialBusyCoordinates = [];

  @override
  FutureOr<void> onLoad() async {
    tiledMap = await TiledComponent.load('apple_map.tmx', tileSize);

    _worldWidth = tiledMap.width;
    _worldHeight = tiledMap.height;

    await add(tiledMap);
    await _initZones();
  }

  Future<void> _initZones() async {
    TileLayer? backgroundLayer = tiledMap.tileMap.getLayer('Background');
    TileLayer? waterLayer = tiledMap.tileMap.getLayer('Water');
    await _initZonesLayer(backgroundLayer, false);
    await _initZonesLayer(waterLayer, true);
  }

  Future<void> _initZonesLayer(TileLayer? layer, bool isWater) async {
    if (layer == null || layer.data == null) return;

    int rowCount = layer.height;
    int columnCount = layer.width;

    for (int row = 0; row < rowCount; row++) {
      for (int column = 0; column < columnCount; column++) {
        int tile = layer.data![row * columnCount + column];
        if (tile == 0) continue;

        bool isEven = row % 2 == 0;

        double x = column * tileSize.x + (isEven ? 0 : tileSize.x / 2);
        double y = row * tileSize.y / 2;

        Vector2 position = Vector2(x, y);
        Vector2 size = Vector2(tileSize.x / 2, tileSize.y);

        //it is important that _initialBusyCoordinates are initialized first in the initBuildings method, otherwise you need to check in initBuildings too if _initZones is initialized first
        final checkPosition = _initialBusyCoordinates.firstWhereOrNull(
          (element) => (element - Vector2(64, 0)) == position,
        );

        if (checkPosition != null) {
          log('Busy position: $position');
        }

        ZoneComponent zoneComponent = ZoneComponent(
          tileSize: Vector2.all(tileSize.x),
          isAvailable: checkPosition == null,
          isWater: isWater,
        )
          ..position = position + Vector2(32, 0)
          ..anchor = Anchor.topLeft
          ..size = size;
        await add(zoneComponent);
      }
    }
  }

  ZoneComponent? getZoneByCoordinates(Coordinates coordinates) {
    List<Component> components = componentsAtPoint(Vector2(coordinates.x, coordinates.y)).toList();
    ZoneComponent? zoneComponent = components.firstWhereOrNull((element) => element is ZoneComponent) as ZoneComponent?;
    return zoneComponent;
  }

  Future<void> placeBuilding(BuildingType type, Coordinates coordinates) async {
    return getZoneByCoordinates(coordinates)?.addBuilding(type);
  }

  AudioFile getAudioFileFromZone(Coordinates coordinates) {
    List<Component> components = componentsAtPoint(Vector2(coordinates.x, coordinates.y)).toList();
    SmallBuildingComponent? buildingComponent =
        components.firstWhereOrNull((element) => element is SmallBuildingComponent) as SmallBuildingComponent?;
    if (buildingComponent?.isUnderConstruction == true) {
      return AudioFile.constructionSounds;
    }
    ZoneComponent? zoneComponent = components.firstWhereOrNull((element) => element is ZoneComponent) as ZoneComponent?;
    if (zoneComponent?.isWater == false) {
      return AudioFile.forest;
    } else if (zoneComponent?.isWater == true) {
      return AudioFile.riverStream;
    }
    return AudioFile.forest;
  }

  Future<void> initBuildings(List<Building> buidlings) async {
    for (Building buidling in buidlings) {
      SmallBuildingComponent buildingComponent = SmallBuildingComponent(
        building: buidling,
        size: Vector2.all(tileSize.x),
      );

      _initialBusyCoordinates.add(buildingComponent.position);

      await add(buildingComponent);
    }
  }
}
