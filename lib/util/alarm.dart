import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/languagedb.dart';
import '../database/sub_category.dart';
import '../generated/l10n.dart';
import 'notification.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();

  factory AlarmService() {
    return _instance;
  }

  AlarmService._internal();

  // * Initialize the AlarmManager
  Future<void> init() async {
    await AndroidAlarmManager.initialize();
  }

  // * Schedule a daily alarm at the specified time
  Future<void> scheduleDailyAlarm() async {
    DateTime selectedTime = await getAlarmTime();
    DateTime now = DateTime.now();

    if (selectedTime.isBefore(now)) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }

    await AndroidAlarmManager.periodic(
        const Duration(days: 1), 0, alarmCallback,
        startAt: selectedTime, rescheduleOnReboot: true);
    print('Scheduled daily alarm at $selectedTime');
  }

  Future<void> cancelAlarm() async {
    await AndroidAlarmManager.cancel(0);
    print('Cancelled daily alarm');
  }

  // * The callback function that runs when the alarm is triggered
  @pragma('vm:entry-point')
  static Future<void> alarmCallback() async {
    print("Alarm triggered: Updating expired food items...");

    // * Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();

    // * Initialize alarm service to load the notification icon
    await AlarmService().init();

    // * Initialize Hive and open the box before using it
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      // * Check if the adapter is already registered
      Hive.registerAdapter(SubCategoryAdapter());
    }
    await Hive.openBox('mybox');

    // * Initialize the localizations
    String locale = await LanguageDB.getLanguageWithoutContext();
    S.load(Locale(locale));

    // * Call the notification service to send the daily notification
    NotificationService notificationService = NotificationService();
    notificationService.sendDailyNotification();
    print("Alarm completed");
  }

  // * Save the selected time for alarms
  Future<void> setAlarmTime(DateTime selectedTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarmTime', selectedTime.toIso8601String());
  }

  // * Retrieve the selected time for alarms
  Future<DateTime> getAlarmTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? timeString = prefs.getString('alarmTime');
    if (timeString != null) {
      return DateTime.parse(timeString);
    } else {
      // * Default to 7 AM if no time has been set
      return DateTime.now().copyWith(hour: 7, minute: 0);
    }
  }
}
