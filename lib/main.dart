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

// Dark
// --text: #fef1f1;
// --background: #1e0000;
// --primary: #8e0101;
// --secondary: #520019;
// --accent: #ca9000;
//
// Light
// --text: #0e0101;
// --background: #ffe0e0;
// --primary: #fe7171;
// --secondary: #ffadc6;
// --accent: #9fb7c1;

void main() async {
  const darkPrimaryColor = Color(0xFF8E0101);
  const darkAccentColor = Color(0xFFCA9000);

  const primaryColor = Color(0xFFFE7171);
  const accentColor = Color(0xFF9FB7C1);

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
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E0000),
          primaryColor: darkPrimaryColor,
          primaryColorLight: darkPrimaryColor,
          primaryColorDark: darkPrimaryColor,
          highlightColor: darkAccentColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: darkPrimaryColor,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Color(0xFFFEF1F1),
            ),
            bodyMedium: TextStyle(
              color: Color(0xFFFEF1F1),
            ),
          ),
        ),
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color(0xFFFFE0E0),
          primaryColor: primaryColor,
          primaryColorLight: primaryColor,
          primaryColorDark: primaryColor,
          highlightColor: accentColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: Colors.black,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Color(0xFF0E0101),
            ),
            bodyMedium: TextStyle(
              color: Color(0xFF0E0101),
            ),
          ),
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
