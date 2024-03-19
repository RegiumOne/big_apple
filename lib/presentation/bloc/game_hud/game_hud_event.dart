part of 'game_hud_bloc.dart';

@freezed
class GameHudEvent with _$GameHudEvent {
  const factory GameHudEvent.updateStatistic(GameStatistic gameStat) = _GameHudUpdateStatEvent;
  const factory GameHudEvent.selectBuilding(BuildingEntity building) = _GameHudSelectBuildingEvent;
  const factory GameHudEvent.hideBuilding() = _GameHudHideBuildingEvent;
  const factory GameHudEvent.newLevel() = _GameHudNewLevelEvent;
}
