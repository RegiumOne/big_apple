import 'dart:async';

import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

import 'package:big_apple/common/components/app_camera_component.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_duration.dart';

class BigAppleGame extends CommonGame with ScaleDetector {
  BigAppleGame({required this.gameBloc, required this.audioBloc});

  final GameBloc gameBloc;
  final AudioBloc audioBloc;

  AppCameraComponent? cam;

  MainWorld? level;

  Timer? _saveGameTimer;

  StreamSubscription? _camSubscription;

  @override
  Color backgroundColor() => const Color(0xFF275F84);

  @override
  FutureOr<void> onLoad() async {
    AudioService.instance.initialize();
    AudioService.instance.playMusic();
    await startGame();
    await _cacheImages();
    checkMusic();
    await super.onLoad();
  }

  @override
  void onRemove() {
    AudioService.instance.dispose();
    endGame();
    _camSubscription?.cancel();
    super.onRemove();
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    if (info.pointerCount == 1) {
      cam?.onPanUpdate(info.delta.global);
    } else if (info.pointerCount == 2) {
      bool zoomIn = info.scale.global.x > 1.0;
      cam?.onScaleUpdate(zoomIn);
    }
    super.onScaleUpdate(info);
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
  Future<void> startGame({bool isNewGame = false}) async {
    gameBloc.add(const GameLoadEvent());
    await _initCamera();
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
    AudioService.instance.pauseMusic();
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
    AudioService.instance.resumeMusic();
    _startSaveTimer();
  }

  @override
  void initBuildings(List<Building> buildings) async {
    if (level == null) return;
    level!.initBuildings(buildings);
  }

  @override
  void checkMusic() {
    AudioFile audioFile = level?.getAudioFileFromZone(getVisibleWorldCenter()) ?? AudioFile.forest;
    if (audioFile == AudioFile.forest) {
      AudioService.instance.playForestMusic();
    } else if (audioFile == AudioFile.riverStream) {
      AudioService.instance.playRiverStreamMusic();
    } else if (audioFile == AudioFile.constructionSounds) {
      AudioService.instance.playConstructionMusic();
    }
  }

  Future<void> _cacheImages() async {
    await images.loadAll([
      ...BuildingType.values.expand((e) => e.allImages),
      Assets.images.moveBuilding.asset(),
      Assets.images.btnApproveBuilding.asset(),
      Assets.images.btnCancelBuilding.asset(),
    ]);
  }

  Future<void> _initCamera() async {
    level = MainWorld();

    if (level == null) return;

    await add(level!);

    cam = AppCameraComponent(world: level);
    final bounds = Rectangle.fromLTWH(0, 0, level!.worldWidth, level!.worldHeight);
    cam?.setBounds(bounds);
    final initialPosition = Vector2(level!.worldWidth / 2, level!.worldHeight / 2);
    cam?.viewfinder.position = initialPosition;
    cam?.initZoom();

    if (cam != null && level != null) {
      await addAll([cam!]);
    }

    _camSubscription = cam?.onChangeStream.listen((_) {
      checkMusic();
    });
  }

  void _startSaveTimer() {
    _saveGameTimer?.cancel();
    _saveGameTimer = Timer.periodic(AppDuration.saveGameDuration, (timer) {
      gameBloc.add(const GameSaveEvent());
    });
  }

  @override
  void showShop() {
    overlays.add(Overlays.shop.name);
  }

  @override
  void hideShop() {
    overlays.remove(Overlays.shop.name);
  }

  @override
  void placeBuilding(BuildingType type) {
    level?.placeBuilding(type, getVisibleWorldCenter());
    hideShop();
  }

  // Calculate the center of the visible world
  Coordinates getVisibleWorldCenter() {
    final centerX = cam!.viewfinder.position.x;
    final centerY = cam!.viewfinder.position.y;
    return Coordinates(x: centerX, y: centerY);
  }
}
