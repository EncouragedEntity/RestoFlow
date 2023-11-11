import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:resto_flow/widgets/auth/pass_text_field.dart';

import '../blocs/events/auth_event.dart';
import '../generated/l10n.dart';
import '../blocs/states/auth_state.dart';
import '../widgets/my_themed_alert.dart';
import '../widgets/my_themed_button.dart';
import '../widgets/settings_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _newPasswordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _newPasswordController = TextEditingController();

    _firstNameController.text = UserRepository.currentUser?.firstName ?? "";
    _lastNameController.text = UserRepository.currentUser?.lastName ?? "";
    _emailController.text = UserRepository.currentUser?.email ?? "";
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tilesBackgroundColor =
        Theme.of(context).scaffoldBackgroundColor.withGreen(70);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (ctx, state) {
        if (state is AuthAuthenticated) {
          final user = state.user;
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
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return MyThemedAlert(
                          title: Text(S.current.confirm_log_out),
                          content: Text(S.current.want_to_log_out),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).highlightColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.current.cancel),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).highlightColor,
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      AuthSignOutEvent(),
                                    );
                                Navigator.pop(context);
                              },
                              child: Text(S.current.log_out),
                            ),
                          ],
                        );
                      },
                    );
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
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SettingsTile(
                            width: 220,
                            title: Text(S.current.email),
                            trailing: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: S.current.email,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SettingsTile(
                            width: 220,
                            title: Text(S.current.firstname),
                            trailing: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      hintText: S.current.firstname,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SettingsTile(
                            width: 220,
                            title: Text(S.current.lastname),
                            trailing: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      hintText: S.current.lastname,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Accordion(
                            paddingListHorizontal: 0,
                            contentBorderColor: tilesBackgroundColor,
                            disableScrolling: true,
                            children: [
                              AccordionSection(
                                headerPadding: const EdgeInsets.all(8),
                                headerBackgroundColor: tilesBackgroundColor,
                                headerBorderRadius: 10,
                                contentBorderRadius: 10,
                                contentVerticalPadding: 30,
                                contentBackgroundColor: tilesBackgroundColor,
                                header: Text(S.current.password),
                                content: SettingsTile(
                                  trailing: Expanded(
                                    child: PasswordTextField(
                                      passController: _newPasswordController,
                                      titleText: S.current.new_password,
                                      allowEmpty: true,
                                    ),
                                  ),
                                  showDivider: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MyThemedButton(
                      height: 50,
                      onPressed: () {
                        Logger().i("Entered update");
                        String newPassword = "";
                        if (_formKey.currentState?.validate() ?? false) {
                          newPassword = _newPasswordController.text.trim();
                          final editedFirstName =
                              _firstNameController.text.trim();
                          final editedLastName =
                              _lastNameController.text.trim();
                          final editedEmail = _emailController.text.trim();

                          context.read<AuthBloc>().add(
                                AuthUpdateUserEvent(
                                  user: user.copyWith(
                                    firstName: editedFirstName,
                                    lastName: editedLastName,
                                    email: editedEmail,
                                    password: newPassword.isEmpty
                                        ? null
                                        : newPassword,
                                  ),
                                  email: user.email,
                                ),
                              );
                        }
                        Logger().i("Update ended");
                      },
                      child: Text(S.current.save_changes),
                    ),
                  ],
                ),
              ),
            ),
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
}
