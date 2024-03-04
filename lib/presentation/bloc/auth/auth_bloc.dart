import 'package:appwrite/models.dart' as app_write_models;
import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:big_apple/domain/usecases/get_user_usecase.dart';
import 'package:big_apple/domain/usecases/login_usecase.dart';
import 'package:big_apple/domain/usecases/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._getUserUseCase,
    this._loginUseCase,
    this._logoutUseCase,
  ) : super(const AuthInitialState()) {
    on<AuthInitEvent>(_init, transformer: restartable());
    on<AuthLoginEvent>(_login, transformer: restartable());
    on<AuthLogoutEvent>(_logout, transformer: restartable());
  }

  final GetUserUseCase _getUserUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  void _init(
    AuthInitEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(
        AuthLoadingState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );

      final result = await _getUserUseCase.call();

      emit(
        AuthLoadedState(
          oAuthProvider: result.oAuthProvider,
          user: result.user,
        ),
      );
    } catch (e) {
      emit(
        AuthFailureState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );
    }
  }

  void _login(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(
        AuthLoadingState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );

      final user = await _loginUseCase.call(event.provider);

      emit(
        AuthLoadedState(
          oAuthProvider: event.provider,
          user: user,
        ),
      );
    } catch (e) {
      emit(
        AuthFailureState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );
    }
  }

  void _logout(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(
        AuthLoadingState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );

      await _logoutUseCase.call();

      emit(
        const AuthLoadedState(
          oAuthProvider: null,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        AuthFailureState(
          oAuthProvider: state.oAuthProvider,
          user: state.user,
        ),
      );
    }
  }
}
