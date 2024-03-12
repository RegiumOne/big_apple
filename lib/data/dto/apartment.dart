import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/apartment_type.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apartment.g.dart';

@JsonSerializable(explicitToJson: true)
class Apartment extends Building<ApartmentType> {
  const Apartment({
    required super.currentLevel,
    required super.type,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) => _$ApartmentFromJson(json);

  Map<String, dynamic> toJson() => _$ApartmentToJson(this);

  @override
  double get buildingDurationInSeconds {
    switch (type) {
      case ApartmentType.house:
        if (currentLevel == 1) return 10;
        if (currentLevel == 2) return 60 * 10;
        if (currentLevel == 3) return 60 * 30;
      case ApartmentType.apartment:
        if (currentLevel == 1) return 60 * 30;
        if (currentLevel == 2) return 60 * 60;
        if (currentLevel == 3) return 60 * 60 * 4;
      case ApartmentType.skyscraper:
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
      case ApartmentType.house:
        if (currentLevel == 1) return {PassiveBenefit.populationCapacity: 5};
        if (currentLevel == 2) return {PassiveBenefit.populationCapacity: 10};
        if (currentLevel == 3) return {PassiveBenefit.populationCapacity: 15};
      case ApartmentType.apartment:
        if (currentLevel == 1) return {PassiveBenefit.populationCapacity: 25};
        if (currentLevel == 2) return {PassiveBenefit.populationCapacity: 50};
        if (currentLevel == 3) return {PassiveBenefit.populationCapacity: 75};
      case ApartmentType.skyscraper:
        if (currentLevel == 1) return {PassiveBenefit.populationCapacity: 100};
        if (currentLevel == 2) return {PassiveBenefit.populationCapacity: 200};
        if (currentLevel == 3) return {PassiveBenefit.populationCapacity: 300};
    }
    return {};
  }

  @override
  Map<PassiveDisadvantage, int> get passiveDisadvantages {
    switch (type) {
      case ApartmentType.house:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 1};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 2};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 3};
      case ApartmentType.apartment:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 5};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 10};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 15};
      case ApartmentType.skyscraper:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 10};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 25};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 50};
    }
    return {};
  }

  @override
  Map<ResourceType, int> get price {
    switch (type) {
      case ApartmentType.house:
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
      case ApartmentType.apartment:
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
      case ApartmentType.skyscraper:
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
      case ApartmentType.house:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 1};
      case ApartmentType.apartment:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 5};
      case ApartmentType.skyscraper:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 10};
    }
    return {};
  }

  @override
  String get title {
    switch (type) {
      case ApartmentType.house:
        return 'House';
      case ApartmentType.apartment:
        return 'Apartment';
      case ApartmentType.skyscraper:
        return 'Skyscraper';
    }
  }

  @override
  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case ApartmentType.house:
        path = Assets.images.houseLvl1.path;
        break;
      case ApartmentType.apartment:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ApartmentType.skyscraper:
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
      case ApartmentType.house:
        path = Assets.images.houseLvl1Half.path;
        break;
      case ApartmentType.apartment:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ApartmentType.skyscraper:
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
      case ApartmentType.house:
        path = Assets.images.houseLvl1Initial.path;
        break;
      case ApartmentType.apartment:
        path = Assets.images.apartmentLvl1.path;
        break;
      case ApartmentType.skyscraper:
        path = Assets.images.apartmentLvl1.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
