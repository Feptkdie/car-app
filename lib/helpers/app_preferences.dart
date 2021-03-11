import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> getAuthNotify() async {
    final SharedPreferences prefs = await _prefs;
    var status = prefs.getBool("auth_notify") ?? false;
    return status;
  }

  Future<bool> saveAuthNotify() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool("auth_notify", true);
  }

  void removeAuthNotify() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("auth_notify");
  }
}
