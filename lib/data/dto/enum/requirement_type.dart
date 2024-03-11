import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum RequirementType {
  level;

  String get title {
    switch (this) {
      case level:
        return 'lvl';
      default:
        return '';
    }
  }

  String icon({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case RequirementType.level:
        path = Assets.icons.lvl.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
