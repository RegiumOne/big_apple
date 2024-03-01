part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent(this.provider);

  final OAuthProvider provider;
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}

class AuthInitEvent extends AuthEvent {
  const AuthInitEvent();
}
