import 'package:hive_flutter/hive_flutter.dart';

import '../util/app_settings.dart';
import 'category.dart';
import 'sub_category.dart';

/// Opens local storage. Call before any database access, in the main isolate
/// and in the alarm's background isolate.
Future<void> openStorage() async {
  await Hive.initFlutter();
  // Pre-v3 builds stored SubCategory objects. Hive decodes every record in a
  // box on open, so this adapter must stay registered even though the data is
  // deleted on load — otherwise upgrading from those versions crashes.
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(SubCategoryAdapter());
  if (!Hive.isBoxOpen('mybox')) await Hive.openBox('mybox');
}

enum ExpiryStatus { expired, soon, fresh }

/// One fridge item. Stored in Hive as a plain list so the on-disk format of
/// every released version keeps working:
///   [categoryKey, name, 'yyyy/MM/dd', quantity]
class Ingredient {
  final String categoryKey;
  final String name;
  final DateTime expiry; // date only
  final int quantity;

  const Ingredient(this.categoryKey, this.name, this.expiry, this.quantity);

  static DateTime get _today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  /// 'yyyy/MM/dd' (also tolerates missing zero padding and '-').
  static DateTime parseDate(String s) {
    final p = s.split(RegExp('[/-]')).map(int.parse).toList();
    return DateTime(p[0], p[1], p[2]);
  }

  static String formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';

  /// Returns null for rows that cannot be understood.
  static Ingredient? tryFromList(dynamic row) {
    try {
      if (row is! List || row.length < 3) return null;
      // v1 format: [categoryDisplayName, subcategory, inputDate, expireDate]
      if (row.length >= 4 && row[3] is String) {
        return Ingredient(
          legacyCategoryKey(row[0] as String),
          row[1] as String,
          parseDate(row[3] as String),
          1,
        );
      }
      return Ingredient(
        row[0] as String,
        row[1] as String,
        parseDate(row[2] as String),
        row.length > 3 && row[3] is int ? row[3] as int : 1,
      );
    } catch (_) {
      return null;
    }
  }

  List toList() => [categoryKey, name, formatDate(expiry), quantity];

  String get expdate => formatDate(expiry);

  /// Negative = already expired, 0 = today.
  int get daysLeft => expiry.difference(_today).inDays;

  ExpiryStatus get status {
    final d = daysLeft;
    if (d < 0) return ExpiryStatus.expired;
    if (d < AppSettings.soonDays) return ExpiryStatus.soon;
    return ExpiryStatus.fresh;
  }
}

/// The fridge contents, persisted in Hive under INGREDIENTS_LIST.
class InputDataBase {
  static const _key = 'INGREDIENTS_LIST';

  List<Ingredient> items = [];

  // Rows we could not parse are kept untouched and written back, so a bug or
  // unknown future format never silently deletes user data.
  List _unparsed = [];

  // Getter, not a field: the box must already be open (matters in the alarm
  // callback's background isolate).
  Box get _box => Hive.box('mybox');

  Future<void> loadData() async {
    final raw = (_box.get(_key) as List?) ?? const [];
    items = [];
    _unparsed = [];
    var migrated = false;
    for (final row in raw) {
      final item = Ingredient.tryFromList(row);
      if (item == null) {
        _unparsed.add(row);
      } else if (_isOldSample(item)) {
        migrated = true; // drop the tutorial row older versions inserted
      } else {
        items.add(item);
        if (row is List && row.length >= 4 && row[3] is String) migrated = true;
      }
    }
    _sort();
    if (migrated) await updateData(); // persist v1 → v2 migration once
  }

  // Up to v3.0.x first launch added "Slide to delete" expiring 2999/09/29.
  // Onboarding is a dialog now (see showOnboardingIfNeeded).
  static bool _isOldSample(Ingredient i) =>
      i.expiry == DateTime(2999, 9, 29) &&
      const ['滑動以刪除', 'Slide to Delete', 'スライドして削除'].contains(i.name);

  void _sort() => items.sort((a, b) => a.expiry.compareTo(b.expiry));

  Future<void> updateData() async {
    _sort();
    await _box.put(_key, [for (final i in items) i.toList(), ..._unparsed]);
  }

  /// Re-files every item of category [from] under [to].
  Future<void> moveCategory(String from, String to) async {
    await loadData();
    items = [
      for (final i in items)
        i.categoryKey == from
            ? Ingredient(to, i.name, i.expiry, i.quantity)
            : i,
    ];
    await updateData();
  }

  /// Index of the first item equal to [target] (all fields), or -1.
  int indexOf(Ingredient target) => items.indexWhere(
    (i) =>
        i.categoryKey == target.categoryKey &&
        i.name == target.name &&
        i.expiry == target.expiry &&
        i.quantity == target.quantity,
  );

  Map<ExpiryStatus, int> getStats() {
    final stats = {for (final s in ExpiryStatus.values) s: 0};
    for (final i in items) {
      stats[i.status] = stats[i.status]! + 1;
    }
    return stats;
  }

  /// Names of items expiring exactly [days] days from today (0 = today).
  List<String> namesExpiringIn(int days) => [
    for (final i in items)
      if (i.daysLeft == days) i.name,
  ];
}
