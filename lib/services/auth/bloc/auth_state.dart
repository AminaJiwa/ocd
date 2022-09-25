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

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}
//login faluire is now expressed by the state logged out - so your either logged
//in or logged out

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
