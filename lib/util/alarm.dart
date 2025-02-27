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
    debugPrint('Scheduled daily alarm at $selectedTime');
  }

  Future<void> cancelAlarm() async {
    await AndroidAlarmManager.cancel(0);
    debugPrint('Cancelled daily alarm');
  }

  // * The callback function that runs when the alarm is triggered
  @pragma('vm:entry-point')
  static Future<void> alarmCallback() async {
    debugPrint("Alarm triggered: Updating expired food items...");

    // * Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();

    // * Initialize alarm service to load the notification icon
    await AlarmService().init();

    //* Check the time now, reschedule if it is called just because of reboot
    //* If this is a reboot, cancel the alarm and reschedule it
    DateTime selectedTime = await AlarmService().getAlarmTime();
    DateTime now = DateTime.now();
    // * If time now is before the selected time, reschedule the alarm and return
    if (now.isBefore(selectedTime)) {
      await AlarmService().cancelAlarm();
      await AlarmService().scheduleDailyAlarm();
      return;
    }
    // * If the time if after the selected time 30 minutes, reschedule the alarm but keep the notification
    else if (now.isAfter(selectedTime.add(const Duration(minutes: 30)))) {
      await AlarmService().cancelAlarm();
      await AlarmService().scheduleDailyAlarm();
    }
    // * Otherwise, continue with the alarm

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
    debugPrint("Alarm completed");
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

    // * If the time is not set, return the default time
    if (timeString == null) {
      return DateTime.now().copyWith(hour: 7, minute: 0);
    }

    // * Change the date to today but keep the time
    DateTime time = DateTime.parse(timeString);
    DateTime now = DateTime.now();
    return time.copyWith(year: now.year, month: now.month, day: now.day);
  }
}
