part of 'game_bloc.dart';

abstract class GameState {
  const GameState({
    required this.money,
    required this.buildings,
    required this.builders,
    required this.lastSaveDateTime,
  });

  final double money;
  final List<Building> buildings;
  final List<Builder> builders;
  final DateTime? lastSaveDateTime;

  List<Builder> get availableBuilders => builders.where((builder) => !builder.isBusy).toList();
}

class GameInitialState extends GameState {
  const GameInitialState({
    super.money = 0,
    super.buildings = const [],
    super.builders = const [],
    super.lastSaveDateTime,
  });
}

class GameIdleState extends GameState {
  const GameIdleState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
  });
}

class GameSavingState extends GameState {
  const GameSavingState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
  });
}

class GameLoadingState extends GameState {
  const GameLoadingState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
  });
}

class GameLoadedState extends GameState {
  const GameLoadedState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
  });
}

class GameFailureState extends GameState {
  const GameFailureState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
  });
}
