import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flame/components.dart';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';

const double _markerHeight = 70;
const double _markerWidth = _markerHeight - 10;
const double _markerResourceSize = 32;
const double _markerResourcePaddingTop = 7;

/// A component that represents a small building in the game.
/// It can be dragged and dropped to a new position.
/// It can be declined or approved.
/// It can be under construction or not.
class BuildingComponent extends SpriteComponent with HasGameReference<BigAppleGame>, HasWorldReference<MainWorld> {
  BuildingComponent({
    required this.building,
    super.anchor = Anchor.center,
    bool markAsBuild = false,
  }) : super(
          priority: building.y.toInt() + (building.type == BuildingType.coalElectricStation ? 100 : 0),
        ) {
    id = building.id;
    // debugMode = true;
  }
  BuildingEntity building;

  late final int id;
  double _incomeTimer = 0;

  bool _isUnderConstruction = false;
  bool get isUnderConstruction => _isUnderConstruction;

  bool _isMarkerEnabled = false;
  double _markerAnimationAppearanceProgress = 0;
  double _markerAnimationAppearanceTimer = 0;

  double _markerOpacity = 1.0;
  double _resourceOpacity = 1.0;
  double _resourceOffsetY = 0.0;
  bool _isCollectingResources = false;

  double _animationCollectingTimer = 0.0;

  @mustCallSuper
  Future<Vector2> build() async {
    _isUnderConstruction = true;
    building = building.copyWith(
      constructionTimeLeft: building.type.getBuildingDurationInSecondsByLevel(building.level).toDouble(),
    );
    world.getZoneByVector2(position)?.changeAvailability(false);
    await _updateSprite();
    return position;
  }

  @override
  FutureOr<void> onLoad() async {
    // TODO(Sasha071201): enable marker when you have enough resources
    enableMarker();
    sprite = Sprite(game.images.fromCache(building.type.imageDone()));

    double newXPosition = (building.x / 128).round() * 128;
    bool isOdd = (newXPosition / 128).round().isOdd;
    double newYPosition = (building.y / 128).round() * 128 + (isOdd ? 0 : -64);
    Vector2 newPosition = Vector2(newXPosition, newYPosition);

    if (building.type == BuildingType.coalElectricStation) {
      size = Vector2(512, 533);
      position = newPosition - Vector2(0, 54);
    } else if (building.type == BuildingType.road) {
      size = Vector2(256, 133);
      position = newPosition + Vector2(0, 28);
    } else {
      size = Vector2(256, 256);
      position = newPosition;
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isUnderConstruction) {
      _construction(dt);
    }

    if (_isMarkerEnabled && _markerAnimationAppearanceTimer < AppDuration.defaultAnimationSpeed) {
      _markerAnimationAppearanceTimer += dt;
      _markerAnimationAppearanceProgress =
          (_markerAnimationAppearanceTimer / AppDuration.defaultAnimationSpeed).clamp(0.0, 1.0);
    }

    if (_isCollectingResources) {
      _animationCollectingTimer += dt;

      const animationDuration = AppDuration.collectAnimationSpeed;
      if (_animationCollectingTimer <= animationDuration) {
        _markerOpacity = 1.0 - (_animationCollectingTimer / (animationDuration / 2)).clamp(0.0, 1.0);
        _resourceOpacity =
            1.0 - ((_animationCollectingTimer - animationDuration / 2) / (animationDuration / 2)).clamp(0.0, 1.0);
        _resourceOffsetY = -50.0 * (_animationCollectingTimer / (animationDuration / 2)).clamp(0.0, 1.0);
      } else {
        _isCollectingResources = false;
        _markerOpacity = 1.0;
        _resourceOpacity = 1.0;
        _resourceOffsetY = 0.0;
      }
    }
  }

  @mustCallSuper
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (!_isMarkerEnabled) {
      Paint markerPaint = Paint()..color = Colors.white.withOpacity(_markerOpacity);
      Sprite(
        game.images.fromCache(Assets.images.resourceMarker.asset()),
      ).render(
        canvas,
        position: Vector2(size.x / 2, size.y / 8),
        size: Vector2(_markerWidth, _markerHeight) * _markerAnimationAppearanceProgress,
        anchor: Anchor.topCenter,
        overridePaint: markerPaint,
      );

      Paint coinPaint = Paint()..color = Colors.white.withOpacity(_resourceOpacity);
      Sprite(
        game.images.fromCache(Assets.images.coin.asset()),
      ).render(
        canvas,
        position: Vector2(size.x / 2, (size.y / 8) + _markerResourcePaddingTop + _resourceOffsetY),
        size: Vector2(_markerResourceSize, _markerResourceSize) * _markerAnimationAppearanceProgress,
        anchor: Anchor.topCenter,
        overridePaint: coinPaint,
      );
    }

    if (_isUnderConstruction) {
      const padding = AppDimension.s4;

      final progress =
          (building.constructionTimeLeft / building.type.getBuildingDurationInSecondsByLevel(building.level))
              .clamp(0.0, 1.0);
      const barHeight = 32.0;
      final barWidth = size.x;
      const borderRadius = Radius.circular(12);
      final gradient = LinearGradient(
        colors: [Colors.orangeAccent.shade700, Colors.black.withOpacity(.2)],
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            height: 1,
            fontWeight: FontWeight.bold,
            fontFamily: 'ProtestStrike',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset((size.x - textPainter.width) / 2, -barHeight + 4),
      );
    }
  }

  void _construction(double dt) {
    if (!_isUnderConstruction) return;

    _incomeTimer = 0;
    final double constructionTimer = building.constructionTimeLeft - dt;
    building = building.copyWith(constructionTimeLeft: constructionTimer);
    if (constructionTimer <= 0) {
      _isUnderConstruction = false;
      building = building.copyWith(constructionTimeLeft: 0);
      game.audioBloc.add(const AudioCheckMusicEvent());
    }

    _updateSprite();
  }

  Future<void> _updateSprite() async {
    String spritePath;

    if (_isUnderConstruction) {
      double progress =
          1 - (building.constructionTimeLeft / building.type.getBuildingDurationInSecondsByLevel(building.level));
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

  void enableMarker() {
    _isMarkerEnabled = true;
    _markerAnimationAppearanceProgress = 0;
    _markerAnimationAppearanceTimer = 0;
  }

  void disableMarker() {
    _isMarkerEnabled = true;
    _markerAnimationAppearanceProgress = 0;
    _markerAnimationAppearanceTimer = 0;
  }

  void collectResources() {
    if (_isMarkerEnabled) {
      _isCollectingResources = true;
      _animationCollectingTimer = 0.0;
    }
  }

  // ignore: unused_element
  void _income(double dt) {
    if (_isUnderConstruction) return;

    _incomeTimer += dt;

    if (_incomeTimer >= AppDuration.buildingIncomeIntervalInSeconds) {
      _incomeTimer = 0;
    }
  }
}
