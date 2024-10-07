import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/data.dart';
import '../generated/l10n.dart';
import 'permission.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _initializeNotifications();
  }

  // * Initialize notification settings
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_foodlist');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // * Get notification strings
  String _getExpiryNotificationDetails(List items) {
    print(items);
    if (items.isEmpty) {
      return S.current.none;
    }
    String notificationDetails = '';
    for (int i = 0; i < items.length; i++) {
      if (i == items.length - 1) {
        notificationDetails += items[i];
      } else if (i == 2 && items.length == 3) {
        notificationDetails += '${items[i]}';
      } else if (i == 2 && items.length > 3) {
        notificationDetails +=
            S.current.notificationMoreItems(items.length - 2);
        break;
      } else {
        notificationDetails += '${items[i]}, ';
      }
    }
    return notificationDetails;
  }

  // * Schedule a daily notification call by AlarmService
  Future<void> sendDailyNotification() async {
    final InputDataBase inputDataBase = InputDataBase();

    // * List of items that will expire today and tomorrow
    // * If item is more than 3, will show "and x more items"
    List expireToday = inputDataBase.getIngredientsExpiry(0);
    List expireTomorrow = inputDataBase.getIngredientsExpiry(1);
    String todayItems = _getExpiryNotificationDetails(expireToday);
    String tomorrowItems = _getExpiryNotificationDetails(expireTomorrow);

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        S.current.foodlistExpiryNotification,
        S.current.foodlistExpiryNotificationContent(todayItems, tomorrowItems),
        _notificationDetails(),
      );
      print('Daily notification sent');
    } catch (e) {
      print(e);
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_expiry_channel',
        'FoodList Expiry Notification',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    );
  }

  // * Toggle notifications on or off
  Future<void> toggleNotifications(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', enable);

    if (enable) {
      // * Check permission
      bool isAlarmPermissionGranted =
          await PermissionManager.checkAndRequestScheduleExactAlarmPermission();
      bool isNotificationPermissionGranted =
          await PermissionManager.checkAndRequestNotificationPermission();
      if (isAlarmPermissionGranted && isNotificationPermissionGranted) {
        print('Notifications enabled');
      } else {
        // * Cancel all notifications if permission is not granted
        await flutterLocalNotificationsPlugin.cancelAll();
        await prefs.setBool('notificationsEnabled', false);
        print('Notifications disabled');
      }
    } else {
      // * Cancel all notifications if disabled
      await flutterLocalNotificationsPlugin.cancelAll();
      print('Notifications disabled');
    }
  }

  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notificationsEnabled') ?? false;
  }
}
