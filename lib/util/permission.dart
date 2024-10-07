import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> checkAndRequestPermission(Permission permission,
      {bool toSetting = false}) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted;
    } else if (status.isPermanentlyDenied) {
      if (toSetting) {
        openAppSettings();
      }
      return false;
    }
    return false;
  }

  static Future<bool> checkAndRequestScheduleExactAlarmPermission(
      {bool toSetting = false}) {
    return checkAndRequestPermission(Permission.scheduleExactAlarm,
        toSetting: toSetting);
  }

  static Future<bool> checkAndRequestNotificationPermission(
      {bool toSetting = false}) {
    return checkAndRequestPermission(Permission.notification,
        toSetting: toSetting);
  }
}
