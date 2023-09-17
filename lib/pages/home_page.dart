import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/pages/auth/signup_page.dart';
import 'package:resto_flow/pages/qr_scanner_page.dart';
import 'package:resto_flow/states/auth_state.dart';

import 'auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthLoggingIn) {
          return const LoginPage();
        } else if (state is AuthSigningUp) {
          return const SingUpPage();
        } else if (state is AuthAuthenticated) {
          // TODO pass bool "Whether the user is Authenticated or not"
          return const ScannerPage();
        } else if (state is AuthUnauthenticated) {
          // TODO pass bool "Whether the user is Authenticated or not"
          return const ScannerPage();
        } else if (state is AuthFailure) {
          //TODO ErrorPage or ErrorDialog
          return const Placeholder();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
