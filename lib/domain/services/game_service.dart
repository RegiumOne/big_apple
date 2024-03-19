import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class GameService {
  BehaviorSubject<GameStat> get gameState;
  BehaviorSubject<List<BuildingEntity>> get buildingsState;

  Future<void> init();
}
