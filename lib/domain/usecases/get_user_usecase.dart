import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:big_apple/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appwrite/models.dart' as app_write_models;

@Injectable()
class GetUserUseCase {
  GetUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<GetUserUseCaseResult> call() async {
    app_write_models.User? user = await _authRepository.getUser();
    OAuthProvider? oAuthProvider = _authRepository.getOAuthProvider();

    if (user == null && oAuthProvider != null) {
      user = await _authRepository.login(oAuthProvider);
      return GetUserUseCaseResult(user: user, oAuthProvider: oAuthProvider);
    } else if (user != null && oAuthProvider == null) {
      await _authRepository.logout();
      await _authRepository.setOAuthProvider(null);
      return GetUserUseCaseResult(user: null, oAuthProvider: null);
    } else {
      return GetUserUseCaseResult(user: user, oAuthProvider: oAuthProvider);
    }
  }
}

class GetUserUseCaseResult {
  GetUserUseCaseResult({
    required this.user,
    required this.oAuthProvider,
  });

  final app_write_models.User? user;
  final OAuthProvider? oAuthProvider;
}
