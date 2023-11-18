import 'package:flutter/material.dart';

// Dark
// --text: #fef1f1;
// --background: #1e0000;
// --primary: #8e0101;
// --secondary: #520019;
// --accent: #ca9000;
//

const darkPrimaryColor = Color(0xFF004225);
const darkAccentColor = Color(0xFFFFB000);

ThemeData appTheme = ThemeData.dark().copyWith(
  dividerColor: Colors.grey.shade700,
  buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimaryColor,
    onPrimary: darkPrimaryColor,
    secondary: darkPrimaryColor,
    onSecondary: darkPrimaryColor,
    error: darkPrimaryColor,
    onError: darkPrimaryColor,
    background: darkPrimaryColor,
    onBackground: Color(0xFFF5F5DC),
    surface: darkPrimaryColor,
    onSurface: darkPrimaryColor,
  )),
  scaffoldBackgroundColor: const Color.fromARGB(255, 0, 46, 26),
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
      color: Color(0xFFF5F5DC),
    ),
    bodyMedium: TextStyle(
      color: Color(0xFFF5F5DC),
    ),
  ),
);
