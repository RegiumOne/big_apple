import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum PassiveDisadvantage {
  electricityPts,
  freeWorkers;

  String get title {
    switch (this) {
      case electricityPts:
        return '';
      case freeWorkers:
        return '';
      default:
        return '';
    }
  }

  String icon({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case electricityPts:
        path = Assets.icons.energyWhite.path;
        break;
      case freeWorkers:
        path = Assets.icons.populationWhite.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
