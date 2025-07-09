import 'package:flutter/material.dart';
import 'package:calculator/Screens/calculatorScreen.dart';
// import 'package:calculator/Screens/settingsScreen.dart';
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
  Widget build(BuildContext context) {

    print("MYAPP_DEBUG: 6. MyApp BUILD method. Using themeMode: ${_themeManager.themeMode} for MaterialApp. Instance: ${_themeManager.hashCode}"); // <<< VERY IMPORTANT
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,

      initialRoute: '/calculatorScreen',
      routes: {
        '/calculatorScreen': (context) => calculatorScreen(),
        '/settingsScreen': (context) => settingsScreen(),
      },
    );
  }
}

class settingsScreen extends StatefulWidget {
  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {

  @override
  void dispose() {
    _themeManager.removeListener(_themeListener);
    print("MYAPP_DEBUG: dispose - Theme listener REMOVED.");
    super.dispose();
  }

  void _themeListener () {
    print("MYAPP_DEBUG: _themeListener CALLED! Mode: ${_themeManager.themeMode}");
    if (mounted) {
      setState(() {
        print("MYAPP_DEBUG: 5. setState in _themeListener EXECUTED."); // <<< VERY IMPORTANT
      });
      print("MYAPP_DEBUG: setState call COMPLETED in _themeListener.");
    } else {
      print("MYAPP_DEBUG: _themeListener called but widget NOT MOUNTED.");
    }
  }

  @override
  void initState() {
    super.initState();
    _themeManager.addListener(_themeListener);// MyApp listens to the global _themeManager
    print("MYAPP_DEBUG: initState - Listener ADDED...");
  }

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
          child: Container(color: Theme.of(context).primaryColor, height: 2.5),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
            },
          ),
        ],
      ),
    );
  }
}



