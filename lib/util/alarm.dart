import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/languagedb.dart';
import '../database/data.dart';
import '../generated/l10n.dart';
import 'notification.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TOP-LEVEL callback — MUST be a top-level function (not a static method)
// for android_alarm_manager_plus to locate it reliably in release builds.
// @pragma('vm:entry-point') prevents Dart's tree-shaker from removing it.
// ─────────────────────────────────────────────────────────────────────────────
@pragma('vm:entry-point')
Future<void> alarmCallback() async {
  debugPrint('Alarm triggered: Updating expired food items...');

  // Initialize Flutter bindings (required in background isolate)
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await openStorage();

    // Load locale safely — fall back to 'en' on any error
    String locale;
    try {
      locale = await LanguageDB.getLanguage();
    } catch (_) {
      locale = 'en';
    }
    await S.load(LanguageDB.languageToLocale(locale));

    // Send the notification
    final notificationService = NotificationService();
    await notificationService.init();
    await notificationService.sendDailyNotification();

    debugPrint('Alarm completed successfully');
  } catch (e, stack) {
    debugPrint('Alarm callback error: $e\n$stack');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AlarmService
// ─────────────────────────────────────────────────────────────────────────────
class AlarmService {
  static final AlarmService _instance = AlarmService._internal();

  factory AlarmService() => _instance;

  AlarmService._internal();

  /// Must be called once in main() before runApp.
  Future<void> init() async {
    await AndroidAlarmManager.initialize();
  }

  /// Schedule (or reschedule) the daily inexact alarm.
  /// Uses inexact alarm to avoid requiring SCHEDULE_EXACT_ALARM permission.
  /// Android may delay the alarm by a few minutes for battery efficiency.
  Future<void> scheduleDailyAlarm() async {
    DateTime selectedTime = await getAlarmTime();
    final DateTime now = DateTime.now();

    // If the selected time has already passed today, schedule for tomorrow
    if (selectedTime.isBefore(now)) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }

    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      0,
      alarmCallback, // top-level function reference
      startAt: selectedTime,
      exact: false, // inexact: no special permission needed
      wakeup: true, // wake the device so notification is delivered
      rescheduleOnReboot: true,
    );

    debugPrint('Scheduled daily inexact alarm at $selectedTime');
  }

  Future<void> cancelAlarm() async {
    await AndroidAlarmManager.cancel(0);
    debugPrint('Cancelled daily alarm');
  }

  /// Persist the user-chosen alarm time (time-of-day only; date is ignored).
  Future<void> setAlarmTime(DateTime selectedTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarmTime', selectedTime.toIso8601String());
  }

  /// Load the persisted alarm time and return it adjusted to today's date.
  Future<DateTime> getAlarmTime() async {
    final prefs = await SharedPreferences.getInstance();
    final String? timeString = prefs.getString('alarmTime');

    if (timeString == null) {
      // Default: 07:00 today
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, 7, 0, 0);
    }

    final DateTime saved = DateTime.parse(timeString);
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, saved.hour, saved.minute, 0);
  }
}
