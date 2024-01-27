import 'package:flame/components.dart';

class MillObject extends SpriteComponent {
  MillObject({
    required Vector2 position,
    required super.size,
    required super.sprite,
  }) : super(
          priority: position.y.toInt() + 100,
          position: position,
        ) {
    debugMode = true;
  }
}
