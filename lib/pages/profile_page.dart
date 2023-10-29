import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
import 'package:resto_flow/models/auth/user.dart';
import 'package:resto_flow/repositories/user_repository.dart';

import '../generated/l10n.dart';
import '../states/auth_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = UserRepository.currentUser?.firstName ?? "";
    _lastNameController.text = UserRepository.currentUser?.lastName ?? "";
    _emailController.text = UserRepository.currentUser?.email ?? "";
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return buildUserProfile(
            state.user,
            context,
          );
        } else {
          context.read<AuthBloc>().add(AuthWantToLogInEvent());
        }
        return Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        );
      },
    );
  }

  Widget buildUserProfile(User user, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${S.current.hello} ${user.firstName.isNotEmpty ? user.firstName : S.current.stranger}"),
        actions: [
          Row(
            children: [
              Text(
                user.bonusScore.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.monetization_on, color: Colors.yellow),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutEvent());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: S.current.email),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _firstNameController,
                        decoration:
                            InputDecoration(labelText: S.current.firstname),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        decoration:
                            InputDecoration(labelText: S.current.lastname),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final editedFirstName = _firstNameController.text;
                  final editedLastName = _lastNameController.text;
                  final editedEmail = _emailController.text;

                  context.read<AuthBloc>().add(
                        AuthUpdateUserEvent(
                          user: user.copyWith(
                            firstName: editedFirstName,
                            lastName: editedLastName,
                            email: editedEmail,
                          ),
                          email: editedEmail,
                        ),
                      );
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
