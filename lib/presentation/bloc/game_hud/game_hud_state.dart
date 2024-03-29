part of 'game_hud_bloc.dart';

@freezed
class GameHudState with _$GameHudState {
  const factory GameHudState({
    required GameStatistic gameStat,
    required BuildingEntity? selectedBuilding,
    required bool showNewLevel,
  }) = _GameHudState;

  factory GameHudState.initial() => GameHudState(
        gameStat: GameStatistic.empty(),
        selectedBuilding: null,
        showNewLevel: false,
      );
}
