import 'package:big_apple/generated/assets.gen.dart';

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

  String get imageInitial {
    String result = '';
    switch (this) {
      case BuildingType.mill:
        result = Assets.images.buildingMillInitial.path;
        break;
    }
    return _preparedPath(result);
  }

  String get imageHalf {
    String result = '';
    switch (this) {
      case BuildingType.mill:
        result = Assets.images.buildingMillHalf.path;
        break;
    }
    return _preparedPath(result);
  }

  String get imageDone {
    String result = '';
    switch (this) {
      case BuildingType.mill:
        result = Assets.images.buildingMillDone.path;
        break;
    }
    return _preparedPath(result);
  }

  List<String> get allImages {
    return [imageInitial, imageHalf, imageDone];
  }

  String _preparedPath(String result) {
    result = result.replaceAll('assets/images/', '');
    return result;
  }
}
