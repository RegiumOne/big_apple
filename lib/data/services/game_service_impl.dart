import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:big_apple/domain/services/building_service.dart';
import 'package:big_apple/domain/services/game_service.dart';
import 'package:big_apple/domain/services/storage_service.dart';
import 'package:rxdart/rxdart.dart';

class GameServiceImpl extends DatabaseService implements GameService, BuildingService {
  GameServiceImpl({
    required super.database,
  });

  final BehaviorSubject<GameStat> _gameState = BehaviorSubject<GameStat>.seeded(GameStat.initial());

  final BehaviorSubject<List<BuildingEntity>> _buildingsState = BehaviorSubject<List<BuildingEntity>>.seeded([]);

  List<BuildingEntity> _buildings = [];

  @override
  BehaviorSubject<GameStat> get gameState => _gameState;

  @override
  BehaviorSubject<List<BuildingEntity>> get buildingsState => _buildingsState;

  @override
  Future<void> init() async {
    final (GameStat gameStat, List<BuildingEntity> buildings) = await loadGame();

    _gameState.add(gameStat);
    _buildingsState.add(buildings);
    _buildings.addAll(buildings);
  }

  @override
  Future<void> build(BuildingEntity building) async {
    await insertBuildingToDB(building);
    _buildings.add(building);

    Map<ResourceType, int> price = building.type.getBuildPrice();

    GameStat currentGameStat = _gameState.value;

    for (ResourceType resourceType in price.keys) {
      if (resourceType == ResourceType.gold) {
        currentGameStat = currentGameStat.copyWith(
          gold: currentGameStat.gold - price[resourceType]!,
        );
      } else if (resourceType == ResourceType.coal) {
        currentGameStat = currentGameStat.copyWith(
          coal: currentGameStat.coal - price[resourceType]!,
        );
      } else if (resourceType == ResourceType.iron) {
        currentGameStat = currentGameStat.copyWith(
          iron: currentGameStat.iron - price[resourceType]!,
        );
      }
    }

    currentGameStat = currentGameStat.copyWith(
      builders: currentGameStat.builders - 1,
      ecologyLevel: currentGameStat.ecologyLevel + (building.level / (5 / currentGameStat.ecologyLevel) + 0.05),
    );

    _gameState.add(currentGameStat);

    updateGameStat(currentGameStat);
  }

  @override
  Future<void> updateLocation(int buildingId, double x, double y) async {
    await updateBuildingLocation(buildingId, x, y);
    _buildings = _buildings.map((building) {
      if (building.id == buildingId) {
        return building.copyWith(x: x, y: y);
      }
      return building;
    }).toList();
  }

  @override
  Future<void> upgrade() async {}
}
