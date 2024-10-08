import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        backgroundColor: Colors.blueGrey,
        title: Text(S.of(context).faq,
            style: const TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
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
          // Add more FAQ cards here
        ],
      ),
    );
  }

  // Function to create FAQ Card
  Widget faqCard(String question, String answer) {
    return Card(
      color: Colors.blueGrey[300],
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
              ),
            ),
            const SizedBox(height: 8.0),
            Text(answer),
          ],
        ),
      ),
    );
  }
}
