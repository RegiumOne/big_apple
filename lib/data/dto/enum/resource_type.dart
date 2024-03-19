import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum ResourceType {
  gold,
  coal,
  iron,
  wood,
  builders,
  electricity,
  population;

  String get title {
    switch (this) {
      case gold:
        return 'Coin';
      case coal:
        return 'Stone';
      case iron:
        return 'Metal';
      case wood:
        return 'Wood';
      case builders:
        return 'Builders';
      case electricity:
        return 'Electricity';
      case population:
        return 'Population';
    }
  }

  String icon({bool replacePath = true, bool isWhite = false}) {
    String path = '';
    switch (this) {
      case gold:
        path = isWhite ? Assets.icons.coinWhite.path : Assets.icons.coin.path;
        break;
      case coal:
        path = isWhite ? Assets.icons.stoneWhite.path : Assets.icons.stone.path;
        break;
      case iron:
        path = isWhite ? Assets.icons.metalWhite.path : Assets.icons.metal.path;
        break;
      case wood:
        path = isWhite ? Assets.icons.woodWhite.path : Assets.icons.wood.path;
        break;
      case builders:
        path = Assets.icons.worker.path;
        break;
      case electricity:
        path = isWhite ? Assets.icons.energyWhite.path : Assets.icons.energy.path;
        break;
      case population:
        path = isWhite ? Assets.icons.populationWhite.path : Assets.icons.population.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }

  static List<ResourceType> mainResources = [
    gold,
    coal,
    iron,
    wood,
  ];
}
