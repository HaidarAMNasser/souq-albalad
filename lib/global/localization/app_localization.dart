import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  Map<String, String>? _localizationString;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString("assets/l10n/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizationString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    final value = _localizationString?[key];
    if (value == null) {
      debugPrint("⚠️ Missing translation for key: $key");
    }
    return value ?? key;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en', 'tr', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
