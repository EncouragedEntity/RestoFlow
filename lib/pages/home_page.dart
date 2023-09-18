import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/pages/qr_scanner_page.dart';
import 'package:resto_flow/states/auth_state.dart';

import '../widgets/navbar.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<NavBloc, int>(
            builder: (context, navState) {
              Widget currentPage = const ScannerPage();
              int selectedIndex = navState;

              if (authState is AuthLoading) {
                currentPage = const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (authState is AuthLoggingIn) {
                currentPage = const LoginPage();
              } else if (authState is AuthSigningUp) {
                currentPage = const SignUpPage();
              } else {
                if (navState == 0) {
                  currentPage = const ScannerPage();
                } else if (navState == 1) {
                  // TODO: Handle navigation to Menu Page
                  currentPage = const Placeholder();
                } else if (navState == 2) {
                  // TODO: Handle navigation to Order Page
                  currentPage = const Placeholder();
                } else if (navState == 3) {
                  // TODO: Handle navigation to Profile Page
                  currentPage = const Placeholder();
                }
              }

              return Column(
                children: [
                  Expanded(
                    child: currentPage,
                  ),
                  NavBar(selectedIndex: selectedIndex),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
