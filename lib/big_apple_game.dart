import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

import 'package:big_apple/common/components/app_camera_component.dart';
import 'package:big_apple/common/components/world/main_world.dart';
import 'package:big_apple/common/extensions/asset_gen_extension.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/building/building_bloc.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_duration.dart';

class BigAppleGame extends CommonGame with ScaleDetector {
  BigAppleGame({
    required this.gameBloc,
    required this.audioBloc,
    required this.buildingBloc,
  });

  final GameBloc gameBloc;
  final AudioBloc audioBloc;
  final BuildingBloc buildingBloc;

  AppCameraComponent? cam;

  MainWorld? level;

  Timer? _saveGameTimer;

  StreamSubscription? _camSubscription;

  @override
  Color backgroundColor() => const Color(0xFF275F84);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    AudioService.instance.initialize();
    AudioService.instance.playMusic();
    await startGame();
    await _cacheImages();
    checkMusic();
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
    pauseEngine();
    _saveGameTimer?.cancel();
  }

  @override
  void resumeGame() {
    resumeEngine();
    AudioService.instance.resumeMusic();
    _startSaveTimer();
  }

  @override
  void initBuildings(List<BuildingInfo> buildings) async {
    level?.initBuildings(buildings);
  }

  @override
  void checkMusic() {
    AudioFile audioFile = level?.getAudioFileFromZone(getVisibleWorldCenter()) ?? AudioFile.forest;
    if (overlays.isActive(Overlays.shop.name) || overlays.isActive(Overlays.settings.name)) {
      AudioService.instance.playPopupWindowMusic();
    } else if (audioFile == AudioFile.forest) {
      AudioService.instance.playForestMusic();
    } else if (audioFile == AudioFile.riverStream) {
      AudioService.instance.playRiverStreamMusic();
    } else if (audioFile == AudioFile.constructionSounds) {
      AudioService.instance.playConstructionMusic();
    }
  }

  Future<void> _cacheImages() {
    return images.loadAll(Assets.images.values.map((e) => e.asset()).toList());
  }

  Future<void> _initCamera() async {
    level = MainWorld();

    if (level == null) return;

    await add(level!);

    cam = AppCameraComponent(world: level);
    final bounds = Rectangle.fromLTWH(0, 0, level!.worldWidth, level!.worldHeight);
    cam?.setBounds(bounds);
    final initialPosition = Vector2(984, 7100);
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
  void placeBuilding(Building type) async {
    Coordinates centerOfTheWorld = getVisibleWorldCenter();
    BuildingInfo? buildingInfo = await level?.placeBuilding(type, centerOfTheWorld);

    if (buildingInfo != null) {
      buildingBloc.add(InitBuildingEvent(buildingInfo: buildingInfo));
      return;
    }

    for (int i = 0; i < 20; i++) {
      centerOfTheWorld = Coordinates(
        x: centerOfTheWorld.x + (i % 2 == 0 ? 256 : 128),
        y: centerOfTheWorld.y + (i % 2 == 0 ? 64 : 128),
      );

      BuildingInfo? buildingInfo = await level?.placeBuilding(type, centerOfTheWorld);

      if (buildingInfo != null) {
        buildingBloc.add(InitBuildingEvent(buildingInfo: buildingInfo));
        return;
      }
    }
  }

  // Calculate the center of the visible world
  Coordinates getVisibleWorldCenter() {
    final centerX = cam!.viewfinder.position.x;
    final centerY = cam!.viewfinder.position.y;
    return Coordinates(x: centerX, y: centerY);
  }

  @override
  void removeBuildingById(int id) => level?.removeBuildingById(id);

  @override
  Future<Vector2>? buildBuildingById(int id) => level?.buildBuildingById(id);
}
