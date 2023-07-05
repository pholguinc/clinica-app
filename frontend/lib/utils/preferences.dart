

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

String? getAuthToken() {
  return prefs?.getString('jwt_token');
  
}



