import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/components/app_camera_component.dart';
import 'package:big_apple/components/world/main_world.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_duration.dart';

class BigAppleGame extends CommonGame with PanDetector, DoubleTapDetector {
  BigAppleGame(this.gameBloc);

  final GameBloc gameBloc;

  AppCameraComponent? cam;

  MainWorld? level;

  Timer? _saveGameTimer;

  @override
  Color backgroundColor() => const Color(0xFF1E88E5);

  @override
  FutureOr<void> onLoad() async {
    await _cacheImages();
    await super.onLoad();
  }

  @override
  void onRemove() {
    endGame();
    super.onRemove();
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
        resumeGame();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        pauseGame();
        break;
    }
    super.lifecycleStateChange(state);
  }

  @override
  void startGame({bool isNewGame = false}) {
    _initCamera();
    if (isNewGame) {
      // TODO(Sasha071201): Add reset game logic
    } else {
      gameBloc.add(const GameLoadEvent());
    }
    _startSaveTimer();
  }

  @override
  void endGame() {
    if (cam != null && level != null) {
      removeAll([cam!, level!]);
    }
    _saveGameTimer?.cancel();
  }

  @override
  void pauseGame() {
    if (overlays.isActive(Overlays.hud.name)) {
      overlays.remove(Overlays.hud.name);
      overlays.add(Overlays.pause.name);
    }
    pauseEngine();
    _saveGameTimer?.cancel();
  }

  @override
  void resumeGame() {
    if (!(overlays.isActive(Overlays.pause.name))) {
      resumeEngine();
    } else {
      overlays.add(Overlays.hud.name);
      overlays.remove(Overlays.pause.name);
      resumeEngine();
    }
    _startSaveTimer();
  }

  @override
  void initBuildings(List<Building> buildings) async {
    if (level == null) return;
    level!.initBuildings(buildings);
  }

  Future<void> _cacheImages() async {
    await images.loadAll([
      ...BuildingType.values.map((e) => e.image),
    ]);
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

  void _startSaveTimer() {
    _saveGameTimer?.cancel();
    _saveGameTimer = Timer.periodic(AppDuration.saveGameDuration, (timer) {
      gameBloc.add(const GameSaveEvent());
    });
  }
}
