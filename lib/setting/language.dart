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
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueGrey.withOpacity(0.08) : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected ? Colors.blueGrey.withOpacity(0.5) : Colors.grey.shade200,
                width: 1,
              ),
              boxShadow: isSelected ? [] : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              title: Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.blueGrey.shade800 : Colors.black87,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.blueGrey)
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
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
      backgroundColor: Colors.white,
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
              padding: const EdgeInsets.only(top: 16.0, bottom: 40.0),
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
