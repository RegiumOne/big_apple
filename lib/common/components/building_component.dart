import 'dart:async';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BuildingComponent extends SpriteComponent with HasGameReference<BigAppleGame> {
  BuildingComponent({
    required this.building,
    required super.size,
    super.anchor = Anchor.center,
  }) : super(
          priority: building.coordinates.y.toInt() + 100,
          position: Vector2(building.coordinates.x, building.coordinates.y),
        ) {
    // debugMode = true;
  }

  Building building;

  double _incomeTimer = 0;
  bool _isUnderConstruction = false;

  bool get isUnderConstruction => _isUnderConstruction;

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
    const padding = AppDimension.s4;
    if (_isUnderConstruction) {
      final progress = (building.constructionTimeLeft / building.type.constructionTimeInSeconds).clamp(0.0, 1.0);
      const barHeight = 14.0;
      final barWidth = size.x;
      const borderRadius = Radius.circular(100);
      final gradient = LinearGradient(
        colors: const [Colors.yellow, Colors.grey],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [1 - progress, 1 - progress],
      );

      final rect = Rect.fromLTWH(padding, -barHeight, barWidth - padding, barHeight);
      final progressBarPaint = Paint()..shader = gradient.createShader(rect);
      final progressBarRRect = RRect.fromRectAndRadius(rect, borderRadius);
      canvas.drawRRect(progressBarRRect, progressBarPaint);

      final timeText = building.constructionTimeLeft.toInt().toTimeText();
      final textPainter = TextPainter(
        text: TextSpan(
          text: timeText,
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
      game.audioBloc.add(const AudioCheckMusicEvent());
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
