import 'package:flutter/material.dart';
import '../util/theme.dart';

import '../generated/l10n.dart';
import '../util/app_scaffold.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text(S.of(context).faq)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          faqCard(
            context,
            S.of(context).faqHowToEditItem,
            S.of(context).faqHowToEditItemAns,
          ),
          faqCard(
            context,
            S.of(context).faqWhatDoesScanSend,
            S.of(context).faqWhatDoesScanSendAns,
          ),
          faqCard(
            context,
            S.of(context).faqWhyNotificationNotWork,
            S.of(context).faqWhyNotificationNotWorkAns,
          ),
          faqCard(
            context,
            S.of(context).faqWhyNotificationDelay,
            S.of(context).faqWhyNotificationDelayAns,
          ),
          faqCard(
            context,
            S.of(context).faqWhatWillResetCategoriesDo,
            S.of(context).faqWhatWillResetCategoriesDoAns,
          ),
        ],
      ),
    );
  }

  // Function to create FAQ Card
  Widget faqCard(BuildContext context, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: context.c.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: context.c.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
                const Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: context.c.text,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 34.0,
                top: 12.0,
                bottom: 12.0,
              ),
              child: Divider(height: 1, color: context.c.border),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0),
              child: Text(
                answer,
                style: TextStyle(
                  color: context.c.textMuted,
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
