import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../database/languageDB.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguageState();
}

class _LanguageState extends State<LanguagePage> {
  late List<String> languagesList;
  late List<String> notFinishedLanguages;
  final Map<String, String> languageNames = LanguageDB.languageNames;
  final snackBar = SnackBar(
    content: Text("This language is not supported yet! We're working on it!"),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.blueGrey,
  );

  @override
  void initState() {
    super.initState();
    languagesList = LanguageDB.getLanguagesList();
    notFinishedLanguages = LanguageDB.getNotFinishedLanguages();
  }

  void _updateSelectedLanguage(String selected) async {
    await LanguageDB.setLanguage(selected);
    setState(() {
      languagesList = LanguageDB.getLanguagesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text('Languages',
            style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: languagesList.length,
          itemBuilder: (context, index) {
            final languageCode = languagesList[index];
            final languageName = languageNames[languageCode] ?? '';
            final isSelected = LanguageDB.getLanguage() == languageCode;

            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 150.0,
                child: FadeInAnimation(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical:
                            8.0), // * Modify the margin between each ListTile
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blueGrey[100]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          languageName,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                isSelected ? Colors.blueGrey : Colors.grey[400],
                          ),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        if (!isSelected &&
                            !notFinishedLanguages.contains(languageCode)) {
                          _updateSelectedLanguage(languageCode);
                        } else if (notFinishedLanguages
                            .contains(languageCode)) {
                          // * Show a pop up message that is not supported yet
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
