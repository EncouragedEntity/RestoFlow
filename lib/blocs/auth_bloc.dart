import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
import 'package:resto_flow/states/auth_state.dart';

import '../repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial());

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignInEvent) {
      yield AuthLoading();
      try {
        final user = await userRepository.register(event.email, event.password);
        yield AuthAuthenticated(user);
      } catch (error) {
        yield AuthFailure(error.toString());
      }
    } else if (event is AuthSignUpEvent) {
      yield AuthLoading();
      try {
        final user = await userRepository.logIn(event.email, event.password);
        yield AuthAuthenticated(user);
      } catch (error) {
        yield AuthFailure(error.toString());
      }
    } else if (event is AuthSignOutEvent) {
      yield AuthLoading();
      await userRepository.signOut();
      yield AuthUnauthenticated();
    }
  }
}
