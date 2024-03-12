import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/passive_benefit.dart';
import 'package:big_apple/data/dto/enum/passive_disadvantage.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/data/dto/enum/road_type.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'road.g.dart';

@JsonSerializable(explicitToJson: true)
class Road extends Building<RoadType> {
  const Road({
    required super.currentLevel,
    required super.type,
  });

  factory Road.fromJson(Map<String, dynamic> json) => _$RoadFromJson(json);

  Map<String, dynamic> toJson() => _$RoadToJson(this);

  @override
  double get buildingDurationInSeconds {
    switch (type) {
      case RoadType.road:
        if (currentLevel == 1) return 10;
        if (currentLevel == 2) return 60 * 10;
        if (currentLevel == 3) return 60 * 30;
    }
    return 0;
  }

  @override
  double get income => 0;

  @override
  Map<PassiveBenefit, int> get passiveBenefits {
    return {};
  }

  @override
  Map<PassiveDisadvantage, int> get passiveDisadvantages {
    return {};
  }

  @override
  Map<ResourceType, int> get price {
    switch (type) {
      case RoadType.road:
        if (currentLevel == 1) return {ResourceType.coin: 100};
    }
    return {};
  }

  @override
  Map<RequirementType, int> get requirements {
    switch (type) {
      case RoadType.road:
        if (currentLevel == 1) return {RequirementType.ecologyLvl: 1};
    }
    return {};
  }

  @override
  String get title {
    switch (type) {
      case RoadType.road:
        return 'Road';
    }
  }

  @override
  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case RoadType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageHalf({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case RoadType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  @override
  String imageInitial({bool replacePath = true}) {
    String path = '';
    switch (type) {
      case RoadType.road:
        path = Assets.images.road.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
