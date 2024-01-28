import 'dart:async';
import 'dart:ui';

import 'package:big_apple/components/app_camera_component.dart';
import 'package:big_apple/main_world.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BigAppleGame extends FlameGame with PanDetector, DoubleTapDetector {
  AppCameraComponent? cam;

  MainWorld? level;

  @override
  Color backgroundColor() => const Color(0xFF1E88E5);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
  }

  void _initCamera() async {
    level = MainWorld();

    if (level == null) return;
    
    await add(level!);

    cam = AppCameraComponent(world: level);
    final bounds = Rectangle.fromLTWH(0, 0, level!.worldWidth, level!.worldHeight);
    cam?.setBounds(bounds);
    final initialPosition = Vector2(0, 0);
    cam?.viewfinder.position = initialPosition;

    if (cam != null && level != null) {
      addAll([cam!]);
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
