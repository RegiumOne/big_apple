part of 'game_bloc.dart';

abstract class GameState {
  const GameState({
    required this.money,
    required this.buildings,
    required this.builders,
    required this.lastSaveDateTime,
    required this.selectedBuilding,
  });

  final double money;
  final List<BuildingInfo> buildings;
  final List<Builder> builders;
  final DateTime? lastSaveDateTime;
  final BuildingInfo? selectedBuilding;

  List<Builder> get availableBuilders => builders.where((builder) => !builder.isBusy).toList();
  Map<ResourceType, int> get availableResources => {
        ResourceType.coin: money.toInt(),
      };
}

class GameInitialState extends GameState {
  const GameInitialState({
    super.money = 0,
    super.buildings = const [],
    super.builders = const [],
    super.lastSaveDateTime,
    super.selectedBuilding,
  });
}

class GameIdleState extends GameState {
  const GameIdleState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
    required super.selectedBuilding,
  });
}

class GameSavingState extends GameState {
  const GameSavingState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
    required super.selectedBuilding,
  });
}

class GameLoadingState extends GameState {
  const GameLoadingState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
    required super.selectedBuilding,
  });
}

class GameLoadedState extends GameState {
  const GameLoadedState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
    required super.selectedBuilding,
  });
}

class GameFailureState extends GameState {
  const GameFailureState({
    required super.money,
    required super.buildings,
    required super.builders,
    required super.lastSaveDateTime,
    required super.selectedBuilding,
  });
}
