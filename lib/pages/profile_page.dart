import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
import 'package:resto_flow/models/auth/user.dart';

import '../states/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return buildUserProfile(state.user);
        } else {
          context.read<AuthBloc>().add(AuthWantToLogInEvent());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildUserProfile(User user) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Profile for ${user.username}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text("Email: ${user.email}"),
          Text("First Name: ${user.firstName}"),
          Text("Last Name: ${user.lastName}"),
          Text("Authorities: ${user.authorities.join(", ")}"),
          Text("Bonus Score: ${user.bonusScore}"),
          Text("Deleted: ${user.deleted ? 'Yes' : 'No'}"),
        ],
      ),
    );
  }
}
