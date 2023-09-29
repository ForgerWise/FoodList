import 'package:hive_flutter/hive_flutter.dart';

class InputDataBase {
  List ingredientsList = [];

  final _myBox = Hive.box("mybox");

  void createInitialData() {
    ingredientsList = [
      ["Example", "Slide to Delete", "2020/09/29", "2030/09/29"],
    ];
  }

  int compareIngredients(a, b) {
    DateTime dateA = DateTime.parse(a[3].replaceAll("/", "-"));
    DateTime dateB = DateTime.parse(b[3].replaceAll("/", "-"));

    return dateA.compareTo(dateB);
  }

  void loadData() {
    ingredientsList = _myBox.get("INGREDIENTS_LIST");
    ingredientsList.sort(compareIngredients);
  }

  void updateData() {
    ingredientsList.sort(compareIngredients);
    _myBox.put("INGREDIENTS_LIST", ingredientsList);
  }
}
