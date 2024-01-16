import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class BigAppleGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final homeMap = await TiledComponent.load('map.tmx', Vector2(128, 64));
    add(homeMap);
  }
}
