import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';

part 'game_hud_event.dart';
part 'game_hud_state.dart';
part 'game_hud_bloc.freezed.dart';

@Injectable()
class GameHudBloc extends Bloc<GameHudEvent, GameHudState> {
  GameHudBloc() : super(GameHudState.initial()) {
    on<GameHudEvent>(
      (event, emit) {
        event.when(
          updateStatistic: (gameStat) => _updateStatHandle(gameStat, emit),
          selectBuilding: (gameStat) => _selectBuildingState(gameStat, emit),
          hideBuilding: () => _selectBuildingState(null, emit),
          newLevel: () => _showNewLevel(emit),
        );
      },
    );
  }

  void _updateStatHandle(
    GameStatistic gameStat,
    Emitter<GameHudState> emit,
  ) {
    emit(
      GameHudState(
        gameStat: gameStat,
        selectedBuilding: state.selectedBuilding,
        showNewLevel: false,
      ),
    );
  }

  void _selectBuildingState(
    BuildingEntity? building,
    Emitter<GameHudState> emit,
  ) {
    emit(
      GameHudState(
        gameStat: state.gameStat,
        selectedBuilding: building,
        showNewLevel: false,
      ),
    );
  }

  void _showNewLevel(
    Emitter<GameHudState> emit,
  ) {
    emit(
      GameHudState(
        gameStat: state.gameStat,
        selectedBuilding: null,
        showNewLevel: true,
      ),
    );
  }
}
