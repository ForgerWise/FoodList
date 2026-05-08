import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';

import '../generated/l10n.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SettingAppbar(title: S.of(context).faq),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.help_outline_rounded, color: Colors.blueGrey.shade500, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, top: 12.0, bottom: 12.0),
              child: Divider(height: 1, color: Colors.grey.shade100),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0),
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15.0,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
