import 'package:flutter/material.dart';
import 'package:calculator/calculatorScreen.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
