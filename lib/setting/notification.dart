import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import 'package:foodlist/util/alarm.dart';
import 'package:foodlist/util/permission.dart';
import '../generated/l10n.dart';
import '../util/notification.dart';

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
  DateTime _selectedDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    7,
    0,
  );

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
        _selectedDateTime = time;
      });
    }
  }

  // ── Toggle notification ──────────────────────────────────────────────────
  Future<void> _onToggle(bool value) async {
    await _notificationService.toggleNotifications(value);

    if (value) {
      final alarmOk =
          await PermissionManager.checkAndRequestScheduleExactAlarmPermission(
              toSetting: true);
      final notifOk =
          await PermissionManager.checkAndRequestNotificationPermission(
              toSetting: true);

      if (!alarmOk || !notifOk) {
        await _notificationService.toggleNotifications(false);
        value = false;
      } else {
        await _alarmService.scheduleDailyAlarm();
      }
    } else {
      await _alarmService.cancelAlarm();
    }

    if (mounted) setState(() => _notificationsEnabled = value);
  }

  // ── Time picker ───────────────────────────────────────────────────────────
  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blueGrey,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null && picked != _selectedTime) {
      final newDT = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        _selectedTime = picked;
        _selectedDateTime = newDT;
      });
      _alarmService.setAlarmTime(newDT);
      if (await _notificationService.areNotificationsEnabled()) {
        _alarmService.scheduleDailyAlarm();
      }
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final String hh = _selectedTime.hour.toString().padLeft(2, '0');
    final String mm = _selectedTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: SettingAppbar(title: S.of(context).notificationSetting),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),

          // ── Toggle card ────────────────────────────────────────────────
          _card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).notifications,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          S.of(context).notificationContent,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _notificationsEnabled,
                    activeColor: Colors.blueGrey,
                    onChanged: _onToggle,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Time card (only shown when enabled) ─────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _notificationsEnabled
                ? Column(
                    key: const ValueKey('timeCard'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 10),
                        child: Text(
                          S.of(context).reminderTime,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey.shade600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _selectTime,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueGrey.shade600,
                                Colors.blueGrey.shade800,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.access_time_outlined,
                                  color: Colors.white60, size: 28),
                              const SizedBox(height: 10),
                              Text(
                                '$hh : $mm',
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: 6,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  S.of(context).clickToChangeReminderTime,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : const SizedBox.shrink(key: ValueKey('hidden')),
          ),

          // ── Warning card ──────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFCA28), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_outlined,
                    color: Color(0xFFFF8F00), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    S.of(context).notificationContentWarn,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF6D4C00), height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
