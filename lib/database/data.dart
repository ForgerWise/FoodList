import 'package:hive_flutter/hive_flutter.dart';

import '../generated/l10n.dart';

class InputDataBase {
  List ingredientsList = [];

  final _myBox = Hive.box("mybox");

  // New format: [categoryKey, customName, expireDate, quantity]
  // Old format: [categoryDisplayName, subcategoryName, inputDate, expireDate]
  // Detection: old format has a String at index 3 (expireDate), new has an int (quantity)

  bool _isOldFormat(dynamic item) {
    if (item is List && item.length >= 4) {
      return item[3] is String;
    }
    return false;
  }

  List _migrateItem(dynamic item) {
    // Old: [categoryDisplay, subcategory, inputDate, expireDate]
    // New: [categoryKey, customName, expireDate, quantity=1]
    String categoryKey = _resolveCategoryKey(item[0] as String);
    String customName = item[1] as String;
    String expireDate = item[3] as String;
    return [categoryKey, customName, expireDate, 1];
  }

  // Map known display names (all languages) back to their internal keys
  String _resolveCategoryKey(String displayName) {
    const Map<String, List<String>> knownNames = {
      'meat': ['Meat', '肉類', '肉類'],
      'fish': ['Fish', '魚類', '魚'],
      'vegetable': ['Vegetable', '蔬菜', '野菜'],
      'fruit': ['Fruit', '水果', '果物'],
      'bean': ['Bean', '豆類', '豆類'],
      'eggMilk': ['Egg & Milk', '蛋奶', '卵と乳製品'],
      'mushroom': ['Mushroom', '菇類', 'キノコ'],
      'processedfood': ['Processed Food', '加工食品', '加工食品'],
      'others': ['Others', '其他', 'その他'],
    };
    for (final entry in knownNames.entries) {
      if (entry.value.contains(displayName)) return entry.key;
    }
    // Custom category or unrecognised — use display name as-is
    return displayName;
  }

  Future<void> createInitialData() async {
    ingredientsList = [
      ['others', S.current.slideToDelete, '2999/09/29', 1],
    ];
    await _myBox.put("INGREDIENTS_LIST", ingredientsList);
  }

  int compareIngredients(a, b) {
    // Both formats: expireDate is at index 2 after migration
    // But during mixed state guard with try/catch
    try {
      final String expA = a[2] as String;
      final String expB = b[2] as String;
      return DateTime.parse(expA.replaceAll("/", "-"))
          .compareTo(DateTime.parse(expB.replaceAll("/", "-")));
    } catch (_) {
      return 0;
    }
  }

  Future<void> loadData() async {
    List rawList = _myBox.get("INGREDIENTS_LIST", defaultValue: []);

    // Migrate old-format items if any exist
    bool needsMigration = rawList.any((item) => _isOldFormat(item));
    if (needsMigration) {
      rawList = rawList.map((item) {
        return _isOldFormat(item) ? _migrateItem(item) : item;
      }).toList();
      await _myBox.put("INGREDIENTS_LIST", rawList);
    }

    ingredientsList = rawList;
    ingredientsList.sort(compareIngredients);
  }

  Future<void> updateData() async {
    ingredientsList.sort(compareIngredients);
    _myBox.put("INGREDIENTS_LIST", ingredientsList);
  }

  List editData(int index, String categoryKey, String name, String expdate,
      int quantity, List ingredientsList) {
    ingredientsList[index][0] = categoryKey;
    ingredientsList[index][1] = name;
    ingredientsList[index][2] = expdate;
    ingredientsList[index][3] = quantity;
    return ingredientsList;
  }

  int searchIndex(
      String categoryKey, String name, String expdate, List ingredientsList) {
    for (int i = 0; i < ingredientsList.length; i++) {
      if (ingredientsList[i][0] == categoryKey &&
          ingredientsList[i][1] == name &&
          ingredientsList[i][2] == expdate) {
        return i;
      }
    }
    return -1;
  }

  /// Returns summary counts for the home page header.
  Map<String, int> getStats() {
    int expired = 0, expiringSoon = 0, fresh = 0;
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime twoDaysLater = today.add(const Duration(days: 2));

    for (final item in ingredientsList) {
      try {
        final exp = DateTime.parse((item[2] as String).replaceAll("/", "-"));
        final expDay = DateTime(exp.year, exp.month, exp.day);
        if (expDay.isBefore(today)) {
          expired++;
        } else if (expDay.isBefore(twoDaysLater)) {
          expiringSoon++;
        } else {
          fresh++;
        }
      } catch (_) {
        // skip malformed items
      }
    }
    return {'expired': expired, 'expiringSoon': expiringSoon, 'fresh': fresh};
  }

  /// Used by the notification service — returns customName for expiring items.
  List getIngredientsExpiry(int howManyDays) {
    loadData(); // non-awaited, same as original
    List expiryList = [];
    final DateTime now = DateTime.now();

    for (int i = 0; i < ingredientsList.length; i++) {
      try {
        final DateTime expDate = DateTime.parse(
            (ingredientsList[i][2] as String).replaceAll("/", "-"));

        if (howManyDays == -1) {
          if (expDate.isBefore(now)) expiryList.add(ingredientsList[i][1]);
        } else if (howManyDays == 0) {
          if (expDate.year == now.year &&
              expDate.month == now.month &&
              expDate.day == now.day) {
            expiryList.add(ingredientsList[i][1]);
          }
        } else if (howManyDays == 1) {
          final tomorrow = now.add(const Duration(days: 1));
          if (expDate.year == tomorrow.year &&
              expDate.month == tomorrow.month &&
              expDate.day == tomorrow.day) {
            expiryList.add(ingredientsList[i][1]);
          }
        } else {
          final targetDate = now.add(Duration(days: howManyDays));
          if (expDate.isBefore(targetDate) && expDate.isAfter(now)) {
            expiryList.add(ingredientsList[i][1]);
          }
        }
      } catch (_) {
        // skip malformed items
      }
    }
    return expiryList;
  }
}
