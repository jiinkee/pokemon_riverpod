import 'package:shared_preferences/shared_preferences.dart';

// the singleton class for shared preferences
// unable to put it inside locator sad
class AppSharedPrefs {
  static Future<SharedPreferencesWithCache> get _asyncPref => SharedPreferencesWithCache.create(cacheOptions: SharedPreferencesWithCacheOptions());

  static Future<List<String>> getStringList(String key, [List<String>? defaultVal]) async {
    final prefs = await _asyncPref;
    return prefs.getStringList(key) ?? defaultVal ?? [];
  }

  static Future<void> setStringList(String key, List<String> list) async {
    final prefs = await _asyncPref;
    return prefs.setStringList(key, list);
  }
}