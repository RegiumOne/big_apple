import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum BuildingType {
  house, // 1x1 appartment
  apartment, // 2x1 appartment
  skyscraper, // 2x2 appartment

  store, // 1x1 commercial
  market, // 2x1 commercial
  cityMall, // 2x2 commercial

  coalElectricStation, // 2x2 manufactory
  atomicElectricityStation, // 2x2 manufactory
  windElectricityStation, // 1x1 manufactory

  road; // 1x1 road
}

enum BuildingCategory {
  apartments,
  commercial,
  manufactory,
  road;

  int get maxLevel => 3;

  static BuildingCategory getCategoryFromBuildingType(BuildingType buildingType) {
    switch (buildingType) {
      case BuildingType.house:
      case BuildingType.apartment:
      case BuildingType.skyscraper:
        return apartments;
      case BuildingType.store:
      case BuildingType.market:
      case BuildingType.cityMall:
        return commercial;
      case BuildingType.coalElectricStation:
      case BuildingType.atomicElectricityStation:
      case BuildingType.windElectricityStation:
        return manufactory;
      case BuildingType.road:
        return road;
    }
  }

  static List<BuildingType> getBuildings(BuildingCategory category) {
    switch (category) {
      case BuildingCategory.apartments:
        return [
          BuildingType.house,
          BuildingType.apartment,
          BuildingType.skyscraper,
        ];
      case BuildingCategory.commercial:
        return [
          BuildingType.store,
          BuildingType.market,
          BuildingType.cityMall,
        ];
      case BuildingCategory.manufactory:
        return [
          BuildingType.coalElectricStation,
          BuildingType.atomicElectricityStation,
          BuildingType.windElectricityStation,
        ];
      case BuildingCategory.road:
        return [
          BuildingType.road,
        ];
    }
  }
}

extension BuildingTypeX on BuildingType {
  String get name {
    switch (this) {
      case BuildingType.house:
        return 'House';
      case BuildingType.apartment:
        return 'Apartment';
      case BuildingType.skyscraper:
        return 'Skyscraper';
      case BuildingType.store:
        return 'Store';
      case BuildingType.market:
        return 'Market';
      case BuildingType.cityMall:
        return 'City Mall';
      case BuildingType.coalElectricStation:
        return 'Coal Electric Station';
      case BuildingType.atomicElectricityStation:
        return 'Atomic Electricity Station';
      case BuildingType.windElectricityStation:
        return 'Wind Electricity Station';
      case BuildingType.road:
        return 'Road';
    }
  }

