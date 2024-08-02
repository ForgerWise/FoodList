import 'package:hive_flutter/hive_flutter.dart';

class CategoryDataBase {
  List<String> categoryList = [
    "Meat",
    "Fish",
    "Vegetable",
    "Fruit",
    "Bean",
    "Egg & Milk",
    "Mushroom",
    "Processed_food",
    "Others"
  ];

  Map<String, List<String>> subCategoryMap = {};

  final _myBox = Hive.box("mybox");

  void createInitialData() {
    subCategoryMap = {
      "Meat": ["Beef", "Pork", "Chicken", "Other Meats"],
      "Fish": ["Tuna", "Salmon", "Oyster", "Other Fishes"],
      "Vegetable": ["Carrot", "Other Vegetables"],
      "Fruit": ["Apple", "Other Fruits"],
      "Bean": ["Soybean", "Other Beans"],
      "Egg & Milk": ["Egg", "Milk", "Other Egg & Milk"],
      "Mushroom": ["Other Mushrooms"],
      "Processed_food": ["Other Processed Foods"],
      "Others": ["Other Items"],
    };
  }

  void loadData() {
    if (_myBox.containsKey("SUB_CATEGORY_MAP")) {
      Map<dynamic, dynamic> rawMap = _myBox.get("SUB_CATEGORY_MAP");
      subCategoryMap = rawMap.map((key, value) =>
          MapEntry<String, List<String>>(
              key as String, List<String>.from(value as List)));
    }
  }

  void updateData() {
    _myBox.put("SUB_CATEGORY_MAP", subCategoryMap);
  }
}
