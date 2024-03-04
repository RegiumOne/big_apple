import 'package:appwrite/models.dart' as app_write_models;
import 'package:big_apple/data/dto/enum/o_auth_provider.dart';

abstract interface class AuthRepository {
  Future<app_write_models.User?> login(OAuthProvider provider);
  Future<app_write_models.User?> getUser();
  Future<void> logout();

  OAuthProvider? getOAuthProvider();
  Future<bool> setOAuthProvider(OAuthProvider? provider);
}
