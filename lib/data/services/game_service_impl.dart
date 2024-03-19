import 'package:big_apple/data/services/game_state.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:big_apple/domain/services/economicy_service.dart';
import 'package:big_apple/domain/services/game_service.dart';
import 'package:big_apple/domain/services/storage_service.dart';
import 'package:rxdart/rxdart.dart';

class GameServiceImpl extends DatabaseService with EconomicyService implements GameService {
  GameServiceImpl({required super.database});

  @override
  BehaviorSubject<GameState> get state => gameState;

  @override
  Future<void> init() async {
    final (GameStatistic gameStat, List<BuildingEntity> buildings) = await loadGame();
    await initializeEconomic(gameStat, buildings);
  }

  @override
  Future<void> build(BuildingEntity building) async {
    await super.build(building);
    await saveBuilding(building);
    await saveGameStat(state.value.gameStatistic);
  }

  @override
  Future<void> updateLocation(int buildingId, double x, double y) async {
    await super.updateLocation(buildingId, x, y);
    await saveNewBuildingLocation(buildingId, x, y);
  }

  @override
  Future<void> upgrade() async {}
}
