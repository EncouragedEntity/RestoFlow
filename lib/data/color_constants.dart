import 'package:flutter/material.dart';

// Dark
// --text: #fef1f1;
// --background: #1e0000;
// --primary: #8e0101;
// --secondary: #520019;
// --accent: #ca9000;
//

const darkPrimaryColor = Color(0xFF8E0101);
const darkAccentColor = Color.fromARGB(255, 236, 170, 0);

ThemeData appTheme = ThemeData.dark().copyWith(
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
);