  String imageInitial({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.house:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.apartment:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case BuildingType.skyscraper:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.store:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.market:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case BuildingType.cityMall:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.coalElectricStation:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.atomicElectricityStation:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.windElectricityStation:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  String imageHalf({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.house:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.apartment:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case BuildingType.skyscraper:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.store:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.market:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case BuildingType.cityMall:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.coalElectricStation:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.atomicElectricityStation:
        path = Assets.images.initialBuilding2x2.path;
        break;
      case BuildingType.windElectricityStation:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case BuildingType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.house:
        path = Assets.images.houseLvl1.path;
        break;
      case BuildingType.apartment:
        path = Assets.images.apartmentLvl1.path;
        break;
      case BuildingType.skyscraper:
        path = Assets.images.scyscraperLvl1.path;
        break;
      case BuildingType.store:
        path = Assets.images.shopLvl1.path;
        break;
      case BuildingType.market:
        path = Assets.images.marketLvl1.path;
        break;
      case BuildingType.cityMall:
        path = Assets.images.mallLvl1.path;
        break;
      case BuildingType.coalElectricStation:
        path = Assets.images.coalLvl1.path;
        break;
      case BuildingType.atomicElectricityStation:
        path = Assets.images.atomLvl1.path;
        break;
      case BuildingType.windElectricityStation:
        path = Assets.images.electricityLvl1.path;
        break;
      case BuildingType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  Map<RequirementType, int> getRequirementsByLevel(int level) {
    Map<int, Map<RequirementType, int>> requirements = {};

    switch (this) {
      case BuildingType.coalElectricStation:
      case BuildingType.house:
      case BuildingType.store:
      case BuildingType.road:
        requirements = {
          1: {RequirementType.ecologyLvl: 1},
          2: {RequirementType.ecologyLvl: 1},
          3: {RequirementType.ecologyLvl: 1},
        };
        break;

      case BuildingType.atomicElectricityStation:
      case BuildingType.apartment:
      case BuildingType.market:
        requirements = {
          1: {RequirementType.ecologyLvl: 5},
          2: {RequirementType.ecologyLvl: 5},
          3: {RequirementType.ecologyLvl: 5},
        };
        break;

      case BuildingType.windElectricityStation:
      case BuildingType.skyscraper:
      case BuildingType.cityMall:
        requirements = {
          1: {RequirementType.ecologyLvl: 10},
          2: {RequirementType.ecologyLvl: 10},
          3: {RequirementType.ecologyLvl: 10},
        };
        break;
    }

    return requirements[level] ?? {};
  }

  Map<PassiveBenefit, int> getPassiveBenefitsByLevel(int level) {
    Map<int, Map<PassiveBenefit, int>> benefits = {};

    switch (this) {
      case BuildingType.house:
        benefits = {
          1: {PassiveBenefit.populationCapacity: 5},
          2: {PassiveBenefit.populationCapacity: 10},
          3: {PassiveBenefit.populationCapacity: 15},
        };
        break;
      case BuildingType.apartment:
        benefits = {
          1: {PassiveBenefit.populationCapacity: 25},
          2: {PassiveBenefit.populationCapacity: 50},
          3: {PassiveBenefit.populationCapacity: 75},
        };
        break;
      case BuildingType.skyscraper:
        benefits = {
          1: {PassiveBenefit.populationCapacity: 100},
          2: {PassiveBenefit.populationCapacity: 200},
          3: {PassiveBenefit.populationCapacity: 300},
        };
        break;

      case BuildingType.store:
        benefits = {
          1: {PassiveBenefit.peopleMaxCapacity: 2},
          2: {PassiveBenefit.peopleMaxCapacity: 4},
          3: {PassiveBenefit.peopleMaxCapacity: 6},
        };
        break;
      case BuildingType.market:
        benefits = {
          1: {PassiveBenefit.peopleMaxCapacity: 15},
          2: {PassiveBenefit.peopleMaxCapacity: 20},
          3: {PassiveBenefit.peopleMaxCapacity: 25},
        };
        break;
      case BuildingType.cityMall:
        benefits = {
          1: {PassiveBenefit.peopleMaxCapacity: 30},
          2: {PassiveBenefit.peopleMaxCapacity: 45},
          3: {PassiveBenefit.peopleMaxCapacity: 60},
        };
        break;

      case BuildingType.coalElectricStation:
        benefits = {
          1: {PassiveBenefit.electricityPts: 5},
          2: {PassiveBenefit.electricityPts: 10},
          3: {PassiveBenefit.electricityPts: 15},
        };
        break;
      case BuildingType.atomicElectricityStation:
        benefits = {
          1: {PassiveBenefit.electricityPts: 30},
          2: {PassiveBenefit.electricityPts: 40},
          3: {PassiveBenefit.electricityPts: 50},
        };
        break;
      case BuildingType.windElectricityStation:
        benefits = {
          1: {PassiveBenefit.electricityPts: 5},
          2: {PassiveBenefit.electricityPts: 10},
          3: {PassiveBenefit.electricityPts: 15},
        };
        break;

      case BuildingType.road:
        break;
    }

    return benefits[level] ?? {};
  }

  Map<PassiveDisadvantage, int> getPassiveDisadvantagesByLevel(int level) {
    Map<int, Map<PassiveDisadvantage, int>> disadvantages = {};

    switch (this) {
      case BuildingType.house:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 1},
          2: {PassiveDisadvantage.electricityPts: 2},
          3: {PassiveDisadvantage.electricityPts: 3},
        };
        break;
      case BuildingType.apartment:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 5},
          2: {PassiveDisadvantage.electricityPts: 10},
          3: {PassiveDisadvantage.electricityPts: 15},
        };
        break;
      case BuildingType.skyscraper:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 10},
          2: {PassiveDisadvantage.electricityPts: 25},
          3: {PassiveDisadvantage.electricityPts: 50},
        };
        break;

