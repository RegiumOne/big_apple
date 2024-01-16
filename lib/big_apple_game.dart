import 'dart:async';
import 'dart:ui';

import 'package:big_apple/components/app_camera_component.dart';
import 'package:big_apple/main_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BigAppleGame extends FlameGame with PanDetector, DoubleTapDetector {
  late final AppCameraComponent cam;

  late World level;

  double get worldWidth => 4200;
  double get worldHeight => 670;

  double get worldCenterWidth => worldWidth / 2;
  double get worldCenterHeight => worldHeight / 2;

  @override
  Color backgroundColor() => const Color(0xFF1E88E5);

  @override
  FutureOr<void> onLoad() async {
    _initCamera();
    await super.onLoad();
  }

  void _initCamera() {
    level = MainWorld(
      worldHeight: worldHeight,
      worldWidth: worldWidth,
    );

    cam = AppCameraComponent(world: level);
    final bounds = Rectangle.fromLTWH(0, 0, worldWidth, worldHeight);
    cam.setBounds(bounds);
    final initialPosition = Vector2(worldCenterWidth, worldCenterHeight);
    cam.viewfinder.position = initialPosition;

    addAll([cam, level]);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    cam.onPanUpdate(info);
  }

  @override
  void onDoubleTapDown(TapDownInfo info) {
    cam.onDoubleTapDown(info);
  }
}
