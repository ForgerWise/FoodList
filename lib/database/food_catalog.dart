import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

/// A suggestion shown on the add page: tap it and name, category and
/// expiry date are filled in at once.
class FoodSuggestion {
  final String categoryKey;
  final String name;
  final int days; // typical fridge shelf life
  const FoodSuggestion(this.categoryKey, this.name, this.days);
}

// (en, zh_TW, ja, typical shelf-life days)
// ponytail: static list, move to a JSON asset if it grows past a few hundred.
const Map<String, List<(String, String, String, int)>> _catalog = {
  'meat': [
    ('Chicken', '雞肉', '鶏肉', 2),
    ('Pork', '豬肉', '豚肉', 3),
    ('Beef', '牛肉', '牛肉', 3),
    ('Ground meat', '絞肉', 'ひき肉', 1),
    ('Bacon', '培根', 'ベーコン', 7),
    ('Ham', '火腿', 'ハム', 5),
    ('Sausage', '香腸', 'ソーセージ', 7),
    ('Lamb', '羊肉', 'ラム肉', 3),
  ],
  'fish': [
    ('Salmon', '鮭魚', '鮭', 2),
    ('Shrimp', '蝦子', 'エビ', 2),
    ('Fish fillet', '魚片', '切り身', 2),
    ('Mackerel', '鯖魚', 'サバ', 2),
    ('Tuna', '鮪魚', 'マグロ', 2),
    ('Clams', '蛤蜊', 'アサリ', 2),
    ('Squid', '魷魚', 'イカ', 2),
    ('Oyster', '牡蠣', '牡蠣', 2),
  ],
  'vegetable': [
    ('Cabbage', '高麗菜', 'キャベツ', 14),
    ('Carrot', '紅蘿蔔', 'にんじん', 21),
    ('Onion', '洋蔥', '玉ねぎ', 30),
    ('Tomato', '番茄', 'トマト', 7),
    ('Spinach', '菠菜', 'ほうれん草', 4),
    ('Broccoli', '花椰菜', 'ブロッコリー', 5),
    ('Potato', '馬鈴薯', 'じゃがいも', 30),
    ('Green onion', '青蔥', 'ねぎ', 7),
    ('Cucumber', '小黃瓜', 'きゅうり', 7),
    ('Eggplant', '茄子', 'なす', 5),
    ('Bell pepper', '甜椒', 'パプリカ', 7),
    ('Lettuce', '萵苣', 'レタス', 5),
  ],
  'fruit': [
    ('Apple', '蘋果', 'りんご', 21),
    ('Banana', '香蕉', 'バナナ', 5),
    ('Orange', '柳橙', 'オレンジ', 14),
    ('Strawberry', '草莓', 'いちご', 3),
    ('Grapes', '葡萄', 'ぶどう', 5),
    ('Kiwi', '奇異果', 'キウイ', 7),
    ('Lemon', '檸檬', 'レモン', 21),
    ('Watermelon', '西瓜', 'スイカ', 5),
  ],
  'bean': [
    ('Tofu', '豆腐', '豆腐', 5),
    ('Soy milk', '豆漿', '豆乳', 5),
    ('Dried tofu', '豆干', '厚揚げ', 5),
    ('Natto', '納豆', '納豆', 7),
    ('Edamame', '毛豆', '枝豆', 3),
    ('Red beans', '紅豆', '小豆', 180),
  ],
  'eggMilk': [
    ('Eggs', '雞蛋', '卵', 21),
    ('Milk', '牛奶', '牛乳', 7),
    ('Yogurt', '優格', 'ヨーグルト', 10),
    ('Cheese', '起司', 'チーズ', 21),
    ('Butter', '奶油', 'バター', 30),
    ('Cream', '鮮奶油', '生クリーム', 7),
  ],
  'mushroom': [
    ('Shiitake', '香菇', 'しいたけ', 5),
    ('Enoki', '金針菇', 'えのき', 5),
    ('King oyster', '杏鮑菇', 'エリンギ', 7),
    ('Shimeji', '鴻喜菇', 'しめじ', 5),
    ('Button mushroom', '洋菇', 'マッシュルーム', 5),
    ('Wood ear', '木耳', 'きくらげ', 5),
  ],
  'processedfood': [
    ('Bread', '麵包', 'パン', 4),
    ('Leftovers', '剩菜', '残り物', 3),
    ('Frozen dumplings', '冷凍水餃', '冷凍餃子', 90),
    ('Kimchi', '泡菜', 'キムチ', 30),
    ('Juice', '果汁', 'ジュース', 7),
    ('Instant noodles', '泡麵', 'インスタント麺', 180),
    ('Canned food', '罐頭', '缶詰', 365),
    ('Sauce', '醬料', 'ソース', 90),
  ],
  'others': [
    ('Rice', '米', '米', 180),
    ('Beverage', '飲料', '飲み物', 30),
    ('Snacks', '零食', 'お菓子', 60),
    ('Ice cream', '冰淇淋', 'アイス', 60),
  ],
};

class FoodCatalog {
  static const _recentKey = 'RECENT_ITEMS'; // [[catKey, name, days], ...]
  static const _barcodeKey = 'BARCODE_CACHE'; // {code: [catKey, name, days]}
  static const _maxRecent = 40;

  static Box get _box => Hive.box('mybox');

  static String _pick((String, String, String, int) e) {
    final lang = Intl.getCurrentLocale();
    if (lang.startsWith('zh')) return e.$2;
    if (lang.startsWith('ja')) return e.$3;
    return e.$1;
  }

  static List<FoodSuggestion> recent() => [
    for (final r in _box.get(_recentKey, defaultValue: []) as List)
      FoodSuggestion(r[0] as String, r[1] as String, r[2] as int),
  ];

  /// Recently used items first, then built-in presets, de-duplicated by name.
  /// [categoryKey] null = all categories.
  static List<FoodSuggestion> suggestions({
    String? categoryKey,
    String query = '',
  }) {
    final q = query.trim().toLowerCase();
    final seen = <String>{};
    final out = <FoodSuggestion>[];
    final presets = [
      for (final entry in _catalog.entries)
        for (final e in entry.value) FoodSuggestion(entry.key, _pick(e), e.$4),
    ];
    for (final s in [...recent(), ...presets]) {
      if (categoryKey != null && s.categoryKey != categoryKey) continue;
      if (q.isNotEmpty && !s.name.toLowerCase().contains(q)) continue;
      if (seen.add(s.name)) out.add(s);
    }
    return out;
  }

  /// Remember what the user just saved so it is one tap away next time.
  static Future<void> remember(FoodSuggestion s, {String? barcode}) async {
    final list = recent()..removeWhere((r) => r.name == s.name);
    list.insert(0, s);
    await _box.put(_recentKey, [
      for (final r in list.take(_maxRecent)) [r.categoryKey, r.name, r.days],
    ]);
    if (barcode != null) {
      final cache = Map.from(_box.get(_barcodeKey, defaultValue: {}) as Map);
      cache[barcode] = [s.categoryKey, s.name, s.days];
      await _box.put(_barcodeKey, cache);
    }
  }

  static FoodSuggestion? cachedBarcode(String code) {
    final r = (_box.get(_barcodeKey, defaultValue: {}) as Map)[code];
    return r == null ? null : FoodSuggestion(r[0], r[1], r[2]);
  }
}
