import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User preferences that affect the whole UI. Loaded once in main().
class AppSettings {
  static final themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);

  /// Items expiring within this many days (today counts as day 1) are shown
  /// as "expiring soon". Default 2 = today and tomorrow.
  static int soonDays = 2;
  static const soonDayOptions = [1, 2, 3, 5, 7];

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode.value = ThemeMode.values[prefs.getInt('theme_mode') ?? 0];
    soonDays = prefs.getInt('soon_days') ?? 2;
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    (await SharedPreferences.getInstance()).setInt('theme_mode', mode.index);
  }

  static Future<void> setSoonDays(int days) async {
    soonDays = days;
    (await SharedPreferences.getInstance()).setInt('soon_days', days);
  }
}
