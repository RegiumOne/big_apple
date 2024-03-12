import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum PassiveBenefit {
  populationCapacity,
  peopleMaxCapacity,
  electricityPts,
  income;

  String get title {
    switch (this) {
      case populationCapacity:
        return 'People';
      case peopleMaxCapacity:
        return 'People';
      case electricityPts:
        return 'Electricity';
      case income:
        return 'Income';
    }
  }

  String icon({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case populationCapacity:
        path = Assets.icons.populationWhite.path;
        break;
      case electricityPts:
        path = Assets.icons.energyWhite.path;
        break;
      case peopleMaxCapacity:
        path = Assets.icons.populationWhite.path;
        break;
      case income:
        path = Assets.icons.coinWhite.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
