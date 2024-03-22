import 'package:flame/events.dart';

import 'package:big_apple/common/components/building/building_component.dart';
import 'package:big_apple/common/components/building/draggable_building_component.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';

class TappableBuildingComponent extends BuildingComponent with TapCallbacks {
  TappableBuildingComponent({
    required super.building,
    super.markAsBuild = false,
  });

  bool _isBuildingSelected = false;

  @override
  void onLongTapDown(TapDownEvent event) {
    super.onLongTapDown(event);
    if (isUnderConstruction || globalDraggableBuildingComponent != null) return;
    if (_isBuildingSelected) {
      game.gameBloc.add(const GameHudEvent.hideBuilding());
    }

    world.remove(this);
    world.add(DraggableBuildingComponent(building: building));
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (isUnderConstruction) return;
    _isBuildingSelected = true;
    game.gameBloc.add(GameHudEvent.selectBuilding(building));
    AudioService.instance.playSound(AudioFile.mouseClick);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO(Sasha071201): collect resources when you need
    collectResources();
    super.onTapDown(event);
  }
}
