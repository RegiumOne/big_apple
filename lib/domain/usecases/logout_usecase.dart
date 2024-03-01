import 'package:big_apple/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call() async {
    await _authRepository.logout();
    await _authRepository.setOAuthProvider(null);
  }
}
