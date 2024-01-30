import 'dart:async';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/components/mill_object.dart';
import 'package:big_apple/components/zone_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MainWorld extends World with HasGameReference<BigAppleGame> {
  MainWorld({
    double tileWidth = 128,
    double tileHeight = 64,
  }) : tileSize = Vector2(tileWidth, tileHeight);

  final Vector2 tileSize;

  double get worldWidth => _worldWidth;
  double get worldHeight => _worldHeight;
  int get columnCount => (_worldWidth / tileSize.x).floor();
  int get rowCount => (_worldHeight / tileSize.y * 2).floor();

  double _worldWidth = -1;
  double _worldHeight = -1;

  late TiledComponent<FlameGame<World>> tiledMap;

  @override
  FutureOr<void> onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', tileSize);

    _worldWidth = tiledMap.width;
    _worldHeight = tiledMap.height;

    await add(tiledMap);
    await _addMill();
    await _initZones();
  }

  Future<void> _addMill() async {
    ObjectGroup? objGroup = tiledMap.tileMap.getLayer<ObjectGroup>('Mill');
    if (objGroup?.objects.isNotEmpty != true) return;

    TiledObject obj = objGroup!.objects.first;

    final comp = MillObject(
      position: Vector2(obj.x, obj.y),
      size: Vector2.all(tileSize.x),
      sprite: Sprite(game.images.fromCache('mill.png')),
    );

    await add(comp);
  }

  Future<void> _initZones() async {
    TileLayer? backgroundLayer = tiledMap.tileMap.getLayer('Background');
    if (backgroundLayer == null || backgroundLayer.data == null) return;

    int rowCount = backgroundLayer.height;
    int columnCount = backgroundLayer.width;

    if (rowCount != backgroundLayer.height || columnCount != backgroundLayer.width) {
      throw Exception('Map size does not match the number of tiles');
    }

    for (int row = 0; row < rowCount; row++) {
      for (int column = 0; column < columnCount; column++) {
        int tile = backgroundLayer.data![row * columnCount + column];
        if (tile == 0) continue;

        bool isEven = row % 2 == 0;

        double x = column * tileSize.x + (isEven ? 0 : tileSize.x / 2);
        double y = row * tileSize.y / 2;

        Vector2 position = Vector2(x, y);
        Vector2 size = Vector2(tileSize.x / 2, tileSize.y);
        ZoneComponent zoneComponent = ZoneComponent(tileSize: Vector2.all(tileSize.x))
          ..position = position + Vector2(32, 0)
          ..anchor = Anchor.topLeft
          ..size = size;
        add(zoneComponent);
      }
    }
  }
}
