import 'package:collection/collection.dart';

enum OAuthProvider {
  google,
  apple;

  String get provider {
    return name;
  }

  static OAuthProvider? getProviderFromString(String provider) =>
      OAuthProvider.values.firstWhereOrNull((element) => element.provider == provider);
}
