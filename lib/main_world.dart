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
    final homeMap = await TiledComponent.load('map.tmx', Vector2(tileWidth, tileHeight));
    add(homeMap);
    return super.onLoad();
  }
}
