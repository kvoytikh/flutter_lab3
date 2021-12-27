import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  ThemeModel() {
    SharedPreferences.getInstance().then((prefs) {
      final themeModeIndex = prefs.getInt('themeModeIndex') ?? themeMode.index;
      themeMode = ThemeMode.values[themeModeIndex];
      notifyListeners();
    });
  }

  changeThemeMode(bool val) {
    SharedPreferences.getInstance().then((prefs) {
      themeMode = val ? ThemeMode.dark : ThemeMode.light;

      prefs.setInt('themeModeIndex', themeMode.index);

      notifyListeners();
    });
  }
}
