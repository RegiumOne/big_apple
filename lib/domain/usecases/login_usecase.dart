import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:big_apple/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appwrite/models.dart' as app_write_models;

@Injectable()
class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<app_write_models.User?> call(OAuthProvider provider) async {
    final user = await _authRepository.login(provider);

    if (user != null) {
      await _authRepository.setOAuthProvider(provider);
    }

    return user;
  }
}
