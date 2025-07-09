import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  get themeMode => _themeMode;

  // void setThemeMode(ThemeMode mode){
  //   print("ThemeManager themeMode: $mode. current mode: $_themeMode");
  //   if(_themeMode != mode){
  //     print("ThemeManager themeMode: $_themeMode. Notifying listeners");
  //   _themeMode = mode;
  //   print("Theme Manager new themeMode: $_themeMode");
  //   notifyListeners();
  //   } else if(_themeMode == mode){
  //     print("Not notifying");
  //   }
  // }
  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
