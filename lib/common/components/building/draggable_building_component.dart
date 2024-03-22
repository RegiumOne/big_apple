import 'dart:ui';

import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:flame/components.dart';

import 'package:big_apple/common/components/building/building_component.dart';
import 'package:big_apple/common/components/building/tappable_building_component.dart';
import 'package:big_apple/common/components/zone_component.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/di/injector.dart';
import 'package:big_apple/domain/services/building_service.dart';

// TODO(hrubalski): fix this workaround in the future
DraggableBuildingComponent? globalDraggableBuildingComponent;

class DraggableBuildingComponent extends BuildingComponent {
  DraggableBuildingComponent({
    required super.building,
    this.buildPreparation = false,
  }) {
    globalDraggableBuildingComponent = this;
  }

  Vector2? _positionBeforeDrag;
  Vector2? inputDelta;
  bool _isDragging = false;
  bool buildPreparation;

  void onDragStart(Vector2 delta) {
    _isDragging = true;
    _positionBeforeDrag = position.clone();
    inputDelta = delta;
  }

  void onDragUpdate(Vector2 delta) {
    if (_positionBeforeDrag == null) {
      onDragStart(delta);
      return;
    }
    if (!_isDragging) return;
    position.add(delta * 2);
  }

  @override
  Future<Vector2> build() async {
    globalDraggableBuildingComponent = null;
    _isDragging = false;
    Vector2 vector2 = await super.build();
    world.remove(this);
    world.add(
      TappableBuildingComponent(
        building: building.copyWith(
          x: position.x,
          y: position.y,
        ),
        markAsBuild: true,
      )..build(),
    );
    return vector2;
  }

  void onDragEnd() {
    if (!buildPreparation) {
      globalDraggableBuildingComponent = null;
      _isDragging = false;
    }

    double newXPosition = (position.x / 128).round() * 128;
    bool isOdd = (newXPosition / 128).round().isOdd;
    double newYPosition = (position.y / 128).round() * 128 + (isOdd ? 0 : -64);

    Vector2 newPosition = Vector2(newXPosition, newYPosition);

    ZoneComponent? newZone = world.getZoneByVector2(newPosition);

    if (newZone?.isAvailable == true) {
      if (building.type == BuildingType.road) {
        position = newPosition + Vector2(0, 28);
      } else {
        position = newPosition;
      }
      newZone?.changeAvailability(false);
      ZoneComponent? previousZone = world.getZoneByVector2(_positionBeforeDrag!);
      previousZone?.changeAvailability(true);
      inject<BuildingService>().updateLocation(building.id, x, y);
    } else {
      position = _positionBeforeDrag!;
    }

    if (buildPreparation) return;
    world.remove(this);
    world.add(
      TappableBuildingComponent(
        building: building.copyWith(
          x: position.x,
          y: position.y,
        ),
        markAsBuild: true,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    Sprite(
      game.images.fromCache(Assets.images.moveBuilding1x1.asset()),
    ).render(
      canvas,
      position: Vector2(0, 0),
      size: Vector2(size.x, size.y),
      anchor: Anchor.topLeft,
    );
    Sprite(
      game.images.fromCache(building.type.imageDone()),
    ).render(
      canvas,
      position: Vector2(0, 0),
      size: Vector2(size.x, size.y),
      anchor: Anchor.topLeft,
    );
  }
}
