// Writes sample fridge data for store screenshots, one Hive box per language:
//   dart run tool/make_seed.dart build/seed
// Dates are relative to today, so re-run before capturing.
import 'dart:io';

import 'package:hive/hive.dart';

String _d(int days) {
  final n = DateTime.now().add(Duration(days: days));
  return '${n.year}/${n.month.toString().padLeft(2, '0')}/${n.day.toString().padLeft(2, '0')}';
}

Future<void> main(List<String> args) async {
  final out = args.isEmpty ? 'build/seed' : args.first;
  const names = {
    'en': [
      'Chicken breast',
      'Spinach',
      'Milk',
      'Tofu',
      'Salmon',
      'Shiitake',
      'Apples',
      'Eggs',
    ],
    'zh_TW': ['雞胸肉', '菠菜', '鮮奶', '豆腐', '鮭魚', '香菇', '蘋果', '雞蛋'],
    'ja': ['鶏むね肉', 'ほうれん草', '牛乳', '豆腐', '鮭', 'しいたけ', 'りんご', '卵'],
  };
  const cats = [
    'meat',
    'vegetable',
    'eggMilk',
    'bean',
    'fish',
    'mushroom',
    'fruit',
    'eggMilk',
  ];
  const days = [-1, 0, 1, 3, 4, 6, 12, 18];
  const qty = [1, 1, 2, 1, 2, 1, 6, 10];
  for (final e in names.entries) {
    final dir = Directory('$out/${e.key}')..createSync(recursive: true);
    Hive.init(dir.path);
    final box = await Hive.openBox('mybox');
    await box.clear();
    await box.put('INGREDIENTS_LIST', [
      for (var i = 0; i < 8; i++) [cats[i], e.value[i], _d(days[i]), qty[i]],
    ]);
    await box.close();
  }
  stdout.writeln('seed written to $out');
}
