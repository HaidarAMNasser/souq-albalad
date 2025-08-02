import 'package:souq_al_balad/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static String languageCode = "ar";

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  /// language ///
  static Future<String> loadLanguage() async {
    try {
      String lang = getData(key: HEADERLANGUAGEKEY) ?? 'default';
      if (lang != "default") {
        languageCode = lang;
      } else {
        //todo change to ar to show the arabic data
        languageCode = "en";
      }
      return languageCode;
    } catch (e) {
      return "en";
    }
  }

  static saveLanguage(BuildContext context, String lang) {
    saveData(key: HEADERLANGUAGEKEY, value: lang).then((val) {
      languageCode = lang;
      MyApp.setLocale(context, Locale(lang));
    });
  }

  static changeLanguage(BuildContext context, String lang) {
    languageCode = lang;
    Locale locale = Locale(lang);
    MyApp.setLocale(context, locale);
    saveLanguage(context, lang);
    Get.updateLocale(locale);
  }

  void changeTheme({required bool isDark}) {
    CacheHelper.saveData(key: 'theme_mode', value: isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode getThemeMode() {
    bool isDark = CacheHelper.getData(key: 'theme_mode') ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  bool isDarkMode() {
    bool? savedTheme = CacheHelper.getData(key: 'theme_mode');
    if (savedTheme == null) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return savedTheme;
  }
}
