import 'package:big_apple/common/extensions/string_extensions.dart';
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

  double get cost {
    switch (this) {
      case BuildingType.mill:
        return 100;
    }
  }

  double get constructionTimeInSeconds {
    switch (this) {
      case BuildingType.mill:
        return 10;
    }
  }

  String title() {
    switch (this) {
      case BuildingType.mill:
        return 'Mill';
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
        path = Assets.images.apartment1Lvl.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  List<String> get allImages {
    return [imageInitial(), imageHalf(), imageDone()];
  }
}
