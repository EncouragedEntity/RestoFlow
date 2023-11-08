import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/auth_event.dart';
import 'package:resto_flow/blocs/states/auth_state.dart';

import '../repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({
    required this.userRepository,
    required AuthState state,
  }) : super(state) {
    on<AuthUpdateUserEvent>(
      (event, emit) async {
        emit(AuthLoading());
        final newUser = event.user;
        final email = event.email;

        try {
          emit(AuthAuthenticated(await userRepository.update(email, newUser)));
        } on Exception catch (e) {
          emit(AuthFailure("Failed to update user \n${e.toString()}"));
        }
      },
    );

    on<AuthWantToSignUpEvent>((event, emit) {
      emit(AuthSigningUp());
    });

    on<AuthWantToLogInEvent>((event, emit) async {
      final user = UserRepository.currentUser;
      if (user == null) {
        emit(AuthLoggingIn());
        return;
      }
      emit(AuthAuthenticated(user));
    });

    on<AuthLogInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await userRepository.logIn(event.email, event.password);
        emit(AuthAuthenticated(user));
      } catch (error) {
        emit(AuthFailure(error.toString()));
      }
    });

    on<AuthAutomaticLoginEvent>(
      (event, emit) async {
        try {
          final user = await userRepository.automaticLogin();
          if (user == null) {
            emit(AuthUnauthenticated());
            return;
          }
          emit(AuthAuthenticated(user));
        } catch (error) {
          emit(AuthFailure(error.toString()));
        }
      },
    );

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await userRepository.register(event.email, event.password);
        emit(AuthAuthenticated(user));
      } catch (error) {
        emit(AuthFailure(error.toString()));
      }
    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoading());
      await userRepository.logOut();
      emit(AuthSignedOut());
    });
  }
}
