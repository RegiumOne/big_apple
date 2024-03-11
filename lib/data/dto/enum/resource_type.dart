import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

enum ResourceType {
  coin,
  stone,
  metal;

  String icon({bool replacePath = true}) {
    String path = '';
    switch (this) {
      case ResourceType.coin:
        path = Assets.icons.coinWhite.path;
        break;
      case ResourceType.stone:
        path = Assets.icons.stoneWhite.path;
        break;
      case ResourceType.metal:
        path = Assets.icons.metalWhite.path;
        break;
    }
    if (replacePath) return path.removeAssetsImagesPath();
    return path;
  }
}
