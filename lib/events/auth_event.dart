import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOutEvent extends AuthEvent {}
