import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthWantToLogInEvent extends AuthEvent {}

class AuthWantToSignUpEvent extends AuthEvent {}

class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLogInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthAutomaticLoginEvent extends AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOutEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {
  final String errorMessage;

  AuthErrorEvent({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
