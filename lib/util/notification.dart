import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/data.dart';
import '../generated/l10n.dart';
import 'permission.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _initializeNotifications();
  }

  // ── Initialization ─────────────────────────────────────────────────────────
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_stat_foodlist');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false, // handled by PermissionManager
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Ensure the notification channel exists (Android 8.0+)
    await _createNotificationChannel();
  }

  /// Explicitly create the channel so it is guaranteed to exist
  /// even before the first notification is shown.
  Future<void> _createNotificationChannel() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_expiry_channel',
      'FoodList Daily Reminder',
      description: 'Daily reminder for food items that are expiring soon.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await androidPlugin.createNotificationChannel(channel);
  }

  // ── Notification content helpers ───────────────────────────────────────────

  /// Formats a list of item names into a compact display string.
  /// Shows up to 3 names; if more, appends "and N more".
  String _formatItemList(List items) {
    if (items.isEmpty) return S.current.none;

    if (items.length <= 3) {
      return items.join(', ');
    }

    // Show first 2 names + "and N more"
    final shown = items.take(2).join(', ');
    return '$shown, ${S.current.notificationMoreItems(items.length - 2)}';
  }

  // ── Send notification ──────────────────────────────────────────────────────

  /// Called by the alarm callback to send today's expiry summary.
  Future<void> sendDailyNotification() async {
    final InputDataBase db = InputDataBase();
    await db.loadData();

    final List expireToday = db.getIngredientsExpiry(0);
    final List expireTomorrow = db.getIngredientsExpiry(1);

    final String todayText = _formatItemList(expireToday);
    final String tomorrowText = _formatItemList(expireTomorrow);

    // Build a rich expanded body for BigTextStyle
    final String expandedBody =
        '📅 ${S.current.summaryExpiringSoon} (${S.current.expiresToday.replaceAll('!', '')}): $todayText\n'
        '🗓 ${S.current.summaryExpiringSoon} (${S.current.expiresTomorrow.replaceAll('!', '')}): $tomorrowText';

    // Concise one-liner shown in collapsed state
    final String collapsedBody =
        S.current.foodlistExpiryNotificationContent(todayText, tomorrowText);

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        S.current.foodlistExpiryNotification,
        collapsedBody,
        _buildNotificationDetails(
          expandedBody: expandedBody,
          todayCount: expireToday.length,
          tomorrowCount: expireTomorrow.length,
        ),
      );
      debugPrint('Notification sent successfully');
    } catch (e, stack) {
      debugPrint('Error sending notification: $e\n$stack');
    }
  }

  // ── Notification style ─────────────────────────────────────────────────────

  NotificationDetails _buildNotificationDetails({
    required String expandedBody,
    required int todayCount,
    required int tomorrowCount,
  }) {
    // Accent color matching the app's blueGrey theme
    const int accentColor = 0xFF546E7A; // Colors.blueGrey[600]

    // Sub-text shown below the app name on Android 7+
    final String subText =
        todayCount > 0 ? '⚠ $todayCount item(s) expiring today' : null ?? '';

    final BigTextStyleInformation bigTextStyle = BigTextStyleInformation(
      expandedBody,
      htmlFormatBigText: false,
      contentTitle: S.current.foodlistExpiryNotification,
      summaryText: subText.isEmpty ? null : subText,
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_expiry_channel',
        'FoodList Daily Reminder',
        channelDescription:
            'Daily reminder for food items that are expiring soon.',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@drawable/ic_stat_foodlist',
        color: const Color(accentColor),
        // Ticker text read aloud by accessibility services
        ticker: S.current.foodlistExpiryNotification,
        // BigText style shows full content when expanded
        styleInformation: bigTextStyle,
        // Show a badge count on the launcher icon (today's expiring items)
        number: todayCount > 0 ? todayCount : null,
        playSound: true,
        enableVibration: true,
        // Show timestamp only if there are items expiring today
        showWhen: todayCount > 0,
        // Group notifications from this app together
        groupKey: 'com.forgerwise.foodlist.expiry',
        // Category: reminder type gives correct OS-level treatment
        category: AndroidNotificationCategory.reminder,
        visibility: NotificationVisibility.public,
      ),
    );
  }

  // ── State management ───────────────────────────────────────────────────────

  /// Toggle notifications on or off.
  /// Permission check is handled by the caller (NotificationSettingPage._onToggle)
  /// to avoid double-requesting the same permission.
  Future<void> toggleNotifications(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', enable);

    if (!enable) {
      await flutterLocalNotificationsPlugin.cancelAll();
      debugPrint('Notifications disabled');
    } else {
      debugPrint('Notifications enabled');
    }
  }

  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getBool('notificationsEnabled');
    if (stored == null) {
      await prefs.setBool('notificationsEnabled', false);
      return false;
    }
    if (!stored) return false;

    // Only check POST_NOTIFICATIONS permission (no exact alarm needed)
    final notifGranted =
        await PermissionManager.checkAndRequestNotificationPermission();
    if (!notifGranted) {
      await prefs.setBool('notificationsEnabled', false);
      return false;
    }
    return true;
  }
}
