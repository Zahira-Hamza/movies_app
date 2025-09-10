import 'dart:developer';

import 'package:movies_app/core/constants/constants.dart';
import 'package:movies_app/core/constants/errors/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefLocalDataSources {
  Future<void> saveToken(String token) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(Constants.tokenKey, token);
      log(token);
    } catch (exception) {
      throw const SharedPrefException('Failed to save token');
    }
  }

  Future<String> getToken() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getString(Constants.tokenKey)!;
    } catch (exception) {
      throw const SharedPrefException('Failed to get token');
    }
  }
}
