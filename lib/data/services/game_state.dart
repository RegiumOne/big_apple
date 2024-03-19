import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.initBuildings(
    GameStatistic gameStatistic,
    List<BuildingEntity> buildinds,
  ) = _GameInitBuildingsState;

  const factory GameState.updateStat(
    GameStatistic gameStatistic,
    List<BuildingEntity> buildinds,
  ) = _GameUpdateStatState;

  const factory GameState.onNewLevel(
    GameStatistic gameStatistic,
    List<BuildingEntity> buildinds,
    int newLevel,
  ) = _GameOnNewLevelState;

  factory GameState.initial() => GameState.initBuildings(
        GameStatistic.initial(),
        [],
      );
}