      case BuildingType.store:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 2},
          2: {PassiveDisadvantage.electricityPts: 4},
          3: {PassiveDisadvantage.electricityPts: 6},
        };
        break;
      case BuildingType.market:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 15},
          2: {PassiveDisadvantage.electricityPts: 20},
          3: {PassiveDisadvantage.electricityPts: 25},
        };
        break;
      case BuildingType.cityMall:
        disadvantages = {
          1: {PassiveDisadvantage.electricityPts: 30},
          2: {PassiveDisadvantage.electricityPts: 45},
          3: {PassiveDisadvantage.electricityPts: 60},
        };
        break;

      case BuildingType.coalElectricStation:
        disadvantages = {
          1: {PassiveDisadvantage.freeWorkers: 5},
          2: {PassiveDisadvantage.freeWorkers: 5},
          3: {PassiveDisadvantage.freeWorkers: 5},
        };
        break;
      case BuildingType.atomicElectricityStation:
        disadvantages = {
          1: {PassiveDisadvantage.freeWorkers: 15},
          2: {PassiveDisadvantage.freeWorkers: 15},
          3: {PassiveDisadvantage.freeWorkers: 15},
        };
        break;
      case BuildingType.windElectricityStation:
        disadvantages = {
          1: {PassiveDisadvantage.freeWorkers: 1},
          2: {PassiveDisadvantage.freeWorkers: 1},
          3: {PassiveDisadvantage.freeWorkers: 1},
        };
        break;

      case BuildingType.road:
        break;
    }

    return disadvantages[level] ?? {};
  }

  int getBuildingDurationInSecondsByLevel(int level) {
    Map<int, int> requirements = {};

    switch (this) {
      case BuildingType.coalElectricStation:
      case BuildingType.house:
      case BuildingType.store:
      case BuildingType.road:
        requirements = {
          1: 10,
          2: 60 * 10,
          3: 60 * 30,
        };
        break;

      case BuildingType.atomicElectricityStation:
      case BuildingType.apartment:
      case BuildingType.market:
        requirements = {
          1: 60 * 30,
          2: 60 * 60,
          3: 60 * 60 * 4,
        };
        break;

      case BuildingType.windElectricityStation:
      case BuildingType.skyscraper:
      case BuildingType.cityMall:
        requirements = {
          1: 60 * 60 * 4,
          2: 60 * 60 * 8,
          3: 60 * 60 * 12,
        };
        break;
    }

    return requirements[level] ?? -1;
  }

  int getIncomeByLevel(int level) {
    Map<int, int> income = {};

    switch (this) {
      case BuildingType.store:
        income = {
          1: 5,
          2: 10,
          3: 15,
        };
        break;
      case BuildingType.market:
        income = {
          1: 15,
          2: 20,
          3: 25,
        };
        break;
      case BuildingType.cityMall:
        income = {
          1: 25,
          2: 50,
          3: 75,
        };
        break;

      case BuildingType.house:
      case BuildingType.apartment:
      case BuildingType.skyscraper:
      case BuildingType.coalElectricStation:
      case BuildingType.atomicElectricityStation:
      case BuildingType.windElectricityStation:
      case BuildingType.road:
        break;
    }

    return income[level] ?? 0;
  }

  Map<ResourceType, int> getBuildPrice() => getPriceByLevel(1);

  Map<ResourceType, int> getPriceByLevel(int level) {
    Map<int, Map<ResourceType, int>> price = {};

    switch (this) {
      case BuildingType.house:
        price = {
          1: {
            ResourceType.gold: 100,
          },
          2: {
            ResourceType.gold: 1000,
            ResourceType.iron: 10,
          },
          3: {
            ResourceType.gold: 10000,
            ResourceType.iron: 50,
          },
        };
        break;
      case BuildingType.apartment:
        price = {
          1: {
            ResourceType.gold: 10000,
            ResourceType.iron: 200,
          },
          2: {
            ResourceType.gold: 25000,
            ResourceType.iron: 500,
          },
          3: {
            ResourceType.gold: 50000,
            ResourceType.iron: 1000,
          },
        };
        break;
      case BuildingType.skyscraper:
        price = {
          1: {
            ResourceType.gold: 100000,
            ResourceType.iron: 10000,
          },
          2: {
            ResourceType.gold: 250000,
            ResourceType.iron: 25000,
          },
          3: {
            ResourceType.gold: 500000,
            ResourceType.iron: 50000,
          },
        };
        break;

      case BuildingType.store:
        price = {
          1: {
            ResourceType.gold: 100,
          },
          2: {
            ResourceType.gold: 1000,
            ResourceType.iron: 10,
          },
          3: {
            ResourceType.gold: 10000,
            ResourceType.iron: 50,
          },
        };
        break;
      case BuildingType.market:
        price = {
          1: {
            ResourceType.gold: 10000,
            ResourceType.iron: 200,
          },
          2: {
            ResourceType.gold: 25000,
            ResourceType.iron: 500,
          },
          3: {
            ResourceType.gold: 50000,
            ResourceType.iron: 1000,
          },
        };
        break;
      case BuildingType.cityMall:
        price = {
          1: {
            ResourceType.gold: 100000,
            ResourceType.iron: 10000,
          },
          2: {
            ResourceType.gold: 250000,
            ResourceType.iron: 25000,
          },
          3: {
            ResourceType.gold: 500000,
            ResourceType.iron: 50000,
          },
        };
        break;

      case BuildingType.coalElectricStation:
        price = {
          1: {ResourceType.gold: 100},
          2: {
            ResourceType.gold: 1000,
            ResourceType.iron: 10,
          },
          3: {
            ResourceType.gold: 10000,
            ResourceType.iron: 50,
          },
        };
        break;
      case BuildingType.atomicElectricityStation:
        price = {
          1: {
            ResourceType.gold: 10000,
            ResourceType.iron: 200,
          },
          2: {
            ResourceType.gold: 25000,
            ResourceType.iron: 500,
          },
          3: {
            ResourceType.gold: 50000,
            ResourceType.iron: 1000,
          },
        };
        break;
      case BuildingType.windElectricityStation:
        price = {
          1: {
            ResourceType.gold: 100000,
            ResourceType.iron: 10000,
          },
          2: {
            ResourceType.gold: 250000,
            ResourceType.iron: 25000,
          },
          3: {
            ResourceType.gold: 500000,
            ResourceType.iron: 50000,
          },
        };
        break;

      case BuildingType.road:
        price = {
          1: {ResourceType.gold: 100},
        };
        break;
    }

    return price[level] ?? {};
  }

  String get title {
    switch (this) {
      case BuildingType.house:
        return 'House';
      case BuildingType.apartment:
        return 'Apartment';
      case BuildingType.skyscraper:
        return 'Skyscraper';
      case BuildingType.store:
        return 'Store';
      case BuildingType.market:
        return 'Market';
      case BuildingType.cityMall:
        return 'City Mall';
      case BuildingType.coalElectricStation:
        return 'Coal electric station';
      case BuildingType.atomicElectricityStation:
        return 'Atomic Electricity Station';
      case BuildingType.windElectricityStation:
        return 'Wind Electricity Station';
      case BuildingType.road:
        return 'Road';
    }
  }

  String get description {
    switch (this) {
      case BuildingType.house:
        return "This is a house which can be used to live in. It's a small building.";
      case BuildingType.apartment:
        return "This is an apartment which can be used to live in. It's a medium building.";
      case BuildingType.skyscraper:
        return "This is a skyscraper which can be used to live in. It's a big building.";
      case BuildingType.store:
        return 'This is a store which can be used to sell products. Generate income for you.';
      case BuildingType.market:
        return 'This is a market which can be used to sell products. Generate income for you.';
      case BuildingType.cityMall:
        return 'This is a city mall which can be used to sell products. Generate income for you.';
      case BuildingType.coalElectricStation:
        return 'This is a coal electric station which can be used to generate electricity.';
      case BuildingType.atomicElectricityStation:
        return 'This is an atomic electricity station which can be used to generate electricity.';
      case BuildingType.windElectricityStation:
        return 'This is a wind electricity station which can be used to generate electricity.';
      case BuildingType.road:
        return 'This is a road which can be used to connect buildings.';
    }
  }
}
