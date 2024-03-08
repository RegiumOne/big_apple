import 'package:big_apple/common/extensions/string_extensions.dart';
import 'package:big_apple/generated/assets.gen.dart';

extension AssetGenExtension on AssetGenImage {
  String asset() {
    return path.removeAssetsPath();
  }
}
