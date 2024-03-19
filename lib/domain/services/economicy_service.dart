import 'dart:async';

import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/data/services/game_state.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:big_apple/domain/services/building_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin EconomicyService implements BuildingService {
  bool isEconomicServiceInitialized = false;
  // ignore: unused_field
  Timer? _economyTimer;

  @protected
  final BehaviorSubject<GameState> gameState = BehaviorSubject<GameState>.seeded(GameState.initial());

  List<BuildingEntity> _buildings = [];

  @protected
  Future<void> initializeEconomic(GameStatistic stat, List<BuildingEntity> buildings) async {
    if (isEconomicServiceInitialized) {
      return Future.value();
    }
    isEconomicServiceInitialized = true;
    _buildings = buildings;

    gameState.add(GameState.initBuildings(stat, buildings));

    _economyTimer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateResources());

    return Future.value();
  }

  void _updateResources() {
    GameStatistic currentGameStat = gameState.value.gameStatistic;

    int activeBuilder = 0;

    for (BuildingEntity building in _buildings) {
      if (building.constructionTimeLeft > 0) {
        activeBuilder--;
      }
    }

    gameState.add(
      GameState.updateStat(
        currentGameStat.copyWith(builders: currentGameStat.maxBuilders - activeBuilder),
        _buildings,
      ),
    );
  }

  @mustCallSuper
  @override
  Future<void> build(BuildingEntity building) async {
    _buildings.add(building);

    GameStatistic currentGameStat = gameState.value.gameStatistic;

    Map<ResourceType, int> price = building.type.getBuildPrice();
    Map<PassiveBenefit, int> passiveBenefits = building.type.getPassiveBenefitsByLevel(building.level);
    Map<PassiveDisadvantage, int> passiveDisadvantages = building.type.getPassiveDisadvantagesByLevel(building.level);

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

    for (PassiveBenefit passiveBenefit in passiveBenefits.keys) {
      if (passiveBenefit == PassiveBenefit.electricityPts) {
        currentGameStat = currentGameStat.copyWith(
          electricity: currentGameStat.electricity + passiveBenefits[passiveBenefit]!,
        );
      } else if (passiveBenefit == PassiveBenefit.populationCapacity) {
        currentGameStat = currentGameStat.copyWith(
          peoples: currentGameStat.peoples + passiveBenefits[passiveBenefit]!,
        );
      }
    }

    for (PassiveDisadvantage passiveDisadvantage in passiveDisadvantages.keys) {
      if (passiveDisadvantage == PassiveDisadvantage.electricityPts) {
        currentGameStat = currentGameStat.copyWith(
          electricity: currentGameStat.electricity - passiveDisadvantages[passiveDisadvantage]!,
        );
      } else if (passiveDisadvantage == PassiveDisadvantage.freeWorkers) {
        currentGameStat = currentGameStat.copyWith(
          peoples: currentGameStat.peoples - passiveDisadvantages[passiveDisadvantage]!,
        );
      }
    }

    double nextLevel = currentGameStat.ecologyLevel + (building.level / (5 / currentGameStat.ecologyLevel) + 0.01);

    bool isLevelUp = nextLevel.floor() > currentGameStat.ecologyLevel.floor();

    currentGameStat = currentGameStat.copyWith(
      builders: currentGameStat.builders - 1,
      ecologyLevel: nextLevel,
    );

    gameState.add(GameState.updateStat(currentGameStat, gameState.value.buildinds));

    if (isLevelUp) {
      gameState.add(
        GameState.onNewLevel(
          gameState.value.gameStatistic,
          gameState.value.buildinds,
          nextLevel.floor(),
        ),
      );
    }
  }

  @mustCallSuper
  @override
  Future<void> updateLocation(int buildingId, double x, double y) async {
    _buildings = _buildings.map((building) {
      if (building.id == buildingId) {
        return building.copyWith(x: x, y: y);
      }
      return building;
    }).toList();
  }
}
