part of 'game_bloc.dart';

abstract class GameEvent {
  const GameEvent();
}

class GameIncreaseMoneyEvent extends GameEvent {
  const GameIncreaseMoneyEvent(this.money);

  final double money;
}

class GameAddBuildingEvent extends GameEvent {
  const GameAddBuildingEvent(this.building);

  final Building building;
}

class GameSaveEvent extends GameEvent {
  const GameSaveEvent();
}

class GameLoadEvent extends GameEvent {
  const GameLoadEvent();
}
