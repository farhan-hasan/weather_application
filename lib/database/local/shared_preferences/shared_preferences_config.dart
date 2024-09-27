import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig {
  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginState() async {
    return prefs.getBool('isLoggedIn') ??
        false; // Default is false if no value is found
  }

  Future<bool> checkLoginStatus() async {
    bool isLoggedIn = await getLoginState();
    return isLoggedIn;
  }
}
