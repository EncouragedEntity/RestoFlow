import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/auth_state.dart';
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

void main() async {
  const darkPrimaryColor = Color(0xFF8E0101);
  const darkAccentColor = Color(0xFFCA9000);

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var serverLink = "";
  AuthState defaultState = AuthUnauthenticated();
  try {
    serverLink = await getServerLink();
    if (UserRepository.currentUser == null) {
      final user = await UserRepository(apiUrl: serverLink).automaticLogin();
      if (user != null) {
        defaultState = AuthAuthenticated(user);
      }
    }
  } on Exception catch (e) {
    Logger().e(e.toString());
  }

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
          scaffoldBackgroundColor: const Color.fromARGB(255, 64, 0, 0),
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
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                userRepository: UserRepository(apiUrl: serverLink),
                state: defaultState,
              ),
            ),
            BlocProvider<NavBloc>(
              create: (context) => NavBloc(),
            ),
            BlocProvider<ProductBloc>(
              create: (context) => ProductBloc(),
            ),
            BlocProvider<OrderBloc>(
              create: (context) => OrderBloc(),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
