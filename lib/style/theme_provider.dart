import 'package:flutter/material.dart';
import 'theme_data/dark_theme.dart';
import 'theme_data/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkMode) {
      setTheme(lightTheme);
    } else {
      setTheme(darkTheme);
    }
  }

  static ThemeData determineDefaultTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
}
