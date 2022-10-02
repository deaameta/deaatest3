import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/data/entities/user.dart';

class AuthSharedPrefs {
  final SharedPreferences _preferences;

  AuthSharedPrefs(this._preferences);

  User getUser() {
    final id = _preferences.getInt(ID) ?? -1;
    final firstName = _preferences.getString(FIRSTNAME) ?? "";
    final lastName = _preferences.getString(LASTNAME) ?? "";
    final email = _preferences.getString(EMAIL) ?? "";
    final phone = _preferences.getString(MOBILE) ?? "";
    final createdAt = _preferences.getString(CREATEDAT) ?? "";
    final String token = _preferences.getString(TOKEN) ?? "";

    return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phone,
        createdAt: createdAt,
        token: token);
  }

  Future<void> saveUser(User user) async {
    _preferences.setInt(ID, user.id ?? -1);
    _preferences.setString(FIRSTNAME, user.firstName ?? "");
    _preferences.setString(LASTNAME, user.lastName ?? "");
    _preferences.setString(EMAIL, user.email ?? "");
    _preferences.setString(MOBILE, user.phoneNumber ?? "");
    _preferences.setString(CREATEDAT, user.createdAt ?? "");

    if (user.token != null) {
      saveUserToken(
        user.token!,
      );
    }
  }

  /// Delete user information
  Future<void> deleteUser() async {
    _preferences.remove(ID);
    _preferences.remove(FIRSTNAME);
    _preferences.remove(LASTNAME);
    _preferences.remove(EMAIL);
    _preferences.remove(MOBILE);
    _preferences.remove(CREATEDAT);
    _preferences.remove(TOKEN);
    _preferences.remove(VERIFIED);
  }

  saveUserToken(
    String token,
  ) {
    _preferences.setString(TOKEN, token);
  }

  Future<bool> logout() async {
    deleteUser();
    return (_preferences.clear());
  }

  // Check if user has token or not
  Future<bool> hasToken() async {
    String? token = await _preferences.getString(TOKEN);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
