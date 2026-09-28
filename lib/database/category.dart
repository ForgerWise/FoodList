import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

// ---------------------------------------------------------------------------
// Built-in category icons (fallback for keys without a custom icon)
// ---------------------------------------------------------------------------
const Map<String, String> kCategoryIcons = {
  'meat': '🥩',
  'fish': '🐟',
  'vegetable': '🥦',
  'fruit': '🍎',
  'bean': '🫘',
  'eggMilk': '🥚',
  'mushroom': '🍄',
  'processedfood': '🧃',
  'others': '📦',
};

// Module-level cache — populated when CategoryDataBase.loadData() is called.
// Used by getCategoryIcon() which is called from list_tile, homepage, etc.
Map<String, String> _customIconMap = {};

/// Returns the emoji icon for [categoryKey].
/// Checks user-saved icons first, then built-in defaults, then falls back to 🏷️.
String getCategoryIcon(String categoryKey) {
  return _customIconMap[categoryKey] ?? kCategoryIcons[categoryKey] ?? '🏷️';
}

// ---------------------------------------------------------------------------
// Preset emoji list shown in the category bottom-sheet picker
// ---------------------------------------------------------------------------
const List<String> kEmojiPresets = [
  '🥩',
  '🐟',
  '🥦',
  '🍎',
  '🥚',
  '🍄',
  '🫘',
  '🧃',
  '📦',
  '🥛',
  '🍞',
  '🍗',
  '🥬',
  '🥕',
  '🍊',
  '🧅',
  '🧄',
  '🫑',
  '🍜',
  '🍳',
  '🥗',
  '🧆',
  '🫙',
  '🍶',
  '🥤',
  '🧁',
  '🫐',
  '🏷️',
];

// ---------------------------------------------------------------------------
// Built-in categories and every translation they have ever shipped with.
// Used to (a) migrate v1 rows that stored the display name instead of the key
// and (b) tell "still the default label" apart from "renamed by the user".
// ---------------------------------------------------------------------------
const Map<String, List<String>> _builtinLabels = {
  'meat': ['Meat', '肉類'],
  'fish': ['Fish', '魚類', '魚'],
  'vegetable': ['Vegetable', '蔬菜', '野菜'],
  'fruit': ['Fruit', '水果', '果物'],
  'bean': ['Bean', '豆類'],
  'eggMilk': ['Egg & Milk', '蛋奶', '卵と乳製品'],
  'mushroom': ['Mushroom', '菇類', 'キノコ'],
  'processedfood': ['Processed Food', 'Processed_food', '加工食品'],
  'others': ['Others', '其他', 'その他'],
};

/// v1 stored the category display name; map it back to its key.
String legacyCategoryKey(String displayName) {
  for (final e in _builtinLabels.entries) {
    if (e.value.contains(displayName)) return e.key;
  }
  return displayName; // custom category — its name was its identity
}

String? _currentBuiltinLabel(String key) => switch (key) {
  'meat' => S.current.meat,
  'fish' => S.current.fish,
  'vegetable' => S.current.vegetable,
  'fruit' => S.current.fruit,
  'bean' => S.current.bean,
  'eggMilk' => S.current.eggMilk,
  'mushroom' => S.current.mushroom,
  'processedfood' => S.current.processedfood,
  'others' => S.current.others,
  _ => null,
};

// ---------------------------------------------------------------------------
// CategoryDataBase
// ---------------------------------------------------------------------------
class CategoryDataBase {
  Map<String, String> categoryMap = {};
  List<String> categoryKeys = [];

  Box get _box => Hive.box('mybox');

  void _createDefaults() {
    categoryMap = {
      for (final key in _builtinLabels.keys) key: _currentBuiltinLabel(key)!,
    };
    categoryKeys = categoryMap.keys.toList();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    if (_box.get('CATEGORY_MAP') == null ||
        prefs.getString('category_version') == null) {
      _createDefaults();
      _box.put('CATEGORY_MAP', categoryMap);
      prefs.setString('category_version', '1');
    } else {
      categoryMap = Map<String, String>.from(_box.get('CATEGORY_MAP'));
    }

    // Legacy sub-category data (pre-v3) is no longer used.
    if (_box.get('SUB_CATEGORY_MAP') != null) _box.delete('SUB_CATEGORY_MAP');
    prefs.remove('subcategory_version');

    _translateBuiltins();

    // Order list must contain exactly the keys of the map.
    final stored = List<String>.from(
      _box.get('CATEGORY_KEYS', defaultValue: []),
    );
    categoryKeys = [
      ...stored.where(categoryMap.containsKey),
      ...categoryMap.keys.where((k) => !stored.contains(k)),
    ];
    if (categoryKeys.length != stored.length) _saveKeys();

    _customIconMap = Map<String, String>.from(
      _box.get('CATEGORY_ICONS', defaultValue: {}),
    );
  }

  /// Follow the app language for built-in labels the user has not renamed.
  void _translateBuiltins() {
    categoryMap = categoryMap.map((key, label) {
      final isDefault = _builtinLabels[key]?.contains(label) ?? false;
      return MapEntry(key, isDefault ? _currentBuiltinLabel(key)! : label);
    });
  }

  void _saveMap() => _box.put('CATEGORY_MAP', categoryMap);
  void _saveKeys() => _box.put('CATEGORY_KEYS', categoryKeys);
  void _saveIcons() => _box.put('CATEGORY_ICONS', _customIconMap);

  // ── Category CRUD ──────────────────────────────────────────────────────────

  void resetIngredients() {
    _customIconMap.clear();
    _box.delete('CATEGORY_ICONS');
    _createDefaults();
    _saveMap();
    _saveKeys();
  }

  void addCategory(String label, {String icon = '🏷️'}) {
    final key = 'C${DateTime.now().millisecondsSinceEpoch}';
    categoryMap[key] = label;
    categoryKeys.add(key);
    _customIconMap[key] = icon;
    _saveMap();
    _saveKeys();
    _saveIcons();
  }

  /// Renames in place. The key never changes, so items in this category stay
  /// linked to it. (Older versions minted a new key here and orphaned them.)
  void renameCategory(String key, String newLabel) {
    categoryMap[key] = newLabel;
    _saveMap();
  }

  void setCategoryIcon(String key, String icon) {
    _customIconMap[key] = icon;
    _saveIcons();
  }

  void reorderCategory(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= categoryKeys.length) return;
    final item = categoryKeys.removeAt(oldIndex);
    categoryKeys.insert(newIndex.clamp(0, categoryKeys.length), item);
    _saveKeys();
  }

  void removeCategory(String key) {
    categoryMap.remove(key);
    categoryKeys.remove(key);
    _customIconMap.remove(key);
    _saveMap();
    _saveKeys();
    _saveIcons();
  }
}
