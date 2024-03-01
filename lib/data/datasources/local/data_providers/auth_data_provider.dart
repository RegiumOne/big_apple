import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AuthDataProviderKeys {
  const _AuthDataProviderKeys._();

  static const oauthProviderKey = 'oauth_provider_key';
}

@injectable
class AuthDataProvider {
  const AuthDataProvider(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  OAuthProvider? getOAuthProvider() {
    final providerRaw = _sharedPreferences.getString(_AuthDataProviderKeys.oauthProviderKey);
    if (providerRaw == null) return null;
    return OAuthProvider.getProviderFromString(providerRaw);
  }

  Future<bool> setOAuthProvider(OAuthProvider? provider) async {
    try {
      if (provider == null) return _sharedPreferences.remove(_AuthDataProviderKeys.oauthProviderKey);

      return _sharedPreferences.setString(_AuthDataProviderKeys.oauthProviderKey, provider.provider);
    } catch (e) {
      return false;
    }
  }
}
