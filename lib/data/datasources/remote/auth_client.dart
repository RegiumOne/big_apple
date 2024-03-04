import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:appwrite/models.dart' as app_write_models;

abstract interface class AuthClient {
  Future<app_write_models.User?> loginOAuth(OAuthProvider provider);
  Future<app_write_models.User?> getUser();
  Future<void> logout();
}
