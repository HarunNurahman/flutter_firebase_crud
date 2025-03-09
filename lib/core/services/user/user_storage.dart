import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String _userKey = 'user_session_key';

  static Future<void> saveUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userKey);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> removeUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> isUserLoggedIn() async {
    final userId = await getUser();
    return userId != null;
  }
}
