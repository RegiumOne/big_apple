import 'package:big_apple/data/models/building.dart';
import 'package:big_apple/data/repositories/game_repository.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

part 'game_event.dart';
part 'game_state.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this._gameRepository) : super(const GameInitialState()) {
    on<GameIncreaseMoneyEvent>(
      _increaseMoney,
    );
    on<GameAddBuildingEvent>(
      _addBuilding,
    );
    on<GameSaveEvent>(
      _save,
      transformer: restartable(),
    );
    on<GameLoadEvent>(
      _load,
      transformer: restartable(),
    );
  }

  final GameRepository _gameRepository;

  void _increaseMoney(
    GameIncreaseMoneyEvent event,
    Emitter<GameState> emit,
  ) async {
    emit(
      GameIdleState(
        money: state.money + event.money,
        buildings: state.buildings,
        lastSaveDateTime: state.lastSaveDateTime,
      ),
    );
  }

  void _addBuilding(
    GameAddBuildingEvent event,
    Emitter<GameState> emit,
  ) async {
    final money = state.money - event.building.type.cost;
    if (money < 0) return;

    emit(
      GameIdleState(
        money: money,
        buildings: [...state.buildings, event.building],
        lastSaveDateTime: state.lastSaveDateTime,
      ),
    );
    add(const GameSaveEvent());
  }

  void _save(
    GameSaveEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      emit(
        GameSavingState(
          money: state.money,
          buildings: state.buildings,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );

      final lastSaveDateTime = DateTime.now();

      await Future.wait([
        _gameRepository.setMoney(state.money),
        _gameRepository.setBuildings(state.buildings),
        _gameRepository.setLastSaveDateTime(lastSaveDateTime),
      ]);
      emit(
        GameIdleState(
          money: state.money,
          buildings: state.buildings,
          lastSaveDateTime: lastSaveDateTime,
        ),
      );
    } catch (e) {
      emit(
        GameFailureState(
          money: state.money,
          buildings: state.buildings,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );
    }
  }

  void _load(
    GameLoadEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      emit(
        GameLoadingState(
          money: state.money,
          buildings: state.buildings,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );

      double money = _gameRepository.getMoney();
      final buildings = _gameRepository.getBuildings();
      final lastSaveDateTime = _gameRepository.getLastSaveDateTime();

      final now = DateTime.now();
      final differenceInSeconds = lastSaveDateTime == null ? 0 : now.difference(lastSaveDateTime).inSeconds;
      final intervals = (differenceInSeconds / AppDuration.buildingIncomeIntervalInSeconds).floor();

      for (var building in buildings) {
        final collectedMoney = building.type.moneyPerUnitOfTime * intervals;
        money += collectedMoney;
      }

      emit(
        GameLoadedState(
          money: money,
          buildings: buildings,
          lastSaveDateTime: lastSaveDateTime,
        ),
      );
    } catch (e) {
      emit(
        GameFailureState(
          money: state.money,
          buildings: state.buildings,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );
    }
  }
}
