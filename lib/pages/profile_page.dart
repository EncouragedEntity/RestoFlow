import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
import 'package:resto_flow/repositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget pageContent = const Center(
      child: Text("Profile here"),
    );
    if (UserRepository.currentUser == null) {
      context.read<AuthBloc>().add(AuthWantToLogInEvent());
    }
    return pageContent;
  }
}
