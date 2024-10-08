import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import 'sub_category.dart';

class CategoryDataBase {
  List<String> categoryList = [
    'meat',
    'fish',
    'vegetable',
    'fruit',
    'bean',
    'eggMilk',
    'mushroom',
    'processedfood',
    'others'
  ];

  Map<String, String> categoryMap = {};
  Map<String, List<SubCategory>> subCategoryMap = {};

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
      updateCategoryData();
      prefs.setString('category_version', '1');
    } else {
      categoryMap = Map<String, String>.from(_myBox.get("CATEGORY_MAP"));
    }

    if (_myBox.get("SUB_CATEGORY_MAP") != null && subCategoryVersion == null) {
      // * Convert the old subCategoryMap to the new format
      print("Converting old subCategoryMap to new format");
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
      print("Convert complete");
      updateSubCategoryData();
      prefs.setString('subcategory_version', '1');
    } else if (_myBox.get("SUB_CATEGORY_MAP") == null ||
        subCategoryVersion == null) {
      // * Create initial data for the subCategoryMap
      createInitialSubCategoryData();
      updateSubCategoryData();
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
  }

  void updateCategoryData() {
    _myBox.put("CATEGORY_MAP", categoryMap);
  }

  void updateSubCategoryData() {
    _myBox.put("SUB_CATEGORY_MAP", subCategoryMap);
  }

  void resetIngredients() {
    _myBox.delete("CATEGORY_MAP");
    _myBox.delete("SUB_CATEGORY_MAP");
    createInitialCategoryData();
    createInitialSubCategoryData();
    updateCategoryData();
    updateSubCategoryData();
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
}
