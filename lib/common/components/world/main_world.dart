import 'dart:async';
import 'dart:developer';

import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/common/components/zone_component.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
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

  void removeBuildingById(int id) {
    return removeWhere((component) => component is BuildingComponent && component.id == id);
  }

  void buildBuildingById(int id) {
    Component? building = children.firstWhereOrNull((element) => element is BuildingComponent && element.id == id);
    if (building != null) {
      (building as BuildingComponent).build();
    }
  }

  Future<int?> placeBuilding(Building type, Coordinates coordinates) async {
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
    for (BuildingInfo buidling in buidlings) {
      BuildingComponent buildingComponent = BuildingComponent(
        id: buidling.coordinates.x.toInt() + buidling.coordinates.y.toInt(),
        building: buidling,
        size: Vector2.all(tileSize.x),
      );

      _initialBusyCoordinates.add(buildingComponent.position);

      await add(buildingComponent);
    }
  }
}
