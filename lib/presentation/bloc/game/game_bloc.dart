import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';

part 'game_event.dart';
part 'game_state.dart';
part 'game_bloc.freezed.dart';

@Injectable()
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<GameEvent>(
      (event, emit) {
        event.when(
          updateStat: (gameStat) => _updateStatHandle(gameStat, emit),
          selectBuilding: (gameStat) => _selectBuildingState(gameStat, emit),
          hideBuilding: () => _selectBuildingState(null, emit),
        );
      },
    );
  }

  void _updateStatHandle(
    GameStat gameStat,
    Emitter<GameState> emit,
  ) {
    emit(
      GameState(
        gameStat: gameStat,
        selectedBuilding: state.selectedBuilding,
      ),
    );
  }

  void _selectBuildingState(
    BuildingEntity? building,
    Emitter<GameState> emit,
  ) {
    emit(
      GameState(
        gameStat: state.gameStat,
        selectedBuilding: building,
      ),
    );
  }
}
