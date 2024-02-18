import 'package:big_apple/data/dto/builder.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/domain/repositories/game_repository.dart';
import 'package:big_apple/resources/values/app_duration.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

part 'game_event.dart';
part 'game_state.dart';

@Injectable()
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this._gameRepository) : super(const GameInitialState()) {
    on<GameIncreaseMoneyEvent>(_increaseMoney);
    on<GameAddBuildingEvent>(_addBuilding);
    on<GameFinishBuildingEvent>(_finishBuilding);
    on<GameSaveEvent>(_save, transformer: restartable());
    on<GameLoadEvent>(_load, transformer: restartable());
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
        builders: state.builders,
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

    final builderIndex = state.builders.indexWhere((builder) => !builder.isBusy);
    if (builderIndex == -1) return;
    final updatedBuilders = state.builders.mapIndexed((index, builder) {
      if (index == builderIndex) {
        return builder.copyWith(isBusy: true);
      }
      return builder;
    }).toList();

    emit(
      GameIdleState(
        money: money,
        buildings: [...state.buildings, event.building],
        builders: updatedBuilders,
        lastSaveDateTime: state.lastSaveDateTime,
      ),
    );
    add(const GameSaveEvent());
  }

  void _finishBuilding(
    GameFinishBuildingEvent event,
    Emitter<GameState> emit,
  ) async {
    final updatedBuildings = state.buildings.map((building) {
      if (building.coordinates == event.building.coordinates) {
        return event.building;
      }
      return building;
    }).toList();

    final builderIndex = state.builders.indexWhere((builder) => builder.isBusy);
    final updatedBuilders = state.builders.mapIndexed((index, builder) {
      if (index == builderIndex) {
        return builder.copyWith(isBusy: false);
      }
      return builder;
    }).toList();

    emit(
      GameIdleState(
        money: state.money,
        buildings: updatedBuildings,
        builders: updatedBuilders,
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
          builders: state.builders,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );

      final lastSaveDateTime = DateTime.now();

      await Future.wait([
        _gameRepository.setMoney(state.money),
        _gameRepository.setBuildings(state.buildings),
        _gameRepository.setLastSaveDateTime(lastSaveDateTime),
        _gameRepository.setBuilders(state.builders),
      ]);
      emit(
        GameIdleState(
          money: state.money,
          buildings: state.buildings,
          builders: state.builders,
          lastSaveDateTime: lastSaveDateTime,
        ),
      );
    } catch (e) {
      emit(
        GameFailureState(
          money: state.money,
          buildings: state.buildings,
          builders: state.builders,
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
          builders: state.builders,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );

      double money = _gameRepository.getMoney();
      final buildings = _gameRepository.getBuildings();
      final lastSaveDateTime = _gameRepository.getLastSaveDateTime();
      final builders = _gameRepository.getBuilders();

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
          builders: builders,
          lastSaveDateTime: lastSaveDateTime,
        ),
      );
    } catch (e) {
      emit(
        GameFailureState(
          money: state.money,
          buildings: state.buildings,
          builders: state.builders,
          lastSaveDateTime: state.lastSaveDateTime,
        ),
      );
    }
  }
}
