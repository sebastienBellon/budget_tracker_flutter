import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  bool _darkTheme = true;

  ThemeService(this.sharedPreferences);

  static const darkThemeKey = "dark_theme";

  bool get darkTheme {
    // get the value from local storage and if it isn't defined
    // take a default value
    return sharedPreferences.getBool(darkThemeKey) ?? _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    // every time we change the dark theme value we save it to shared_preferences
    sharedPreferences.setBool(darkThemeKey, value);
    notifyListeners();
  }
}
