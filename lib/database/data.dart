import 'package:hive_flutter/hive_flutter.dart';

import '../generated/l10n.dart';

class InputDataBase {
  List ingredientsList = [];

  var _myBox = Hive.box("mybox");

  Future<void> createInitialData() async {
    // * Initialize ingredientsList with an example item
    // * [Category, Subcategory, Date Added, Expiry Date]
    ingredientsList = [
      [S.current.example, S.current.slideToDelete, "2020/09/29", "2999/09/29"],
    ];
    await _myBox.put(
        "INGREDIENTS_LIST", ingredientsList); // * save initial data
  }

  int compareIngredients(a, b) {
    DateTime dateA = DateTime.parse(a[3].replaceAll("/", "-"));
    DateTime dateB = DateTime.parse(b[3].replaceAll("/", "-"));

    return dateA.compareTo(dateB);
  }

  Future<void> loadData() async {
    ingredientsList = _myBox.get("INGREDIENTS_LIST", defaultValue: []);
    ingredientsList.sort(compareIngredients);
  }

  Future<void> updateData() async {
    ingredientsList.sort(compareIngredients);
    _myBox.put("INGREDIENTS_LIST", ingredientsList);
  }

  List editData(int index, String category, String subcategory, String expdate,
      List ingredientsList) {
    ingredientsList[index][0] = category;
    ingredientsList[index][1] = subcategory;
    ingredientsList[index][3] = expdate;
    return ingredientsList;
  }

  int searchIndex(String category, String subcategory, String expdate,
      List ingredientsList) {
    for (int i = 0; i < ingredientsList.length; i++) {
      if (ingredientsList[i][0] == category &&
          ingredientsList[i][1] == subcategory &&
          ingredientsList[i][3] == expdate) {
        return i;
      }
    }
    return -1;
  }

  // * Get ingredients that are expiring in HowManyDays
  // * Set HowManyDays to -1 to get expired ingredients
  // * Set HowManyDays to 0 to get ingredients expiring today
  // * Set HowManyDays to 1 to get ingredients expiring tomorrow
  List getIngredientsExpiry(int HowManyDays) {
    // * Check if the box is open
    loadData();

    List expiryList = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < ingredientsList.length; i++) {
      DateTime expDate =
          DateTime.parse(ingredientsList[i][3].replaceAll("/", "-"));

      // * Add Subcategory to expiryList
      if (HowManyDays == -1) {
        if (expDate.isBefore(now)) {
          expiryList.add(ingredientsList[i][1]);
        }
      } else if (HowManyDays == 0) {
        if (expDate.year == now.year &&
            expDate.month == now.month &&
            expDate.day == now.day) {
          expiryList.add(ingredientsList[i][1]);
        }
      } else if (HowManyDays == 1) {
        DateTime tomorrow = now.add(Duration(days: 1));
        if (expDate.year == tomorrow.year &&
            expDate.month == tomorrow.month &&
            expDate.day == tomorrow.day) {
          expiryList.add(ingredientsList[i][1]);
        }
      } else {
        DateTime targetDate = now.add(Duration(days: HowManyDays));
        if (expDate.isBefore(targetDate) && expDate.isAfter(now)) {
          expiryList.add(ingredientsList[i][1]);
        }
      }
    }
    return expiryList;
  }
}
