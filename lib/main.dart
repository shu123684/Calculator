import 'package:flutter/material.dart';
import 'package:calculator/calculatorScreen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black87,
      ),

      initialRoute: '/calculatorScreen',
      routes: {
        '/calculatorScreen': (context) => calculatorScreen(),
      },
    ),
  );
}
