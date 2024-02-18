import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:big_apple/resources/values/app_duration.dart';

class AppCameraComponent extends CameraComponent {
  AppCameraComponent({
    super.world,
    this.moveSpeed = 2,
    this.maxZoom = 1,
    this.minZoom = 0.5,
  });

  final double moveSpeed;
  final double maxZoom;
  final double minZoom;

  void initZoom() {
    final zoomEffect = ScaleEffect.to(Vector2.all(minZoom), EffectController(duration: 0));
    viewfinder.add(zoomEffect);
  }

  void onPanUpdate(Vector2 globalDelta) {
    final currentPosition = viewfinder.position;
    final scaledDelta = globalDelta * moveSpeed / viewfinder.zoom;
    final newPosition = currentPosition - scaledDelta;
    viewfinder.position = newPosition;
  }

  bool _isProcessing = false;

  void onScaleUpdate(bool zoomIn) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _zoom(zoomIn);
    await Future.delayed(const Duration(milliseconds: 400));
    _isProcessing = false;
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
}
