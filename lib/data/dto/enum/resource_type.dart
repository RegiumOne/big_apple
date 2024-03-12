import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum ResourceType {
  coin,
  stone,
  metal,
  builders,
  electricity,
  population;

  String get title {
    switch (this) {
      case coin:
        return 'Coin';
      case stone:
        return 'Stone';
      case metal:
        return 'Metal';
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
      case coin:
        path = isWhite ? Assets.icons.coinWhite.path : Assets.icons.coin.path;
        break;
      case stone:
        path = isWhite ? Assets.icons.stoneWhite.path : Assets.icons.stone.path;
        break;
      case metal:
        path = isWhite ? Assets.icons.metalWhite.path : Assets.icons.metal.path;
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
}
