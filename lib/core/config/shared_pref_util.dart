import 'package:shared_preferences/shared_preferences.dart';

// SharedPrefUtil sharedPrefUtil = SharedPrefUtil();

class SharedPrefUtil {
  // static const _kTokenKey = 'id.zicare.mobapps.token';
  // static const _kEnvKey = 'id.zicare.mobapps.key';
  // static const _kRefreshTokenKey = 'id.zicare.mobapps.refreshtoken';
  // static const _kUserKey = 'id.zicare.mobapps.user';
  // static const _kAppStat = 'id.zicare.mobapps.appstat';

  const SharedPrefUtil();

  static final String kLanguage = 'language';

  // static final _storage = new FlutterSecureStorage();

  ///-------------------------
  ///Dedicated methods
  ///------------------------

  static String? getLanguage(SharedPreferences prefs) {
    return prefs.containsKey(kLanguage) ? prefs.getString(kLanguage) : "";
  }

  static Future<bool> setLanguage(String languange, SharedPreferences prefs) {
    return prefs.setString(kLanguage, languange);
  }

  static Future<bool> getBoolSharedPreferencesWithKey(String key) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      bool? result = sharedPreference.getBool(key);
      if (result == null) {
        result = false;
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setBoolSharedPreferencesWithKey(
      String key, bool value) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      await sharedPreference.setBool(key, value);
    } catch (e) {}
  }
}
