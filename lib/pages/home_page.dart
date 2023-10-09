import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/pages/profile_page.dart';
import 'package:resto_flow/pages/qr_scanner_page.dart';
import 'package:resto_flow/states/auth_state.dart';

import '../widgets/navbar.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<NavBloc, int>(
            builder: (context, navState) {
              Widget currentPage = const ScannerPage();
              if (authState is AuthLoading) {
                currentPage = const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (authState is AuthLoggingIn) {
                return const LoginPage();
              } else if (authState is AuthSigningUp) {
                return const SignUpPage();
              } else {
                if (navState == 0) {
                  // TODO: Handle navigation to Menu Page
                  currentPage = const Placeholder();
                  selectedIndex = 0;
                } else if (navState == 1) {
                  // TODO: Handle navigation to Order Page
                  currentPage = const Placeholder();
                  selectedIndex = 1;
                } else if (navState == 2) {
                  currentPage = const ScannerPage();
                  selectedIndex = 2;
                } else if (navState == 3) {
                  // TODO: Handle navigation to Some Page
                  currentPage = const Placeholder();
                  selectedIndex = 3;
                } else if (navState == 4) {
                  currentPage = const ProfilePage();
                  selectedIndex = 4;
                }
              }
              return Column(
                children: [
                  Expanded(
                    child: currentPage,
                  ),
                  NavBar(initialIndex: selectedIndex),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
