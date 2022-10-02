import 'package:shared_preferences/shared_preferences.dart';
import 'package:nft_deaa/src/core/app_constants.dart';

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  bool? getTheme() {
    return _preferences.getBool(THEME);
  }

  void setTheme(bool isDark) {
    _preferences.setBool(THEME, isDark);
  }

  String? getLang() {
    return _preferences.getString("lang");
  }

  void setLang(String local) {
    _preferences.setString("lang", local);
  }
}
