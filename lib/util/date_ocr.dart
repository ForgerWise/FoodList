import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Photo of the printed date → candidate expiry dates.
///
/// Uses the system camera (image_picker) and ML Kit's Latin text recognizer
/// through a small channel in MainActivity; the model is delivered by Google
/// Play services, so the app only grows ~260 KB.
///
/// Returns null if the user cancelled, [] if no date was found. Throws
/// [PlatformException] when recognition itself failed (e.g. model not yet
/// downloaded).
Future<List<DateTime>?> readDatesWithCamera() async {
  final photo = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: 2000, // enough for small print, keeps OCR fast
    imageQuality: 90,
  );
  if (photo == null) return null;
  final text = await const MethodChannel(
    'foodlist/ocr',
  ).invokeMethod<String>('recognize', {'path': photo.path});
  return findDates(text ?? '', order: deviceDateOrder());
}

/// How the region writes all-number dates when the order is ambiguous.
enum DateOrder { ymd, dmy, mdy }

/// From the phone's region (not the app language): US-style month-first,
/// East-Asian year-first, day-first everywhere else.
DateOrder deviceDateOrder() {
  final region = PlatformDispatcher.instance.locale.countryCode ?? '';
  const mdy = {
    'US',
    'PH',
    'PR',
    'GU',
    'AS',
    'VI',
    'UM',
    'MP',
    'FM',
    'MH',
    'PW',
    'BZ',
  };
  const ymd = {'TW', 'JP', 'CN', 'KR', 'HK', 'MO', 'MN', 'HU', 'LT'};
  if (mdy.contains(region)) return DateOrder.mdy;
  if (ymd.contains(region)) return DateOrder.ymd;
  return DateOrder.dmy;
}

const _months = {
  'JAN': 1,
  'FEB': 2,
  'MAR': 3,
  'APR': 4,
  'MAY': 5,
  'JUN': 6,
  'JUL': 7,
  'AUG': 8,
  'SEP': 9,
  'SEPT': 9,
  'OCT': 10,
  'NOV': 11,
  'DEC': 12,
};

/// Every plausible date in OCR text, latest first (when a pack shows both a
/// production and an expiry date, the expiry is the later one).
///
/// Understands the formats printed in Taiwan, Japan, the US and Europe:
/// 2026.10.05 · 2026/10/5 · 2026年10月5日 · 26.10.05 · 05.10.2026 · 10/05/2026
/// · 20261005 · 05 OCT 2026 · OCT 05 2026 · 10/2026 (→ end of month).
/// All-number dates whose order is ambiguous (05/10/2026, 05.10.26) are read
/// in the region's [order]; the other reading is only used if the preferred
/// one is impossible (e.g. 25/10/2026 can only be day-first).
List<DateTime> findDates(
  String raw, {
  DateTime? now,
  DateOrder order = DateOrder.dmy,
}) {
  final today = now ?? DateTime.now();
  final from = DateTime(
    today.year,
    today.month,
    today.day,
  ).subtract(const Duration(days: 60));
  final to = DateTime(today.year + 5, today.month, today.day);

  // Typical OCR slips inside numbers: O→0, I/l→1, S→5.
  var s = raw.toUpperCase();
  s = s.replaceAllMapped(
    RegExp(r'(?<=\d)[OILS]|[OILS](?=\d)'),
    (m) => const {'O': '0', 'I': '1', 'L': '1', 'S': '5'}[m[0]]!,
  );

  final found = <DateTime>{};
  bool add(int y, int m, int d) {
    if (y < 100) y += 2000;
    if (m < 1 || m > 12 || d < 1) return false;
    final date = DateTime(y, m, d);
    if (date.month != m) return false; // 31 Feb etc.
    if (date.isBefore(from) || date.isAfter(to)) return false;
    found.add(date);
    return true;
  }

  // Ambiguous digits: try readings in the region's preferred order and keep
  // only the first that is a real, plausible date.
  void addFirst(List<(int, int, int)> readings) {
    for (final (y, m, d) in readings) {
      if (add(y, m, d)) return;
    }
  }

  void monthEnd(int y, int m) {
    if (y < 100) y += 2000;
    if (m >= 1 && m <= 12) add(y, m, DateTime(y, m + 1, 0).day);
  }

  const sep = r'\s*[./\-年月 ]\s*';
  const nd = r'(?<!\d)';
  const na = r'(?!\d)';

  // 2026.10.05 / 2026年10月5日
  for (final m in RegExp(
    '$nd(20\\d{2})$sep(\\d{1,2})$sep(\\d{1,2})$na',
  ).allMatches(s)) {
    add(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
  }
  // 05.10.2026 (EU) or 10/05/2026 (US)
  for (final m in RegExp(
    '$nd(\\d{1,2})$sep(\\d{1,2})$sep(20\\d{2})$na',
  ).allMatches(s)) {
    final a = int.parse(m[1]!), b = int.parse(m[2]!), y = int.parse(m[3]!);
    addFirst(
      order == DateOrder.mdy ? [(y, a, b), (y, b, a)] : [(y, b, a), (y, a, b)],
    );
  }
  // Two-digit years: 26.10.05 (JP/TW, year first) or 05.10.26 (EU, year last)
  for (final m in RegExp(
    '$nd(\\d{2})[./\\-](\\d{1,2})[./\\-](\\d{2})$na',
  ).allMatches(s)) {
    final a = int.parse(m[1]!), b = int.parse(m[2]!), c = int.parse(m[3]!);
    final ymd = (a, b, c), dmy = (c, b, a), mdy = (c, a, b);
    addFirst(switch (order) {
      DateOrder.ymd => [ymd, dmy, mdy],
      DateOrder.dmy => [dmy, ymd, mdy],
      DateOrder.mdy => [mdy, ymd, dmy],
    });
  }
  // 20261005
  for (final m in RegExp('$nd(20\\d{2})(\\d{2})(\\d{2})$na').allMatches(s)) {
    add(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
  }
  // 05 OCT 2026 · 05OCT26 · OCT 05 2026 · OCT 2026
  final mon = _months.keys.join('|');
  for (final m in RegExp(
    '$nd(\\d{1,2})\\s*($mon)[A-Z]*\\.?\\s*(\\d{2,4})$na',
  ).allMatches(s)) {
    add(int.parse(m[3]!), _months[m[2]]!, int.parse(m[1]!));
  }
  for (final m in RegExp(
    '\\b($mon)[A-Z]*\\.?\\s*(\\d{1,2}),?\\s+(20\\d{2})$na',
  ).allMatches(s)) {
    add(int.parse(m[3]!), _months[m[1]]!, int.parse(m[2]!));
  }
  // Month + year only: OCT 2026, 10/2026, 2026.10 (common "EXP" format)
  // → end of month. Only when no full date was printed.
  if (found.isEmpty) {
    for (final m in RegExp(
      '\\b($mon)[A-Z]*\\.?\\s*(20\\d{2})$na',
    ).allMatches(s)) {
      monthEnd(int.parse(m[2]!), _months[m[1]]!);
    }
    for (final m in RegExp('$nd(\\d{1,2})[./\\-](20\\d{2})$na').allMatches(s)) {
      monthEnd(int.parse(m[2]!), int.parse(m[1]!));
    }
    for (final m in RegExp(
      '$nd(20\\d{2})[./\\-年](\\d{1,2})$na(?![./\\-月]\\s*\\d)',
    ).allMatches(s)) {
      monthEnd(int.parse(m[1]!), int.parse(m[2]!));
    }
  }

  return found.toList()..sort((a, b) => b.compareTo(a));
}
