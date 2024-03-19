import 'package:big_apple/data/datasources/local/database/app_database.dart';
import 'package:big_apple/data/datasources/local/database/building_dto.dart';
import 'package:big_apple/data/datasources/local/database/game_stat_dto.dart';
import 'package:big_apple/data/datasources/local/database/resources_dto.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:drift/drift.dart';

abstract class DatabaseService {
  DatabaseService({required this.database});

  AppDatabase database;
  
  Future<(GameStatistic, List<BuildingEntity>)> loadGame() async {
    GameStatDtoData? gameStatDtoData = await database.select(database.gameStatDto).getSingleOrNull();

    GameStatistic gameStat = gameStatDtoData?.toEntity() ?? GameStatistic.initial();

    if (gameStatDtoData == null) {
      await database.into(database.gameStatDto).insert(
            GameStatDtoCompanion.insert(
              gold: gameStat.gold,
              maxGold: gameStat.maxGold,
              coal: gameStat.coal,
              maxCoal: gameStat.maxCoal,
              iron: gameStat.iron,
              maxIron: gameStat.maxIron,
              electricity: gameStat.electricity,
              ecologyLevel: gameStat.ecologyLevel,
              peoples: gameStat.peoples,
              builders: gameStat.builders,
              maxBuilders: gameStat.maxBuilders,
              clover: gameStat.builders,
              updatedAt: DateTime.now(),
            ),
          );
    }

    List<BuildingDtoData> buildings = await database.select(database.buildingDto).get();

    return (gameStat, buildings.toEntity());
  }

  Future<void> saveBuilding(BuildingEntity building) async {
    await database.transaction(() async {
      await database.into(database.buildingDto).insert(
            BuildingDtoCompanion.insert(
              id: building.id,
              level: building.level,
              x: building.x,
              y: building.y,
              resource: ResourceDto(
                peoples: 0,
                gold: 0,
                updatedAt: DateTime.now(),
              ),
              buildingType: building.type,
            ),
          );
    });
  }

  Future<void> saveNewBuildingLocation(int buildingId, double x, double y) async {
    await (database.update(database.buildingDto)..where((t) => t.id.equals(buildingId))).write(
      BuildingDtoCompanion(
        x: Value(x),
        y: Value(y),
      ),
    );
  }

  Future<void> saveGameStat(GameStatistic gameStat) async {
    await (database.update(database.gameStatDto)).write(
      GameStatDtoCompanion(
        gold: Value(gameStat.gold),
        maxGold: Value(gameStat.maxGold),
        coal: Value(gameStat.coal),
        maxCoal: Value(gameStat.maxCoal),
        iron: Value(gameStat.iron),
        maxIron: Value(gameStat.maxIron),
        electricity: Value(gameStat.electricity),
        ecologyLevel: Value(gameStat.ecologyLevel),
        peoples: Value(gameStat.peoples),
        builders: Value(gameStat.builders),
        maxBuilders: Value(gameStat.maxBuilders),
        clover: Value(gameStat.clover),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
