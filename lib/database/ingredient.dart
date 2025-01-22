import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import 'sub_category.dart';

class CategoryDataBase {
  Map<String, String> categoryMap = {};
  Map<String, List<SubCategory>> subCategoryMap = {};
  List<String> categoryKeys = [];

  final _myBox = Hive.box("mybox");

  // * Create initial data for the subCategoryMap
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

  void createInitialSubCategoryData() {
    subCategoryMap = {
      'meat': [
        SubCategory.fromNameWithMapCheck("beef", subCategoryMap),
        SubCategory.fromNameWithMapCheck("pork", subCategoryMap),
        SubCategory.fromNameWithMapCheck("chicken", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherMeats", subCategoryMap),
      ],
      'fish': [
        SubCategory.fromNameWithMapCheck("tuna", subCategoryMap),
        SubCategory.fromNameWithMapCheck("salmon", subCategoryMap),
        SubCategory.fromNameWithMapCheck("oyster", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherFishes", subCategoryMap),
      ],
      'vegetable': [
        SubCategory.fromNameWithMapCheck("carrot", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherVegetables", subCategoryMap),
      ],
      'fruit': [
        SubCategory.fromNameWithMapCheck("apple", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherFruits", subCategoryMap),
      ],
      'bean': [
        SubCategory.fromNameWithMapCheck("soybean", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherBeans", subCategoryMap),
      ],
      'eggMilk': [
        SubCategory.fromNameWithMapCheck("egg", subCategoryMap),
        SubCategory.fromNameWithMapCheck("milk", subCategoryMap),
        SubCategory.fromNameWithMapCheck("otherEggMilk", subCategoryMap),
      ],
      'mushroom': [
        SubCategory.fromNameWithMapCheck("otherMushrooms", subCategoryMap),
      ],
      'processedfood': [
        SubCategory.fromNameWithMapCheck("otherProcessedFoods", subCategoryMap),
      ],
      'others': [
        SubCategory.fromNameWithMapCheck("otherItems", subCategoryMap),
      ],
    };
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoryVersion = prefs.getString('category_version');
    String? subCategoryVersion = prefs.getString('subcategory_version');

    if (_myBox.get("CATEGORY_MAP") == null || categoryVersion == null) {
      createInitialCategoryData();
      _updateCategoryData();
      prefs.setString('category_version', '1');
    } else {
      categoryMap = Map<String, String>.from(_myBox.get("CATEGORY_MAP"));
    }

    if (_myBox.get("SUB_CATEGORY_MAP") != null && subCategoryVersion == null) {
      // * Convert the old subCategoryMap to the new format
      Map<dynamic, dynamic> rawMap = _myBox.get("SUB_CATEGORY_MAP");
      Map<String, List<String>> oldSubCategoryMap = rawMap.map((key, value) =>
          MapEntry<String, List<String>>(
              key as String, List<String>.from(value as List)));
      // * Change first letter of each word in key and value to lowercase, others word in value will remain the same
      oldSubCategoryMap = oldSubCategoryMap.map((key, value) => MapEntry(
          (key[0].toLowerCase() + key.substring(1))
              .replaceAll("_", "")
              .replaceAll("&", "")
              .replaceAll(" ", ""),
          value.map((sub) {
            return sub[0].toLowerCase() + sub.substring(1);
          }).toList()));
      subCategoryMap = oldSubCategoryMap.map(
        (key, value) {
          return MapEntry(
            key,
            value
                .map<SubCategory>(
                  (sub) =>
                      SubCategory.fromNameWithMapCheck(sub, subCategoryMap),
                )
                .toList(),
          );
        },
      );
      _myBox.delete("SUB_CATEGORY_MAP");
      _updateSubCategoryData();
      prefs.setString('subcategory_version', '1');
    } else if (_myBox.get("SUB_CATEGORY_MAP") == null ||
        subCategoryVersion == null) {
      // * Create initial data for the subCategoryMap
      createInitialSubCategoryData();
      _updateSubCategoryData();
      prefs.setString('subcategory_version', '1');
    } else {
      subCategoryMap = (_myBox.get("SUB_CATEGORY_MAP") as Map<dynamic, dynamic>)
          .map<String, List<SubCategory>>(
        (key, value) {
          return MapEntry(
            key as String,
            (value as List<dynamic>)
                .map<SubCategory>((item) => item as SubCategory)
                .toList(),
          );
        },
      );
    }
    updateLanguage();

    if (_myBox.get("CATEGORY_KEYS") == null) {
      categoryKeys = categoryMap.keys.toList();
      _updateCategoryKeys();
    } else {
      categoryKeys = List<String>.from(_myBox.get("CATEGORY_KEYS"));
    }
  }

  void _updateCategoryData() {
    _myBox.put("CATEGORY_MAP", categoryMap);
  }

  void _updateSubCategoryData() {
    _myBox.put("SUB_CATEGORY_MAP", subCategoryMap);
  }

  void _updateCategoryKeys() {
    _myBox.put("CATEGORY_KEYS", categoryKeys);
  }

  void resetIngredients() {
    _myBox.delete("CATEGORY_MAP");
    _myBox.delete("SUB_CATEGORY_MAP");
    createInitialCategoryData();
    createInitialSubCategoryData();
    _updateCategoryData();
    _updateSubCategoryData();
    _updateCategoryKeys();
    updateLanguage();
  }

  void updateLanguage() {
    categoryMap = categoryMap.map(
      (key, value) {
        switch (key) {
          case 'meat':
            return MapEntry(key, S.current.meat);
          case 'fish':
            return MapEntry(key, S.current.fish);
          case 'vegetable':
            return MapEntry(key, S.current.vegetable);
          case 'fruit':
            return MapEntry(key, S.current.fruit);
          case 'bean':
            return MapEntry(key, S.current.bean);
          case 'eggMilk':
            return MapEntry(key, S.current.eggMilk);
          case 'mushroom':
            return MapEntry(key, S.current.mushroom);
          case 'processedfood':
            return MapEntry(key, S.current.processedfood);
          case 'others':
            return MapEntry(key, S.current.others);
          default: // * Return the original value if the key is not found
            return MapEntry(key, value);
        }
      },
    );

    subCategoryMap = subCategoryMap.map(
      (key, value) => MapEntry<String, List<SubCategory>>(
        key,
        value.map(
          (sub) {
            switch (sub.id) {
              case 'beef':
                return sub.copyWithName(S.current.beef);
              case 'pork':
                return sub.copyWithName(S.current.pork);
              case 'chicken':
                return sub.copyWithName(S.current.chicken);
              case 'otherMeats':
                return sub.copyWithName(S.current.otherMeats);
              case 'tuna':
                return sub.copyWithName(S.current.tuna);
              case 'salmon':
                return sub.copyWithName(S.current.salmon);
              case 'oyster':
                return sub.copyWithName(S.current.oyster);
              case 'otherFishes':
                return sub.copyWithName(S.current.otherFishes);
              case 'carrot':
                return sub.copyWithName(S.current.carrot);
              case 'otherVegetables':
                return sub.copyWithName(S.current.otherVegetables);
              case 'apple':
                return sub.copyWithName(S.current.apple);
              case 'otherFruits':
                return sub.copyWithName(S.current.otherFruits);
              case 'soybean':
                return sub.copyWithName(S.current.soybean);
              case 'otherBeans':
                return sub.copyWithName(S.current.otherBeans);
              case 'egg':
                return sub.copyWithName(S.current.egg);
              case 'milk':
                return sub.copyWithName(S.current.milk);
              case 'otherEggMilk':
                return sub.copyWithName(S.current.otherEggMilk);
              case 'otherMushrooms':
                return sub.copyWithName(S.current.otherMushrooms);
              case 'otherProcessedFoods':
                return sub.copyWithName(S.current.otherProcessedFoods);
              case 'otherItems':
                return sub.copyWithName(S.current.otherItems);
              default: // * Return the original value if the key is not found
                return sub;
            }
          },
        ).toList(),
      ),
    );
  }

  String _getNewCategoryKey() {
    return "C${DateTime.now().millisecondsSinceEpoch}";
  }

  String _getNewSubCategoryKey() {
    return "SC${DateTime.now().millisecondsSinceEpoch}";
  }

  void renameCategory(String oldKey, String newLabel) {
    String newKey = _getNewCategoryKey();
    if (categoryMap.containsKey(newKey)) {
      return;
    }
    categoryMap[newKey] = newLabel;
    subCategoryMap[newKey] = subCategoryMap[oldKey]!;
    categoryMap.remove(oldKey);
    subCategoryMap.remove(oldKey);
    int index = categoryKeys.indexOf(oldKey);
    categoryKeys[index] = newKey;
    _updateCategoryData();
    _updateCategoryKeys();
    _updateSubCategoryData();
  }

  void renameSubCategory(String categoryKey, String oldKey, String newLabel) {
    String newKey = _getNewSubCategoryKey();
    if (subCategoryMap[categoryKey]!.any((element) => element.id == newKey)) {
      return;
    }
    // * Create new SubCategory with the new key and label
    SubCategory newSubCategory = SubCategory(id: newKey, name: newLabel);
    // * Find the index of the old SubCategory
    int index = subCategoryMap[categoryKey]!
        .indexWhere((element) => element.id == oldKey);
    // * Replace the old SubCategory with the new SubCategory
    subCategoryMap[categoryKey]![index] = newSubCategory;
    _updateSubCategoryData();
  }

  void addCategory(String label) {
    String key = _getNewCategoryKey();
    categoryMap[key] = label;
    categoryKeys.add(key);
    subCategoryMap[key] = [];
    _updateCategoryData();
    _updateCategoryKeys();
    _updateSubCategoryData();
  }

  void addSubCategory(String categoryKey, String label) {
    String key = _getNewSubCategoryKey();
    if (subCategoryMap[categoryKey]!.any((element) => element.id == key)) {
      return;
    }
    subCategoryMap[categoryKey]!.add(SubCategory(id: key, name: label));
    _updateSubCategoryData();
  }

  void reorderCategory(int oldIndex, int newIndex) {
    if (oldIndex < 0 || newIndex < 0) {
      return;
    }
    if (newIndex > categoryKeys.length || oldIndex > categoryKeys.length) {
      return;
    }
    // * Reorder the categoryKeys
    String item = categoryKeys.removeAt(oldIndex);
    categoryKeys.insert(newIndex, item);
    _updateCategoryKeys();
  }

  void reorderSubCategory(String categoryKey, int oldIndex, int newIndex) {
    if (oldIndex < 0 || newIndex < 0) {
      return;
    }
    if (newIndex > subCategoryMap[categoryKey]!.length ||
        oldIndex > subCategoryMap[categoryKey]!.length) {
      return;
    }
    // * Reorder the subCategories
    SubCategory item = subCategoryMap[categoryKey]!.removeAt(oldIndex);
    subCategoryMap[categoryKey]!.insert(newIndex, item);
    _updateSubCategoryData();
  }

  void removeCategory(String key) {
    categoryMap.remove(key);
    subCategoryMap.remove(key);
    categoryKeys.remove(key);
    _updateCategoryData();
    _updateCategoryKeys();
    _updateSubCategoryData();
  }

  void removeSubCategory(String categoryKey, String key) {
    subCategoryMap[categoryKey]!.removeWhere((element) => element.id == key);
    _updateSubCategoryData();
  }
}
