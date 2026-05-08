import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import 'sub_category.dart';

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
  return _customIconMap[categoryKey] ??
      kCategoryIcons[categoryKey] ??
      '🏷️';
}

// ---------------------------------------------------------------------------
// Preset emoji list shown in the category bottom-sheet picker
// ---------------------------------------------------------------------------
const List<String> kEmojiPresets = [
  '🥩', '🐟', '🥦', '🍎', '🥚', '🍄', '🫘', '🧃', '📦',
  '🥛', '🍞', '🍗', '🥬', '🥕', '🍊', '🧅', '🧄', '🫑',
  '🍜', '🍳', '🥗', '🧆', '🫙', '🍶', '🥤', '🧁', '🫐',
  '🏷️',
];

// ---------------------------------------------------------------------------
// CategoryDataBase
// ---------------------------------------------------------------------------
class CategoryDataBase {
  Map<String, String> categoryMap = {};
  List<String> categoryKeys = [];

  final _myBox = Hive.box("mybox");

  // ── Initialisation ─────────────────────────────────────────────────────────

  void createInitialCategoryData() {
    categoryMap = {
      'meat': S.current.meat,
      'fish': S.current.fish,
      'vegetable': S.current.vegetable,
      'fruit': S.current.fruit,
      'bean': S.current.bean,
      'eggMilk': S.current.eggMilk,
      'mushroom': S.current.mushroom,
      'processedfood': S.current.processedfood,
      'others': S.current.others,
    };
    categoryKeys = categoryMap.keys.toList();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoryVersion = prefs.getString('category_version');

    if (_myBox.get("CATEGORY_MAP") == null || categoryVersion == null) {
      createInitialCategoryData();
      _updateCategoryData();
      prefs.setString('category_version', '1');
    } else {
      categoryMap = Map<String, String>.from(_myBox.get("CATEGORY_MAP"));
    }

    // Clean up legacy sub-category data if present
    if (_myBox.get("SUB_CATEGORY_MAP") != null) {
      _myBox.delete("SUB_CATEGORY_MAP");
    }
    if (prefs.getString('subcategory_version') != null) {
      prefs.remove('subcategory_version');
    }

    updateLanguage();

    if (_myBox.get("CATEGORY_KEYS") == null) {
      categoryKeys = categoryMap.keys.toList();
      _updateCategoryKeys();
    } else {
      categoryKeys = List<String>.from(_myBox.get("CATEGORY_KEYS"));
    }

    // Load user-saved custom icons into the module-level cache
    final rawIconMap = _myBox.get("CATEGORY_ICONS", defaultValue: {});
    _customIconMap = Map<String, String>.from(rawIconMap);
  }

  // ── Persistence helpers ────────────────────────────────────────────────────

  void _updateCategoryData() => _myBox.put("CATEGORY_MAP", categoryMap);
  void _updateCategoryKeys() => _myBox.put("CATEGORY_KEYS", categoryKeys);
  void _updateIconMap() => _myBox.put("CATEGORY_ICONS", _customIconMap);

  // ── Category CRUD ──────────────────────────────────────────────────────────

  void resetIngredients() {
    _myBox.delete("CATEGORY_MAP");
    _myBox.delete("SUB_CATEGORY_MAP");
    // Reset icons to built-in defaults only
    _customIconMap.clear();
    _myBox.delete("CATEGORY_ICONS");
    createInitialCategoryData();
    _updateCategoryData();
    _updateCategoryKeys();
    updateLanguage();
  }

  void updateLanguage() {
    categoryMap = categoryMap.map((key, value) {
      switch (key) {
        case 'meat':        return MapEntry(key, S.current.meat);
        case 'fish':        return MapEntry(key, S.current.fish);
        case 'vegetable':   return MapEntry(key, S.current.vegetable);
        case 'fruit':       return MapEntry(key, S.current.fruit);
        case 'bean':        return MapEntry(key, S.current.bean);
        case 'eggMilk':     return MapEntry(key, S.current.eggMilk);
        case 'mushroom':    return MapEntry(key, S.current.mushroom);
        case 'processedfood': return MapEntry(key, S.current.processedfood);
        case 'others':      return MapEntry(key, S.current.others);
        default:            return MapEntry(key, value);
      }
    });
  }

  String _getNewCategoryKey() => "C${DateTime.now().millisecondsSinceEpoch}";

  void addCategory(String label, {String icon = '🏷️'}) {
    String key = _getNewCategoryKey();
    categoryMap[key] = label;
    categoryKeys.add(key);
    _customIconMap[key] = icon;
    _updateCategoryData();
    _updateCategoryKeys();
    _updateIconMap();
  }

  void renameCategory(String oldKey, String newLabel) {
    String newKey = _getNewCategoryKey();
    if (categoryMap.containsKey(newKey)) return;
    // Migrate icon to new key
    if (_customIconMap.containsKey(oldKey)) {
      _customIconMap[newKey] = _customIconMap.remove(oldKey)!;
    }
    categoryMap[newKey] = newLabel;
    categoryMap.remove(oldKey);
    int index = categoryKeys.indexOf(oldKey);
    if (index != -1) categoryKeys[index] = newKey;
    _updateCategoryData();
    _updateCategoryKeys();
    _updateIconMap();
  }

  /// Set or update the emoji icon for an existing category.
  void setCategoryIcon(String key, String icon) {
    _customIconMap[key] = icon;
    _updateIconMap();
  }

  void reorderCategory(int oldIndex, int newIndex) {
    if (oldIndex < 0 || newIndex < 0) return;
    if (newIndex > categoryKeys.length || oldIndex > categoryKeys.length) return;
    final item = categoryKeys.removeAt(oldIndex);
    categoryKeys.insert(newIndex, item);
    _updateCategoryKeys();
  }

  void removeCategory(String key) {
    categoryMap.remove(key);
    categoryKeys.remove(key);
    _customIconMap.remove(key);
    _updateCategoryData();
    _updateCategoryKeys();
    _updateIconMap();
  }
}
