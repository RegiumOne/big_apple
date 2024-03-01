import 'dart:developer';

import 'package:big_apple/data/datasources/remote/auth_client.dart';
import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as app_write_models;

@Injectable(as: AuthClient)
class AuthClientImpl implements AuthClient {
  const AuthClientImpl(this._account);
  final Account _account;

  @override
  Future<app_write_models.User?> loginOAuth(OAuthProvider provider) async {
    try {
      await _account.createOAuth2Session(provider: provider.provider);
      return _account.get();
    } on AppwriteException catch (e) {
      log(e.message ?? 'Error logging in with Google');
    }
    return null;
  }

  @override
  Future<app_write_models.User?> getUser() async {
    try {
      return _account.get();
    } on AppwriteException catch (e) {
      log(e.message ?? 'Error getting user data');
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
  }
}
