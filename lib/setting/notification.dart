import 'package:flutter/material.dart';
import 'package:foodlist/util/alarm.dart';
import '../generated/l10n.dart';
import '../util/notification.dart';
import '../database/data.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({Key? key}) : super(key: key);

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  // * Initialize notification service
  final NotificationService notificationService = NotificationService();
  final InputDataBase inputDataBase = InputDataBase();
  final AlarmService alarmService = AlarmService();

  // * Initialize selected time to 7 AM
  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 0);
  DateTime selectedTimeDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    7,
    0,
  );

  @override
  void initState() {
    super.initState();
    // * Load notification time
    _loadSelectedTime();
  }

  // * Function to load the selected time
  Future<void> _loadSelectedTime() async {
    DateTime? time = await alarmService.getAlarmTime();
    setState(() {
      selectedTime = TimeOfDay.fromDateTime(time);
      selectedTimeDateTime = time;
    });
  }

  // * Function to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(
        () {
          selectedTime = picked;
          selectedTimeDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            selectedTime.hour,
            selectedTime.minute,
          );
          alarmService.setAlarmTime(selectedTimeDateTime);
        },
      );
      if (await notificationService.areNotificationsEnabled()) {
        alarmService.scheduleDailyAlarm();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notificationSetting),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).selectedTime(
                          selectedTime.hour.toString().padLeft(2, '0'),
                          selectedTime.minute.toString().padLeft(2, '0')),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Icon(Icons.access_time, size: 24),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).notificationContent,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            // * A icon of Priority High to explain why the notification may be delayed
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.red[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.priority_high, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        S.of(context).notificationContentWarn,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
