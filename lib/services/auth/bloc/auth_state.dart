import "package:flutter/foundation.dart" show immutable;
import 'package:ocd/services/auth/auth_user.dart';

//usually states are immutable
@immutable
abstract class AuthState {
  //a constant constructor cannot call a non-constant super constructor of a parent class
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoginFailure extends AuthState {
  final Exception exception;
  const AuthStateLoginFailure(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
