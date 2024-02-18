import 'dart:async';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BuildingComponent extends SpriteComponent with HasGameReference<BigAppleGame> {
  BuildingComponent({
    required this.building,
    required super.size,
  }) : super(
          priority: building.coordinates.y.toInt() + 100,
          position: Vector2(building.coordinates.x, building.coordinates.y),
        ) {
    // debugMode = true;
  }

  Building building;

  double _incomeTimer = 0;
  bool _isUnderConstruction = false;

  @override
  FutureOr<void> onLoad() async {
    _isUnderConstruction = building.constructionTimeLeft > 0;

    await _updateSprite();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _construction(dt);
    _income(dt);
  }

  @override
  void render(Canvas canvas) {
    if (_isUnderConstruction) {
      final progressBarPaint = Paint()..color = Colors.yellow;
      final backgroundBarPaint = Paint()..color = Colors.grey;
      final progress = (building.constructionTimeLeft / building.type.constructionTimeInSeconds).clamp(0.0, 1.0);
      const barHeight = 14.0;
      final barWidth = size.x;
      const borderRadius = Radius.circular(100);

      final backgroundBarRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, -barHeight, barWidth, barHeight),
        borderRadius,
      );
      final progressBarRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, -barHeight, barWidth * (1.0 - progress), barHeight),
        borderRadius,
      );

      canvas.drawRRect(backgroundBarRRect, backgroundBarPaint);
      canvas.drawRRect(progressBarRRect, progressBarPaint);

      final percentage = ((1.0 - progress) * 100).toStringAsFixed(0);
      final textPainter = TextPainter(
        text: TextSpan(
          text: "$percentage%",
          style: const TextStyle(color: Colors.black, fontSize: 14, height: 1),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset((size.x - textPainter.width) / 2, -barHeight + 1),
      );
    }

    super.render(canvas);
  }

  void _construction(double dt) {
    if (!_isUnderConstruction) return;

    _incomeTimer = 0;
    final double constructionTimer = building.constructionTimeLeft - dt;
    building = building.copyWith(constructionTimeLeft: constructionTimer);
    if (constructionTimer <= 0) {
      _isUnderConstruction = false;
      building = building.copyWith(constructionTimeLeft: 0);
      game.gameBloc.add(GameFinishBuildingEvent(building));
    }

    _updateSprite();
  }

  Future<void> _updateSprite() async {
    String spritePath;

    if (_isUnderConstruction) {
      double progress = 1 - (building.constructionTimeLeft / building.type.constructionTimeInSeconds);
      if (progress < 0.5) {
        spritePath = building.type.imageInitial();
      } else {
        spritePath = building.type.imageHalf();
      }
    } else {
      spritePath = building.type.imageDone();
    }

    sprite = Sprite(game.images.fromCache(spritePath));
  }

  void _income(double dt) {
    if (_isUnderConstruction) return;

    _incomeTimer += dt;

    if (_incomeTimer >= AppDuration.buildingIncomeIntervalInSeconds) {
      game.gameBloc.add(GameIncreaseMoneyEvent(building.type.moneyPerUnitOfTime));
      _incomeTimer = 0;
    }
  }
}
