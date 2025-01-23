import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../setting/edit_categories.dart';
import '../setting/faq.dart';
import '../setting/feedback.dart';
import '../setting/language.dart';
import '../setting/notification.dart';
import '../setting/policy.dart';
import '../setting/about.dart';
import '../util/alarm.dart';
import '../util/notification.dart';
import '../util/permission.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NotificationService notificationService = NotificationService();
  final AlarmService alarmService = AlarmService();
  final String email = "forgerwise@gmail.com";
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    // * Load notification setting
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    bool isEnabled = await notificationService.areNotificationsEnabled();
    setState(() {
      notificationsEnabled = isEnabled;
    });
  }

  Future<void> _setNotificationSetting() async {
    bool isEnabled = await notificationService.areNotificationsEnabled();
    bool isAlarmPermissionGranted =
        await PermissionManager.checkAndRequestScheduleExactAlarmPermission(
            toSetting: true);
    bool isNotificationPermissionGranted =
        await PermissionManager.checkAndRequestNotificationPermission(
            toSetting: true);

    if (isEnabled &&
        (!isAlarmPermissionGranted || !isNotificationPermissionGranted)) {
      await notificationService.toggleNotifications(false);
      isEnabled = false;
    }

    setState(() {
      notificationsEnabled = isEnabled;
    });

    // * Schedule notification if permission is granted
    if (isEnabled &&
        isAlarmPermissionGranted &&
        isNotificationPermissionGranted) {
      await alarmService.scheduleDailyAlarm();
    } else if (!isEnabled &&
        isAlarmPermissionGranted &&
        isNotificationPermissionGranted) {
      await alarmService.cancelAlarm();
    }
  }

  Widget buildSettingTile(
      BuildContext context, IconData icon, String title, Widget page,
      {bool tappable = true}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 24),
      title: Text(title,
          style: const TextStyle(color: Colors.black, fontSize: 24)),
      onTap: tappable
          ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              )
          : null,
    );
  }

  Widget buildNotificationTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications, color: Colors.black, size: 24),
      title: Text(S.of(context).notifications,
          style: const TextStyle(color: Colors.black, fontSize: 24)),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NotificationSettingPage()),
      ),
      trailing: Switch(
        value: notificationsEnabled,
        activeTrackColor: Colors.blueGrey,
        onChanged: (value) async {
          await notificationService.toggleNotifications(value);
          _setNotificationSetting();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(S.of(context).settings,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            buildSettingTile(context, Icons.language, S.of(context).languages,
                const LanguagePage()),
            const Divider(),
            buildNotificationTile(context),
            const Divider(),
            buildSettingTile(context, Icons.edit,
                S.of(context).editResetCategories, const EditCategoriesPage()),
            const Divider(),
            buildSettingTile(
                context, Icons.help, S.of(context).faq, const FAQPage()),
            const Divider(),
            buildSettingTile(context, Icons.policy, S.of(context).policy,
                const PolicyPage()),
            const Divider(),
            buildSettingTile(
                context, Icons.info, S.of(context).about, const AboutPage()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackPage()),
        ),
        label: Text(S.of(context).feedback,
            style: const TextStyle(color: Colors.white)),
        icon: const Icon(Icons.rate_review, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
