import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDB {
  static const String _languageKey = 'selectedLanguage';

  static const Map<String, String> languageNames = {
    'en': 'English',
    'ja': '日本語',
    'zh_TW': '繁體中文',
  };

  static const Map<String, String> systemLanguageCodeToL10nCodeMap = {
    'en': 'en',
    'ja': 'ja',
    'zh-Hant': 'zh_TW',
    'zh_TW': 'zh_TW', // * For older versions of app
    'zh-TW': 'zh_TW',
    'zh': 'zh_TW', // * For some versions of phone
    'zh_Hant': 'zh_TW' // * For some versions of phone
  };

  static const List<String> notFinishedLanguages = [];

  static Future<void> setLanguage(String languageCode,
      {String? countryCode}) async {
    if (!languageNames.containsKey(languageCode)) {
      throw Exception('Language code is not valid');
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    }
  }

  static Future<String> getLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_languageKey)) {
      final locale = Localizations.localeOf(context);
      final systemLanguageCode = locale.languageCode;

      if (systemLanguageCodeToL10nCodeMap.containsKey(systemLanguageCode)) {
        String l10nCode = systemLanguageCodeToL10nCodeMap[systemLanguageCode]!;
        await setLanguage(l10nCode);
        return l10nCode;
      } else {
        await setLanguage('en');
        return 'en';
      }
    }

    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<String> getLanguageWithoutContext() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_languageKey)) {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final systemLanguageCode = systemLocale.languageCode;

      if (systemLanguageCodeToL10nCodeMap.containsKey(systemLanguageCode)) {
        String l10nCode = systemLanguageCodeToL10nCodeMap[systemLanguageCode]!;
        await setLanguage(l10nCode);
        return l10nCode;
      } else {
        await setLanguage('en');
        return 'en';
      }
    }

    return prefs.getString(_languageKey) ?? 'en';
  }

  static Locale languageToLocale(String languageCode) {
    try {
      if (languageCode.isEmpty) {
        throw ArgumentError('languageCode cannot be empty');
      }

      if (!languageCode.contains("_")) {
        return Locale(languageCode);
      }

      List<String> parts = languageCode.split('_');
      return Locale.fromSubtags(
        languageCode: parts[0],
        countryCode: parts[1],
      );
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static List<String> getNotFinishedLanguages() {
    return notFinishedLanguages;
  }

  static List<String> getLanguagesList() {
    return languageNames.keys.toList();
  }
}
