import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/pages/home_page.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'blocs/nav_bloc.dart';
import 'config/ngrok.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getServerLink(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Check your internet connection or try again later.\n ${snapshot.error.toString()}",
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(
                    userRepository:
                        UserRepository(apiUrl: snapshot.data ?? "error"),
                  ),
                ),
                BlocProvider<NavBloc>(
                  create: (context) => NavBloc(),
                ),
              ],
              child: const HomePage(),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    ),
  );
}
