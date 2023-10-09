import 'package:flutter/material.dart';
import 'package:resto_flow/pages/auth/login_page.dart';
import 'package:resto_flow/repositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget pageContent = const Center(
      child: Text("Profile here"),
    );
    if (UserRepository.currentUser == null) {
      pageContent = const LoginPage();
    }
    return pageContent;
  }
}
