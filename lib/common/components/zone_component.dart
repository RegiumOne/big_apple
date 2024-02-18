import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/common/components/building_component.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ZoneComponent extends PositionComponent
    with TapCallbacks, HasWorldReference<MainWorld>, HasGameReference<BigAppleGame> {
  ZoneComponent({required this.tileSize}) {
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

  Future<void> addBuilding(BuildingType type) async {
    final objectPosition = position - Vector2(32, tileSize.y / 2);

    // TODO(Sasha071201): through componentsAtPoint you can prevent objects from being created nearby
    // Iterable<Component> components = world.componentsAtPoint(objectPosition);
    // if (components.isNotEmpty && components.first is MillObject) {
    //   log('There is already a mill here');
    //   return;
    // }

    final building = Building(
      coordinates: Coordinates(x: objectPosition.x, y: objectPosition.y),
      type: type,
      constructionTimeLeft: type.constructionTimeInSeconds,
    );

    final money = game.gameBloc.state.money - building.type.cost;
    if (money < 0 || game.gameBloc.state.availableBuilders.isEmpty) return;

    game.gameBloc.add(GameAddBuildingEvent(building));

    final mill = BuildingComponent(
      building: building,
      size: tileSize,
    );
    await world.add(mill);
  }
}
