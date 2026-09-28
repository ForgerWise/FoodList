import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/database/category.dart';
import 'package:foodlist/database/data.dart';
import 'package:foodlist/database/languagedb.dart';
import 'package:foodlist/database/sub_category.dart';
import 'package:foodlist/generated/l10n.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Data written by every released app version must still load correctly.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Box box;

  setUpAll(() async {
    Hive.init((await Directory.systemTemp.createTemp('fl_mig_')).path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubCategoryAdapter());
    }
    box = await Hive.openBox('mybox');
    await S.load(const Locale('zh', 'TW'));
  });

  setUp(() async {
    await box.clear();
    SharedPreferences.setMockInitialValues({'category_version': '1'});
  });

  test(
    'v1 rows (display name + input date) migrate and are persisted',
    () async {
      await box.put('INGREDIENTS_LIST', [
        ['肉類', '牛肉', '2023/01/01', '2023/01/05'],
        ['Processed_food', 'Ham', '2023/01/01', '2023/2/3'],
      ]);
      final db = InputDataBase();
      await db.loadData();
      expect(db.items.map((i) => i.categoryKey), ['meat', 'processedfood']);
      expect(db.items.first.expiry, DateTime(2023, 1, 5));
      expect(box.get('INGREDIENTS_LIST'), [
        ['meat', '牛肉', '2023/01/05', 1],
        ['processedfood', 'Ham', '2023/02/03', 1],
      ]);
    },
  );

  test(
    'v2 rows round-trip unchanged; unreadable rows are never dropped',
    () async {
      final rows = [
        ['fish', '鮭魚', '2026/10/01', 2],
        ['C1700000000000', 'Mine', '2026/10/02', 1],
        ['garbage'],
      ];
      await box.put('INGREDIENTS_LIST', rows);
      final db = InputDataBase();
      await db.loadData();
      expect(db.items.length, 2);
      await db.updateData();
      expect(box.get('INGREDIENTS_LIST'), rows);
    },
  );

  test('first launch starts empty; old tutorial rows are removed', () async {
    final db = InputDataBase();
    await db.loadData();
    expect(db.items, isEmpty);

    await box.put('INGREDIENTS_LIST', [
      ['others', '滑動以刪除', '2999/09/29', 1],
      ['Example', 'Slide to Delete', '2020/09/29', '2999/09/29'], // v1 sample
      ['meat', 'Pork', '2026/10/01', 1],
    ]);
    await db.loadData();
    expect(db.items.single.name, 'Pork');
    expect(box.get('INGREDIENTS_LIST'), [
      ['meat', 'Pork', '2026/10/01', 1],
    ]);
  });

  test(
    'categories: default labels follow language, renamed ones are kept',
    () async {
      await box.put('CATEGORY_MAP', {
        'meat': 'Meat',
        'fish': '我的魚',
        'C1': 'Snacks',
      });
      await box.put('CATEGORY_KEYS', [
        'C1',
        'gone',
        'meat',
      ]); // stale + missing key
      final cdb = CategoryDataBase();
      await cdb.loadData();
      expect(cdb.categoryMap, {'meat': '肉類', 'fish': '我的魚', 'C1': 'Snacks'});
      expect(cdb.categoryKeys, ['C1', 'meat', 'fish']);

      cdb.renameCategory('meat', '好吃的肉');
      expect(cdb.categoryKeys, contains('meat')); // key must not change
      await cdb.loadData();
      expect(cdb.categoryMap['meat'], '好吃的肉');
    },
  );

  test(
    'deleting a category moves its items instead of orphaning them',
    () async {
      await box.put('INGREDIENTS_LIST', [
        ['C1', 'Chips', '2026/10/01', 1],
        ['meat', 'Pork', '2026/10/02', 1],
      ]);
      final db = InputDataBase();
      await db.moveCategory('C1', 'others');
      expect(db.items.map((i) => i.categoryKey), ['others', 'meat']);
    },
  );

  test('legacy SubCategory records in the box do not break loading', () async {
    await box.put('SUB_CATEGORY_MAP', {
      'meat': [SubCategory(id: 'beef', name: 'Beef')],
    });
    await box.close();
    box = await Hive.openBox('mybox');
    await CategoryDataBase().loadData();
    expect(box.get('SUB_CATEGORY_MAP'), isNull);
  });

  test('invalid stored language falls back instead of crashing', () async {
    SharedPreferences.setMockInitialValues({'selectedLanguage': 'English'});
    expect(LanguageDB.languageNames, contains(await LanguageDB.getLanguage()));
    expect(LanguageDB.languageToLocale('zh_TW'), const Locale('zh', 'TW'));
  });
}
