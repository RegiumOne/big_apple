import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MainWorld extends World {
  MainWorld({
    required this.worldWidth,
    required this.worldHeight,
    this.tileWidth = 128,
    this.tileHeight = 64,
  });
  late TiledComponent level;

  final double worldWidth;
  final double worldHeight;
  final double tileWidth;
  final double tileHeight;

  @override
  FutureOr<void> onLoad() async {
    TiledComponent homeMap = await TiledComponent.load('map.tmx', Vector2(tileWidth, tileHeight));
    add(homeMap);
    _addMill(homeMap);
  }

  void _addMill(TiledComponent tiledMap) async {
    ObjectGroup? objGroup = tiledMap.tileMap.getLayer<ObjectGroup>('Mill');
    if (objGroup?.objects.isNotEmpty != true) return;

    TiledObject obj = objGroup!.objects.first;

    final comp = MillObject(
      position: Vector2(obj.x, obj.y),
      size: Vector2(tileWidth, tileWidth),
      sprite: await Sprite.load('mill.png'),
    );

    add(comp);
  }
}

class MillObject extends SpriteComponent {
  MillObject({
    required Vector2 position,
    required Vector2 size,
    required Sprite sprite,
  }) {
    this.sprite = sprite;
    this.position = position;
    this.size = size;
  }
}
