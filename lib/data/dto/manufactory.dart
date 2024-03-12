import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/manufactory_type.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manufactory.g.dart';

@JsonSerializable(explicitToJson: true)
class Manufactory extends Building<ManufactoryType> {
  const Manufactory({
    required super.currentLevel,
    required super.type,
  });

  factory Manufactory.fromJson(Map<String, dynamic> json) => _$ManufactoryFromJson(json);

  Map<String, dynamic> toJson() => _$ManufactoryToJson(this);

  @override
  double get buildingDurationInSeconds {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        if (currentLevel == 1) return 10;
        if (currentLevel == 2) return 60 * 10;
        if (currentLevel == 3) return 60 * 30;
      case ManufactoryType.atomicElectricityStation:
        if (currentLevel == 1) return 60 * 30;
        if (currentLevel == 2) return 60 * 60;
        if (currentLevel == 3) return 60 * 60 * 4;
      case ManufactoryType.windElectricityStation:
        if (currentLevel == 1) return 60 * 60 * 4;
        if (currentLevel == 2) return 60 * 60 * 8;
        if (currentLevel == 3) return 60 * 60 * 12;
    }
    return 0;
  }

  @override
  double get income => 0;

  @override
  Map<PassiveBenefit, int> get passiveBenefits {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        if (currentLevel == 1) return {PassiveBenefit.electricityPts: 5};
        if (currentLevel == 2) return {PassiveBenefit.electricityPts: 10};
        if (currentLevel == 3) return {PassiveBenefit.electricityPts: 15};
      case ManufactoryType.atomicElectricityStation:
        if (currentLevel == 1) return {PassiveBenefit.electricityPts: 30};
        if (currentLevel == 2) return {PassiveBenefit.electricityPts: 40};
        if (currentLevel == 3) return {PassiveBenefit.electricityPts: 50};
      case ManufactoryType.windElectricityStation:
        if (currentLevel == 1) return {PassiveBenefit.electricityPts: 5};
        if (currentLevel == 2) return {PassiveBenefit.electricityPts: 10};
        if (currentLevel == 3) return {PassiveBenefit.electricityPts: 15};
    }
    return {};
  }

  @override
  Map<PassiveDisadvantage, int> get passiveDisadvantages {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        if (currentLevel == 1) return {PassiveDisadvantage.freeWorkers: 5};
        if (currentLevel == 2) return {PassiveDisadvantage.freeWorkers: 5};
        if (currentLevel == 3) return {PassiveDisadvantage.freeWorkers: 5};
      case ManufactoryType.atomicElectricityStation:
        if (currentLevel == 1) return {PassiveDisadvantage.freeWorkers: 15};
        if (currentLevel == 2) return {PassiveDisadvantage.freeWorkers: 15};
        if (currentLevel == 3) return {PassiveDisadvantage.freeWorkers: 15};
      case ManufactoryType.windElectricityStation:
        if (currentLevel == 1) return {PassiveDisadvantage.freeWorkers: 1};
        if (currentLevel == 2) return {PassiveDisadvantage.freeWorkers: 1};
        if (currentLevel == 3) return {PassiveDisadvantage.freeWorkers: 1};
    }
    return {};
  }

  @override
  Map<ResourceType, int> get price {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        if (currentLevel == 1) return {ResourceType.coin: 100};
        if (currentLevel == 2) {
          return {
            ResourceType.coin: 1000,
            ResourceType.metal: 10,
          };
        }
        if (currentLevel == 3) {
          return {
            ResourceType.coin: 10000,
            ResourceType.metal: 50,
          };
        }
      case ManufactoryType.atomicElectricityStation:
        if (currentLevel == 1) {
          return {
            ResourceType.coin: 10000,
            ResourceType.metal: 200,
          };
        }
        if (currentLevel == 2) {
          return {
            ResourceType.coin: 25000,
            ResourceType.metal: 500,
          };
        }
        if (currentLevel == 3) {
          return {
            ResourceType.coin: 50000,
            ResourceType.metal: 1000,
          };
        }
      case ManufactoryType.windElectricityStation:
        if (currentLevel == 1) {
          return {
            ResourceType.coin: 100000,
            ResourceType.metal: 10000,
          };
        }
        if (currentLevel == 2) {
          return {
            ResourceType.coin: 250000,
            ResourceType.metal: 25000,
          };
        }
        if (currentLevel == 3) {
          return {
            ResourceType.coin: 500000,
            ResourceType.metal: 50000,
          };
        }
    }
    return {};
  }

  @override
  Map<RequirementType, int> get requirements {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 1};
      case ManufactoryType.atomicElectricityStation:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 5};
      case ManufactoryType.windElectricityStation:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 10};
    }
    return {};
  }

  @override
  String get title {
    switch (type) {
      case ManufactoryType.coalElectricStation:
        return 'Coal electric station';
      case ManufactoryType.atomicElectricityStation:
        return 'Atomic Electricity Station';
      case ManufactoryType.windElectricityStation:
        return 'Wind Electricity Station';
    }
  }

  @override
  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case ManufactoryType.coalElectricStation:
        path = Assets.images.houseLvl1.path;
        break;
      case ManufactoryType.atomicElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ManufactoryType.windElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageHalf({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case ManufactoryType.coalElectricStation:
        path = Assets.images.houseLvl1.path;
        break;
      case ManufactoryType.atomicElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ManufactoryType.windElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageInitial({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case ManufactoryType.coalElectricStation:
        path = Assets.images.houseLvl1.path;
        break;
      case ManufactoryType.atomicElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ManufactoryType.windElectricityStation:
        path = Assets.images.apartmentLvl1.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
