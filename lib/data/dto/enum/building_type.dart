import 'package:big_apple/generated/assets.gen.dart';

enum BuildingType {
  mill;

  double get moneyPerUnitOfTime {
    switch (this) {
      case BuildingType.mill:
        return 1;
    }
  }

  String get image {
    String result = '';
    switch (this) {
      case BuildingType.mill:
        result = Assets.images.mill.path;
    }
    result = result.replaceAll('assets/images/', '');
    return result;
  }
}
