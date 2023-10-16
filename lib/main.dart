import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/generated/l10n.dart';
import 'package:resto_flow/pages/home_page.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'blocs/nav_bloc.dart';
import 'config/ngrok.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (value) => runApp(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 156, 0, 31),
            secondary: Color(0xFF191400),
            background: Color(0xFF762e3e),
            onPrimary: Color(0xFFffe1e7),
          ),
          hintColor: const Color(0xFFe2b603),
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
                      S.of(context).connection_error(snapshot.error.toString()),
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
    ),
  );
}
