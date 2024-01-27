import 'package:big_apple/components/mill_object.dart';
import 'package:big_apple/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ZoneComponent extends PositionComponent with TapCallbacks, HasWorldReference<MainWorld> {
  ZoneComponent({
    required this.tileSize,
  }) {
    // debugMode = true;
  }

  final Vector2 tileSize;

  final _paint = Paint();
  bool _isPressed = false;

  @override
  void onTapDown(TapDownEvent event) {
    _isPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) async {
    _isPressed = false;

    _addMill();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _isPressed = false;
  }

  @override
  void render(Canvas canvas) {
    _paint.color = _isPressed ? Colors.red : Colors.transparent;
    final rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, _paint);
  }

  Future<void> _addMill() async {
    final objectPosition = position - Vector2(32, tileSize.y / 2);

    // TODO(Sasha071201): through componentsAtPoint you can prevent objects from being created nearby
    // Iterable<Component> components = world.componentsAtPoint(objectPosition);
    // if (components.isNotEmpty && components.first is MillObject) {
    //   log('There is already a mill here');
    //   return;
    // }

    final mill = MillObject(
      position: objectPosition,
      size: tileSize,
      sprite: await Sprite.load('mill.png'),
    );
    await world.add(mill);
  }
}
