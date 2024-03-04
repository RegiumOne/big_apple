part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState({
    required this.oAuthProvider,
    required this.user,
  });

  final OAuthProvider? oAuthProvider;
  final app_write_models.User? user;
}

class AuthInitialState extends AuthState {
  const AuthInitialState({
    super.oAuthProvider,
    super.user,
  });
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState({
    required super.oAuthProvider,
    required super.user,
  });
}

class AuthLoadedState extends AuthState {
  const AuthLoadedState({
    required super.oAuthProvider,
    required super.user,
  });
}

class AuthFailureState extends AuthState {
  const AuthFailureState({
    required super.oAuthProvider,
    required super.user,
  });
}
