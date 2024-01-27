import 'dart:async';

import 'package:big_apple/components/mill_object.dart';
import 'package:big_apple/components/zone_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
// ignore: implementation_imports
import 'package:flame_tiled/src/renderable_layers/tile_layers/tile_layer.dart';

class MainWorld extends World {
  MainWorld({
    required this.worldWidth,
    required this.worldHeight,
    double tileWidth = 128,
    double tileHeight = 64,
  }) : tileSize = Vector2(tileWidth, tileHeight);

  final double worldWidth;
  final double worldHeight;
  final Vector2 tileSize;

  late TiledComponent<FlameGame<World>> tiledMap;

  @override
  FutureOr<void> onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', tileSize);

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
      sprite: await Sprite.load('mill.png'),
    );

    await add(comp);
  }

  Future<void> _initZones() async {
    for (var layer in tiledMap.tileMap.renderableLayers) {
      // ignore: invalid_use_of_internal_member
      if (layer is FlameTileLayer && layer.layer.name == 'Background') {
        final renderableLayer = layer;
        for (var transform in renderableLayer.tiledAtlas.batch!.transforms) {
          Vector2 position = Vector2(transform.tx, transform.ty);
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
}
