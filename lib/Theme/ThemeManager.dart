import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

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
    print("ThemeManager themeMode: $themeMode. current mode: $_themeMode");
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    print("ThemeManager themeMode: $themeMode. current mode: $_themeMode");
    notifyListeners();
    print("TM_SET: 3. notifyListeners() CALLED!");
  }
}
