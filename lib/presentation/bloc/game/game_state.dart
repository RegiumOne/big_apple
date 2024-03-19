part of 'game_bloc.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required GameStat gameStat,
    required BuildingEntity? selectedBuilding,
  }) = _GameState;

  factory GameState.initial() => GameState(
        gameStat: GameStat.empty(),
        selectedBuilding: null,
      );
}
