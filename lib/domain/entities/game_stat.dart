import 'package:big_apple/data/datasources/local/database/app_database.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/datasources/local/database/resources_dto.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/domain/entities/building_entity.dart';

class GameStatistic {
  GameStatistic({
    this.id = -1,
    this.gold = 500,
    this.maxGold = 1000,
    this.coal = 0,
    this.maxCoal = 100,
    this.iron = 50,
    this.maxIron = 100,
    this.maxBuilders = 2,
    this.electricity = 15,
    this.ecologyLevel = 1,
    this.peoples = 0,
    this.builders = 2,
    this.clover = 50,
  });

  factory GameStatistic.initial() => GameStatistic();

  factory GameStatistic.empty() => GameStatistic(
        id: -1,
        gold: 0,
        maxGold: 0,
        coal: 0,
        maxCoal: 0,
        iron: 0,
        maxIron: 0,
        maxBuilders: 0,
        electricity: 0,
        ecologyLevel: 0,
        peoples: 0,
        builders: 0,
        clover: 0,
      );

  GameStatistic copyWith({
    double? maxGold,
    double? gold,
    double? coal,
    double? maxCoal,
    double? iron,
    double? maxIron,
    int? electricity,
    double? ecologyLevel,
    int? peoples,
    int? builders,
    int? maxBuilders,
    int? clover,
  }) {
    return GameStatistic(
      maxGold: maxGold ?? this.maxGold,
      gold: gold ?? this.gold,
      coal: coal ?? this.coal,
      maxCoal: maxCoal ?? this.maxCoal,
      iron: iron ?? this.iron,
      maxIron: maxIron ?? this.maxIron,
      electricity: electricity ?? this.electricity,
      ecologyLevel: ecologyLevel ?? this.ecologyLevel,
      peoples: peoples ?? this.peoples,
      builders: builders ?? this.builders,
      maxBuilders: maxBuilders ?? this.maxBuilders,
      clover: clover ?? this.clover,
    );
  }

  final int id;
  final double maxGold;
  final double gold;
  final double coal;
  final double maxCoal;
  final double iron;
  final double maxIron;
  final int electricity;
  final double ecologyLevel;
  final int peoples;
  final int builders;
  final int maxBuilders;
  final int clover;

  bool canBeBuilt(BuildingType type, int level) {
    Map<ResourceType, int> price = type.getPriceByLevel(level);

    bool enoughtResources = price.entries.every((entry) {
      if (entry.key == ResourceType.gold) {
        return gold >= entry.value;
      } else if (entry.key == ResourceType.coal) {
        return coal >= entry.value;
      } else if (entry.key == ResourceType.iron) {
        return iron >= entry.value;
      }
      return false;
    });

    return builders > 0 && level < 4 && enoughtResources;
  }
}

extension BuildingsListX on List<BuildingEntity> {
  List<BuildingDtoData> toDto() => map(
        (e) => BuildingDtoData(
          id: e.id,
          level: e.level,
          x: e.x,
          y: e.y,
          resource: ResourceDto(
            peoples: 0,
            gold: 0,
            updatedAt: DateTime.now(),
          ),
          buildingType: e.type,
        ),
      ).toList();
}
