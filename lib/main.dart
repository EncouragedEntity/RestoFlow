import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/pages/home_page.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'config/ngrok.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getServerLink(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                    "Check your internet connection or try again later.\n ${snapshot.error.toString()}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider(
              create: (context) => AuthBloc(
                userRepository: UserRepository(apiUrl: snapshot.data),
              ),
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
