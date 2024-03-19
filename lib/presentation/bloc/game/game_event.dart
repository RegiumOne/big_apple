part of 'game_bloc.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.updateStat(GameStat gameStat) = _GameUpdateStatEvent;
  const factory GameEvent.selectBuilding(BuildingEntity building) = _GameSelectBuildingEvent;
  const factory GameEvent.hideBuilding() = _GameHideBuildingEvent;
}
