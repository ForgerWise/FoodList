import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodlist/main.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import '../database/languageDB.dart';
import '../generated/l10n.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguageState();
}

class _LanguageState extends State<LanguagePage> {
  List<String> languagesList = LanguageDB.getLanguagesList();
  List<String> notFinishedLanguages = LanguageDB.getNotFinishedLanguages();
  final Map<String, String> languageNames = LanguageDB.languageNames;
  final snackBar = SnackBar(
    content: Text(S.current.languageNotSupportedYetMessage),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.blueGrey,
  );

  Future<void> _updateSelectedLanguage(String selected) async {
    await LanguageDB.setLanguage(selected);
    setState(() {
      Locale newLocale = LanguageDB.languageToLocale(selected);
      MyApp.of(context)?.setLocale(newLocale);
    });
  }

  Widget _buildLanguageTile(
      String languageCode, String languageName, bool isSelected) {
    return AnimationConfiguration.staggeredList(
      position: languagesList.indexOf(languageCode),
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 150.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueGrey[100] : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  languageName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blueGrey : Colors.grey[400],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              onTap: () => _onLanguageTap(languageCode, isSelected),
            ),
          ),
        ),
      ),
    );
  }

  void _onLanguageTap(String languageCode, bool isSelected) async {
    if (!isSelected && !notFinishedLanguages.contains(languageCode)) {
      await _updateSelectedLanguage(languageCode);
    } else if (notFinishedLanguages.contains(languageCode)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).languages),
      body: FutureBuilder<String>(
        future: LanguageDB.getLanguage(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final selectedLanguage = snapshot.data ?? '';

          return AnimationLimiter(
            child: ListView.builder(
              itemCount: languagesList.length,
              itemBuilder: (context, index) {
                final languageCode = languagesList[index];
                final languageName = languageNames[languageCode] ?? '';
                final isSelected = selectedLanguage == languageCode;

                return _buildLanguageTile(
                    languageCode, languageName, isSelected);
              },
            ),
          );
        },
      ),
    );
  }
}
