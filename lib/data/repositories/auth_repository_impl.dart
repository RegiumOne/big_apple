import 'package:appwrite/models.dart' as app_write_models;
import 'package:big_apple/data/datasources/local/data_providers/auth_data_provider.dart';
import 'package:big_apple/data/datasources/remote/auth_client.dart';
import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:big_apple/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authApiClient, this._authDataProvider);

  final AuthClient _authApiClient;
  final AuthDataProvider _authDataProvider;

  @override
  Future<app_write_models.User?> login(OAuthProvider provider) async {
    return _authApiClient.loginOAuth(provider);
  }

  @override
  Future<app_write_models.User?> getUser() async {
    return _authApiClient.getUser();
  }

  @override
  Future<void> logout() async {
    return _authApiClient.logout();
  }

  @override
  OAuthProvider? getOAuthProvider() => _authDataProvider.getOAuthProvider();

  @override
  Future<bool> setOAuthProvider(OAuthProvider? provider) => _authDataProvider.setOAuthProvider(provider);
}
