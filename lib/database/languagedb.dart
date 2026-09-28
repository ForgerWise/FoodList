import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The user's chosen UI language, stored as 'en' / 'ja' / 'zh_TW'.
class LanguageDB {
  static const String _languageKey = 'selectedLanguage';

  static const Map<String, String> languageNames = {
    'en': 'English',
    'ja': '日本語',
    'zh_TW': '繁體中文',
  };

  /// Saved language, or on first launch the device language (then saved).
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_languageKey);
    if (saved != null && languageNames.containsKey(saved)) return saved;

    final device = WidgetsBinding.instance.platformDispatcher.locale;
    final code = switch (device.languageCode) {
      'zh' => 'zh_TW', // zh, zh-Hant, zh-TW … only Traditional Chinese ships
      'ja' => 'ja',
      _ => 'en',
    };
    await setLanguage(code);
    return code;
  }

  static Future<void> setLanguage(String code) async {
    if (!languageNames.containsKey(code)) {
      throw ArgumentError.value(code, 'code', 'Unsupported language');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, code);
  }

  /// 'zh_TW' → Locale('zh', 'TW'), 'en' → Locale('en').
  static Locale languageToLocale(String code) {
    final parts = code.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }
}
