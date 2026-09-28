import 'package:flutter/material.dart';
import 'package:foodlist/util/alarm.dart';
import 'package:foodlist/util/permission.dart';
import '../generated/l10n.dart';
import '../util/app_scaffold.dart';
import '../util/notification.dart';
import '../util/theme.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({Key? key}) : super(key: key);

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  final NotificationService _notificationService = NotificationService();
  final AlarmService _alarmService = AlarmService();

  bool _notificationsEnabled = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final enabled = await _notificationService.areNotificationsEnabled();
    final time = await _alarmService.getAlarmTime();
    if (mounted) {
      setState(() {
        _notificationsEnabled = enabled;
        _selectedTime = TimeOfDay.fromDateTime(time);
      });
    }
  }

  // ── Toggle notification ──────────────────────────────────────────────────
  Future<void> _onToggle(bool value) async {
    if (value) {
      // * Check notification permission before saving state (prevents race condition)
      final notifOk =
          await PermissionManager.checkAndRequestNotificationPermission(
            toSetting: true,
          );

      if (!notifOk) {
        // Permission denied — do not change state
        if (mounted) setState(() => _notificationsEnabled = false);
        return;
      }

      await _notificationService.toggleNotifications(true);
      await _alarmService.scheduleDailyAlarm();
    } else {
      await _notificationService.toggleNotifications(false);
      await _alarmService.cancelAlarm();
    }

    if (mounted) setState(() => _notificationsEnabled = value);
  }

  // ── Time picker ───────────────────────────────────────────────────────────
  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      final newDT = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );
      setState(() => _selectedTime = picked);
      _alarmService.setAlarmTime(newDT);
      if (await _notificationService.areNotificationsEnabled()) {
        _alarmService.scheduleDailyAlarm();
      }
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AppScaffold(
      appBar: AppBar(title: Text(s.notificationSetting)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SwitchListTile(
                  value: _notificationsEnabled,
                  onChanged: _onToggle,
                  activeThumbColor: AppColors.primary,
                  secondary: _icon(Icons.notifications_outlined),
                  title: Text(s.notifications),
                  subtitle: Text(
                    s.notificationContent,
                    style: TextStyle(fontSize: 12, color: context.c.textMuted),
                  ),
                ),
                if (_notificationsEnabled) ...[
                  const Divider(height: 1, indent: 72),
                  ListTile(
                    leading: _icon(Icons.access_time_outlined),
                    title: Text(s.reminderTime),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedTime.format(context), // 12h/24h per locale
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.c.accent,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: context.c.textMuted),
                      ],
                    ),
                    onTap: _selectTime,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Battery-optimisation note: tinted, not a fixed cream box, so it
          // also reads well in dark mode.
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.soon.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: context.c.soonText, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    s.notificationContentWarn,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: context.c.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) => Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: context.c.accent, size: 20),
  );
}
