import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/commercial_type.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commercial.g.dart';

@JsonSerializable(explicitToJson: true)
class Commercial extends Building<CommercialType> {
  const Commercial({
    required super.currentLevel,
    required super.type,
  });

  factory Commercial.fromJson(Map<String, dynamic> json) => _$CommercialFromJson(json);

  Map<String, dynamic> toJson() => _$CommercialToJson(this);

  @override
  double get buildingDurationInSeconds {
    switch (type) {
      case CommercialType.store:
        if (currentLevel == 1) return 10;
        if (currentLevel == 2) return 60 * 10;
        if (currentLevel == 3) return 60 * 30;
      case CommercialType.market:
        if (currentLevel == 1) return 60 * 30;
        if (currentLevel == 2) return 60 * 60;
        if (currentLevel == 3) return 60 * 60 * 4;
      case CommercialType.cityMall:
        if (currentLevel == 1) return 60 * 60 * 4;
        if (currentLevel == 2) return 60 * 60 * 8;
        if (currentLevel == 3) return 60 * 60 * 12;
    }
    return 0;
  }

  @override
  double get income {
    switch (type) {
      case CommercialType.store:
        if (currentLevel == 1) return 5;
        if (currentLevel == 2) return 10;
        if (currentLevel == 3) return 15;
      case CommercialType.market:
        if (currentLevel == 1) return 15;
        if (currentLevel == 2) return 20;
        if (currentLevel == 3) return 25;
      case CommercialType.cityMall:
        if (currentLevel == 1) return 25;
        if (currentLevel == 2) return 50;
        if (currentLevel == 3) return 75;
    }
    return 0;
  }

  @override
  Map<PassiveBenefit, int> get passiveBenefits {
    switch (type) {
      case CommercialType.store:
        if (currentLevel == 1) return {PassiveBenefit.peopleMaxCapacity: 2};
        if (currentLevel == 2) return {PassiveBenefit.peopleMaxCapacity: 4};
        if (currentLevel == 3) return {PassiveBenefit.peopleMaxCapacity: 6};
      case CommercialType.market:
        if (currentLevel == 1) return {PassiveBenefit.peopleMaxCapacity: 15};
        if (currentLevel == 2) return {PassiveBenefit.peopleMaxCapacity: 20};
        if (currentLevel == 3) return {PassiveBenefit.peopleMaxCapacity: 25};
      case CommercialType.cityMall:
        if (currentLevel == 1) return {PassiveBenefit.peopleMaxCapacity: 30};
        if (currentLevel == 2) return {PassiveBenefit.peopleMaxCapacity: 45};
        if (currentLevel == 3) return {PassiveBenefit.peopleMaxCapacity: 60};
    }
    return {};
  }

  @override
  Map<PassiveDisadvantage, int> get passiveDisadvantages {
    switch (type) {
      case CommercialType.store:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 1};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 2};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 3};
      case CommercialType.market:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 15};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 20};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 25};
      case CommercialType.cityMall:
        if (currentLevel == 1) return {PassiveDisadvantage.electricityPts: 30};
        if (currentLevel == 2) return {PassiveDisadvantage.electricityPts: 45};
        if (currentLevel == 3) return {PassiveDisadvantage.electricityPts: 60};
    }
    return {};
  }

  @override
  Map<ResourceType, int> get price {
    switch (type) {
      case CommercialType.store:
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
      case CommercialType.market:
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
      case CommercialType.cityMall:
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
      case CommercialType.store:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 1};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 1};
      case CommercialType.market:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 5};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 5};
      case CommercialType.cityMall:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 2) return {RequirementType.ecologyLvl: 10};
        if (currentLevel == 3) return {RequirementType.ecologyLvl: 10};
    }
    return {};
  }

  @override
  String get title {
    switch (type) {
      case CommercialType.store:
        return 'Store';
      case CommercialType.market:
        return 'Market';
      case CommercialType.cityMall:
        return 'City Mall';
    }
  }

  @override
  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case CommercialType.store:
        path = Assets.images.shopLvl1.path;
        break;
      case CommercialType.market:
        path = Assets.images.marketLvl1.path;
        break;
      case CommercialType.cityMall:
        path = Assets.images.mallLvl1.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageHalf({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case CommercialType.store:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case CommercialType.market:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case CommercialType.cityMall:
        path = Assets.images.initialBuilding2x2.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageInitial({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case CommercialType.store:
        path = Assets.images.initialBuilding1x1.path;
        break;
      case CommercialType.market:
        path = Assets.images.initialBuilding2x1.path;
        break;
      case CommercialType.cityMall:
        path = Assets.images.initialBuilding2x2.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  Building<CommercialType> copyWith({int? currentLevel, CommercialType? type}) {
    return Commercial(
      currentLevel: currentLevel ?? this.currentLevel,
      type: type ?? this.type,
    );
  }
}
