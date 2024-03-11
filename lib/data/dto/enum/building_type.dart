import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/data/dto/enum/receive_type.dart';
import 'package:big_apple/data/dto/enum/requirement_type.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/generated/assets.gen.dart';

// TODO(hrubalskyi): stop using enum for buildings
enum BuildingType {
  mill;

  double get moneyPerUnitOfTime {
    switch (this) {
      case BuildingType.mill:
        return 100;
    }
  }

  Map<ResourceType, int> get cost {
    switch (this) {
      case BuildingType.mill:
        return {
          ResourceType.coin: 100,
          ResourceType.metal: 100,
        };
    }
  }

  int get level {
    switch (this) {
      case BuildingType.mill:
        return 1;
    }
  }

  Map<ReceiveType, int> get receive {
    switch (this) {
      case BuildingType.mill:
        return {ReceiveType.populationCapacity: 5};
    }
  }

  Map<RequirementType, int> get requirements {
    switch (this) {
      case BuildingType.mill:
        return {RequirementType.level: 1};
    }
  }

  double get constructionTimeInSeconds {
    switch (this) {
      case BuildingType.mill:
        return 10;
    }
  }

  String get title {
    switch (this) {
      case BuildingType.mill:
        return 'Mill';
    }
  }

  String get description {
    switch (this) {
      case BuildingType.mill:
        return 'Description maybe, why i must build it?';
    }
  }

  String imageInitial({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.mill:
        path = Assets.images.buildingMillInitial.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  String imageHalf({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.mill:
        path = Assets.images.buildingMillHalf.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  String imageDone({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case BuildingType.mill:
        path = Assets.images.buildingMillDone.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  List<String> get allImages {
    return [imageInitial(), imageHalf(), imageDone()];
  }
}
