import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LanguageDB {
  static const String _boxName = 'languageBox';
  static late Box<String> _languageBox;

  static const Map<String, String> languageNames = {
    'en': 'English',
    'ja': '日本語',
    'zh': '繁體中文',
  };

  static const List<String> notFinishedLanguages = ['ja', 'zh'];

  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _languageBox = await Hive.openBox<String>(_boxName);
  }

  static Future<void> setLanguage(String languageCode) async {
    if (!languageNames.containsKey(languageCode)) {
      throw Exception('Language code is not valid');
    } else if (languageCode == getLanguage()) {
      return;
    } else {
      await _languageBox.put('selectedLanguage', languageCode);
    }
  }

  static String? getLanguage() {
    return _languageBox.get('selectedLanguage', defaultValue: 'en');
  }

  static List<String> getNotFinishedLanguages() {
    // * Define a default list of not finished languages (e.g., 'ja', 'zh')
    final selectedLanguage = getLanguage();
    return notFinishedLanguages
        .where((lang) => lang != selectedLanguage)
        .toList();
  }

  static List<String> getLanguagesList() {
    final selectedLanguage = getLanguage();
    final notFinishedLanguages = getNotFinishedLanguages();

    // * The language will sort as
    // * Selected language -> Finished languages -> Not finished languages
    List<String> languagesList = [selectedLanguage!];
    int selectedIndex = 1;
    for (var key in languageNames.keys) {
      if (key != selectedLanguage && !notFinishedLanguages.contains(key)) {
        languagesList.insert(selectedIndex, key);
        selectedIndex++;
      } else if (key != selectedLanguage) {
        languagesList.add(key);
      }
    }
    return languagesList;
  }

  static Future<void> close() async {
    await _languageBox.close();
  }
}
