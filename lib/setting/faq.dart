import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';

import '../generated/l10n.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).faq),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          faqCard(S.of(context).faqWhyEditNotLoad,
              S.of(context).faqWhyEditNotLoadAns),
          faqCard(S.of(context).faqWhyNotificationNotWork,
              S.of(context).faqWhyNotificationNotWorkAns),
          faqCard(S.of(context).faqWhyNotificationDelay,
              S.of(context).faqWhyNotificationDelayAns),
          faqCard(S.of(context).faqWhatWillResetCategoriesDo,
              S.of(context).faqWhatWillResetCategoriesDoAns),
          faqCard(S.of(context).faqHowToEditSubcategories,
              S.of(context).faqHowToEditSubcategoriesAns),
        ],
      ),
    );
  }

  // Function to create FAQ Card
  Widget faqCard(String question, String answer) {
    return Card(
      color: Colors.blueGrey[700],
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(answer, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
