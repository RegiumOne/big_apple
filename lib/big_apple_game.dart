import 'dart:async';
import 'dart:ui';

import 'package:big_apple/components/app_camera_component.dart';
import 'package:big_apple/main_world.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BigAppleGame extends FlameGame with PanDetector, DoubleTapDetector {
  AppCameraComponent? cam;

  World? level;

  double get worldWidth => 4200;
  double get worldHeight => 670;

  double get worldCenterWidth => worldWidth / 2;
  double get worldCenterHeight => worldHeight / 2;

  @override
  Color backgroundColor() => const Color(0xFF1E88E5);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
  }

  void _initCamera() {
    level = MainWorld(
      worldHeight: worldHeight,
      worldWidth: worldWidth,
    );

    cam = AppCameraComponent(world: level);
    final bounds = Rectangle.fromLTWH(0, 0, worldWidth, worldHeight);
    cam?.setBounds(bounds);
    final initialPosition = Vector2(worldCenterWidth, worldCenterHeight);
    cam?.viewfinder.position = initialPosition;

    if (cam != null && level != null) {
      addAll([cam!, level!]);
    }
  }

  void reset() {
    if (cam != null && level != null) {
      removeAll([cam!, level!]);
    }
  }

  void startGame() {
    _initCamera();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    cam?.onPanUpdate(info);
  }

  @override
  void onDoubleTapDown(TapDownInfo info) {
    cam?.onDoubleTapDown(info);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(overlays.isActive(Overlays.pause))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        if (overlays.isActive(Overlays.hud)) {
          overlays.remove(Overlays.hud);
          overlays.add(Overlays.pause);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
