import 'dart:async';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flame/components.dart';

class BuildingComponent extends SpriteComponent with HasGameReference<BigAppleGame> {
  BuildingComponent({
    required this.building,
    required super.size,
  }) : super(
          priority: building.coordinates.y.toInt() + 100,
          position: Vector2(building.coordinates.x, building.coordinates.y),
        ) {
    debugMode = true;
  }

  final Building building;

  double _timer = 0;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache(building.type.image));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer += dt;

    if (_timer >= AppDuration.buildingIncomeIntervalInSeconds) {
      game.gameBloc.add(GameIncreaseMoneyEvent(building.type.moneyPerUnitOfTime));
      _timer = 0;
    }
  }
}
