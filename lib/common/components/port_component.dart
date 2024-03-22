import 'dart:async';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';

class PortComponent extends SpriteButtonComponent with HasGameReference<BigAppleGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    size = Vector2(937, 579);
    position = Vector2(128, 6816);
    priority = position.y.toInt() + 100;
    button = Sprite(game.images.fromCache(Assets.images.portLvl3.asset()));
    return super.onLoad();
  }
}
