import 'package:flutter/material.dart';
import 'package:calculator/Screens/calculatorScreen.dart';
import 'package:calculator/Theme/Theme_constants.dart';
import 'package:flutter/services.dart';
import 'package:calculator/Theme/ThemeManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(_themeListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _themeManager.addListener(
      _themeListener,
    ); // MyApp listens to the global _themeManager
  }

  void _themeListener() {
    if (mounted) {
      setState(() {
        // <<< VERY IMPORTANT
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    // <<< VERY IMPORTANT
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,

      initialRoute: '/calculatorScreen',
      routes: {
        '/calculatorScreen': (context) => calculatorScreen(),
        '/settingsScreen': (context) => SettingsScreen(),
      },
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            letterSpacing: 1.5,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Theme.of(context).primaryColor.withOpacity(0.5), height: 2.5,),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Light Mode"),
            value: _themeManager.themeMode == ThemeMode.light,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
            },
          ),
        ],
      ),
    );
  }
}
