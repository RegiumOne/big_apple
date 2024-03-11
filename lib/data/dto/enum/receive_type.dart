import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum ReceiveType {
  populationCapacity;

  String get title {
    switch (this) {
      case populationCapacity:
        return 'capacity';
      default:
        return '';
    }
  }

  String icon({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case ReceiveType.populationCapacity:
        path = Assets.icons.populationWhite.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
