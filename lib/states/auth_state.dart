import 'package:equatable/equatable.dart';
import 'package:resto_flow/models/auth/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLoggingIn extends AuthState {}

class AuthSigningUp extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignedOut extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}
