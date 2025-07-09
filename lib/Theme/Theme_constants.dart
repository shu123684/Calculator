import 'package:flutter/material.dart';
import 'package:calculator/Theme/AppButtonColors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: Colors.black, fontSize: 50),
    headlineMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.black38,
    ),
  ),

  extensions: <ThemeExtension<dynamic>>[
    const AppButtonColors(
      primaryButtonBackground: Colors.white,
      primaryButtonForeground: Color(0xFF071923),
      primarySplashColor: Colors.grey,
      secondaryButtonBackground: Colors.white38,
      secondaryButtonForeground: Colors.black,
      secondarySplashColor: Colors.white12,
      specialOperatorBackground: Colors.amber,
      specialSplashColor: Colors.amberAccent,
    ),
  ],
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: Colors.black, fontSize: 50),
    headlineMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white38,
    ),
  ),

  extensions: <ThemeExtension<dynamic>>[
    const AppButtonColors(
      primaryButtonBackground: Color(0xFF091521), // 08131D 091521
      primaryButtonForeground: Colors.white,
      primarySplashColor: Colors.white12,
      secondaryButtonBackground: Color(0xFFB5C2C9),
      secondaryButtonForeground: Colors.white,
      secondarySplashColor: Colors.white54,
      specialOperatorBackground: Color(0xFF2E9CD9), // 2E9CD9
      specialSplashColor: Colors.lightBlueAccent,
    ),
  ],
);
