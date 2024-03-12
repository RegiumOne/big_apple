import 'dart:async';

import 'package:big_apple/common/components/world/main_world.dart';
import 'package:big_apple/common/components/zone_component.dart';
import 'package:big_apple/data/dto/enum/manufactory_type.dart';
import 'package:big_apple/data/dto/enum/road_type.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/common/extensions/int_extension.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/resources/values/app_duration.dart';

/// A component that represents a small building in the game.
/// It can be dragged and dropped to a new position.
/// It can be declined or approved.
/// It can be under construction or not.
/// Size: 256x178
class BuildingComponent extends SpriteComponent
    with HasGameReference<BigAppleGame>, HasWorldReference<MainWorld>, DragCallbacks {
  BuildingComponent({
    super.key,
    required this.building,
    required super.size,
    super.anchor = Anchor.center,
    bool markAsBuild = false,
  }) : super(
          priority: building.coordinates.y.toInt() +
              (building.building.type == ManufactoryType.coalElectricStation ? 100 : 0),
          position: Vector2(building.coordinates.x, building.coordinates.y),
        ) {
    id = building.id;
    if (markAsBuild) {
      _isEditing = false;
      _isBuild = true;
    }
    // debugMode = true;
  }

  BuildingInfo building;

  late final int id;
  double _incomeTimer = 0;
  bool _isDragging = false;
  bool _isEditing = true;
  bool _isBuild = false;
  bool _isUnderConstruction = false;
  bool get isUnderConstruction => _isUnderConstruction;

  Vector2? positionBeforeDrag;

  void markAsBuild() {
    _isEditing = false;
    _isBuild = true;
  }

  Future<Vector2> build() async {
    _isEditing = false;
    _isBuild = true;
    _isUnderConstruction = true;
    world.getZoneByVector2(position)?.changeAvailability(false);
    await _updateSprite();
    return position;
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(building.building.imageDone()));

    if (building.building.type == ManufactoryType.coalElectricStation) {
      size = Vector2(512, 533);
      position = Vector2(building.coordinates.x, building.coordinates.y - 54);
    } else if (building.building.type == RoadType.road) {
      size = Vector2(256, 133);
      position = Vector2(building.coordinates.x, building.coordinates.y + 28);
    } else {
      size = Vector2(256, 256);
      position = Vector2(building.coordinates.x, building.coordinates.y - 45);
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isUnderConstruction) {
      _construction(dt);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (_isUnderConstruction) return;
    positionBeforeDrag = position.clone();
    super.onDragStart(event);
    _isEditing = true;
    _isDragging = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_isUnderConstruction) return;
    super.onDragUpdate(event);
    if (_isDragging) {
      position.add(event.localDelta);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_isUnderConstruction) return;
    super.onDragEnd(event);
    _isDragging = false;
    _isEditing = !_isBuild;

    double newXPosition = (position.x / 128).round() * 128;
    bool isOdd = (newXPosition / 128).round().isOdd;
    double newYPosition = (position.y / 128).round() * 128 + (isOdd ? 64 : 0) - 23;
    Vector2 newPosition = Vector2(newXPosition, newYPosition);

    ZoneComponent? zone = world.getZoneByVector2(newPosition);

    if (zone?.isAvailable == true) {
      if (building.building.type == RoadType.road) {
        position = newPosition + Vector2(0, 28);
      } else {
        position = newPosition - Vector2(0, 45);
      }
      priority = position.y.toInt() + 100;
      if (_isBuild) {
        zone?.changeAvailability(false);
        ZoneComponent? previousZone = world.getZoneByVector2(positionBeforeDrag!);
        previousZone?.changeAvailability(true);
        game.gameBloc.add(
          UpdateBuildingEvent(
            building.copyWith(coordinates: Coordinates(x: newXPosition, y: newYPosition)),
          ),
        );
      }
    } else {
      position = positionBeforeDrag!;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isEditing) {
      Sprite(
        game.images.fromCache(Assets.images.moveBuilding1x1.asset()),
      ).render(
        canvas,
        position: Vector2(0, 0),
        size: Vector2(size.x, size.y),
        anchor: Anchor.topLeft,
      );
      Sprite(
        game.images.fromCache(building.building.imageDone()),
      ).render(
        canvas,
        position: Vector2(0, 0),
        size: Vector2(size.x, size.y),
        anchor: Anchor.topLeft,
      );
    }

    if (_isUnderConstruction) {
      const padding = AppDimension.s4;

      final progress = (building.constructionTimeLeft / building.building.buildingDurationInSeconds).clamp(0.0, 1.0);
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
      game.gameBloc.add(GameFinishBuildingEvent(building));
      game.audioBloc.add(const AudioCheckMusicEvent());
    }

    _updateSprite();
  }

  Future<void> _updateSprite() async {
    String spritePath;

    if (_isUnderConstruction) {
      double progress = 1 - (building.constructionTimeLeft / building.building.buildingDurationInSeconds);
      if (progress < 0.5) {
        spritePath = building.building.imageInitial();
      } else {
        spritePath = building.building.imageHalf();
      }
    } else {
      spritePath = building.building.imageDone();
    }

    sprite = Sprite(game.images.fromCache(spritePath));
  }

  // ignore: unused_element
  void _income(double dt) {
    if (_isUnderConstruction) return;

    _incomeTimer += dt;

    if (_incomeTimer >= AppDuration.buildingIncomeIntervalInSeconds) {
      game.gameBloc.add(GameIncreaseMoneyEvent(building.building.income));
      _incomeTimer = 0;
    }
  }
}
