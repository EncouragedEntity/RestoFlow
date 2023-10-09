import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';

class LoginRequiredPage extends StatelessWidget {
  const LoginRequiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("To access this page you should"),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthWantToLogInEvent());
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
