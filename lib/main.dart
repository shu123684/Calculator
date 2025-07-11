import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Screen
import 'Calculator/Screen/calculatorScreen.dart';
import 'Chat/Screens/ChattingScreen.dart';
import 'Chat/Screens/SplashScreen.dart';
import 'Chat/Screens/auth/loginScreen.dart';

// Theme
import 'Theme/Theme_constants.dart';
import 'Theme/ThemeManager.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Global Initialisation
late Size mq;

ThemeManager _themeManager = ThemeManager();

void main() {

  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  // Initializing Firebase
  _initializeFirebase();

  // Setting the orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the app
  runApp(MyApp());
}

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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // <<< VERY IMPORTANT
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,

      initialRoute: '/splashScreen',
      routes: {
        '/calculatorScreen': (context) => calculatorScreen(),
        '/settingsScreen': (context) => SettingsScreen(),
        // Chatting App
        '/chattingScreen': (context) => ChattingScreen(),
        '/loginScreen' : (context) => LoginScreen(),
        '/splashScreen' : (context) => SplashScreen(),
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
            fontSize: 25,
            letterSpacing: 1.5,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            height: 2.3,
            margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
          ),
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

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
