import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/common/components/zone_component.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';

class MainWorld extends World {
  MainWorld({
    double tileWidth = 256,
    double tileHeight = 128,
  }) : tileSize = Vector2(tileWidth, tileHeight);

  final Vector2 tileSize;

  bool _isInited = false;
  double get worldWidth => _worldWidth;
  double get worldHeight => _worldHeight;
  int get columnCount => (_worldWidth / tileSize.x).floor();
  int get rowCount => (_worldHeight / tileSize.y * 2).floor();

  double _worldWidth = -1;
  double _worldHeight = -1;

  late TiledComponent<FlameGame<World>> tiledMap;

  @override
  FutureOr<void> onLoad() async {
    tiledMap = await TiledComponent.load('apple_map.tmx', tileSize);

    _worldWidth = tiledMap.width;
    _worldHeight = tiledMap.height;

    await add(tiledMap);
    await _initZones();
    _isInited = true;
  }

  Future<void> _initZones() async {
    TileLayer? backgroundLayer = tiledMap.tileMap.getLayer('Background');
    TileLayer? waterLayer = tiledMap.tileMap.getLayer('Water');

    if (backgroundLayer == null || backgroundLayer.data == null) return;
    if (waterLayer == null || waterLayer.data == null) return;

    int rowCount = backgroundLayer.height;
    int columnCount = backgroundLayer.width;

    for (int row = 0; row < rowCount; row++) {
      for (int column = 0; column < columnCount; column++) {
        int backgroundTile = backgroundLayer.data![row * columnCount + column];
        int waterTile = waterLayer.data![row * columnCount + column];

        if (backgroundTile == 0) continue;

        bool isEven = row % 2 == 0;

        double x = column * tileSize.x + (isEven ? 0 : tileSize.x / 2);
        double y = row * tileSize.y / 2;

        Vector2 position = Vector2(x, y);
        Vector2 size = Vector2(tileSize.x / 2, tileSize.y);

        ZoneComponent zoneComponent = ZoneComponent(
          isWater: waterTile != 0,
          tileSize: Vector2.all(tileSize.x),
          isAvailable: true,
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

  ZoneComponent? getZoneByVector2(Vector2 vector2) {
    return getZoneByCoordinates(Coordinates(x: vector2.x, y: vector2.y));
  }

  void removeBuildingById(int id) {
    return removeWhere((component) => component is BuildingComponent && component.id == id);
  }

  Future<Vector2>? buildBuildingById(int id) {
    Component? building = children.firstWhereOrNull((element) => element is BuildingComponent && element.id == id);
    if (building != null) {
      return (building as BuildingComponent).build();
    }
    return null;
  }

  Future<BuildingInfo?> placeBuilding(Building type, Coordinates coordinates) async {
    return getZoneByCoordinates(coordinates)?.addBuilding(type);
  }

  AudioFile getAudioFileFromZone(Coordinates coordinates) {
    List<Component> components = componentsAtPoint(Vector2(coordinates.x, coordinates.y)).toList();
    BuildingComponent? buildingComponent =
        components.firstWhereOrNull((element) => element is BuildingComponent) as BuildingComponent?;
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

  Future<void> initBuildings(List<BuildingInfo> buidlings) async {
    if (!_isInited) {
      await Future.delayed(const Duration(milliseconds: 100));
      return initBuildings(buidlings);
    }
    for (BuildingInfo building in buidlings) {
      await getZoneByCoordinates(building.coordinates)?.addBuildingWithoutConstruction(building);
    }
  }
}
