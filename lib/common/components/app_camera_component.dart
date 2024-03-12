import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:big_apple/resources/values/app_duration.dart';

class AppCameraComponent extends CameraComponent {
  AppCameraComponent({
    super.world,
    this.moveSpeed = 2,
    this.maxZoom = 0.75,
    this.minZoom = 0.50,
  });

  final double moveSpeed;
  final double maxZoom;
  final double minZoom;

  final StreamController _onChangeController = StreamController.broadcast();
  Stream get onChangeStream => _onChangeController.stream;

  void initZoom() {
    final zoomEffect = ScaleEffect.to(Vector2.all(minZoom), EffectController(duration: 0));
    viewfinder.add(zoomEffect);
  }

  void onPanUpdate(Vector2 globalDelta) {
    final currentPosition = viewfinder.position;
    final scaledDelta = globalDelta * moveSpeed / viewfinder.zoom;
    final newPosition = currentPosition - scaledDelta;

    // Limit the camera movement to the game world
    if (newPosition.x < 1340) {
      newPosition.x = 1340;
    } else if (newPosition.x > 8020) {
      newPosition.x = 8020;
    }

    if (newPosition.y < 930) {
      newPosition.y = 930;
    } else if (newPosition.y > 7080) {
      newPosition.y = 7080;
    }

    viewfinder.position = newPosition;

    _onChangeController.add(null);
  }

  bool _isProcessing = false;

  void onScaleUpdate(bool zoomIn) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _zoom(zoomIn);
    await Future.delayed(const Duration(milliseconds: 400));
    _isProcessing = false;

    _onChangeController.add(null);
  }

  void _zoom(bool zoomIn) {
    final currentZoom = (viewfinder.zoom * 10).round() / 10;
    double newZoom;

    if (currentZoom >= maxZoom && !zoomIn) {
      newZoom = minZoom;
    } else if (currentZoom <= minZoom && zoomIn) {
      newZoom = maxZoom;
    } else {
      return;
    }

    final zoomEffect = ScaleEffect.to(
      Vector2.all(newZoom),
      EffectController(duration: AppDuration.defaultAnimationSpeed),
    );

    viewfinder.add(zoomEffect);
  }

  @override
  void onRemove() {
    _onChangeController.close();
    super.onRemove();
  }
}
