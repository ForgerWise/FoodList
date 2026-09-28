import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../util/theme.dart';

import '../generated/l10n.dart';
import '../util/app_scaffold.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => FeedbackState();
}

class FeedbackState extends State<FeedbackPage> {
  String forgerwiseEmail = "forgerwise@gmail.com";
  String foodlistGithubRepository = "https://github.com/ForgerWise/FoodList";

  String titleOfContactUs = S.current.aboutFoodlist;
  String titleOfBugReport = S.current.bugReportOfFoodlist;
  String messageOfBugReport = S.current.mesOfBugReport;
  String titleOfTranslationError = S.current.translationErrorOfFoodlist;
  String messageOfTranslationError = S.current.mesOfTransError;
  String titleOfContributeTranslation =
      S.current.contributeTranslationOfFoodlist;
  String messageOfContributeTranslation = S.current.mesOfContributeTrans;

  String _version = "";

  @override
  void initState() {
    super.initState();
    _initVersion();
  }

  Future<void> _initVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text(S.of(context).feedback)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              S.of(context).versionVersion(_version),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.c.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildListItem(
            icon: Icons.mail_outline_rounded,
            title: S.of(context).contactUs,
            onTap: () => _launchUrl(
              _combineEmailAndTitleAndMessage(
                forgerwiseEmail,
                titleOfContactUs,
              ),
            ),
          ),
          _buildListItem(
            icon: Icons.bug_report_outlined,
            title: S.of(context).bugReport,
            onTap: () => _launchUrl(
              _combineEmailAndTitleAndMessage(
                forgerwiseEmail,
                titleOfBugReport,
                message: messageOfBugReport,
              ),
            ),
          ),
          _buildListItem(
            icon: Icons.g_translate_rounded,
            title: S.of(context).translationError,
            onTap: () => _launchUrl(
              _combineEmailAndTitleAndMessage(
                forgerwiseEmail,
                titleOfTranslationError,
                message: messageOfTranslationError,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.translate_rounded,
            title: S.of(context).contributeTranslation,
            onTap: () => _launchUrl(
              _combineEmailAndTitleAndMessage(
                forgerwiseEmail,
                titleOfContributeTranslation,
                message: messageOfContributeTranslation,
              ),
            ),
          ),
          _buildListItem(
            icon: Icons.integration_instructions_outlined,
            title: S.of(context).contributeCode,
            onTap: () => _launchUrl(Uri.parse(foodlistGithubRepository)),
          ),
          const SizedBox(height: 48),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).specialThanksToAllContributorsBelow,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: context.c.accent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "PBL 12班のみんな",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: context.c.accent,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(icon, color: context.c.accent),
          title: Text(title, style: const TextStyle(fontSize: 15)),
          trailing: Icon(Icons.chevron_right, color: context.c.textMuted),
          onTap: onTap,
        ),
      ),
    );
  }

  Uri _combineEmailAndTitleAndMessage(
    String email,
    String title, {
    String message = "",
  }) {
    // Encoded properly so spaces / CJK / line breaks survive every mail app.
    final body = [
      if (message.isNotEmpty) message,
      'FoodList $_version',
    ].join('\n\n');
    return Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=${Uri.encodeComponent(title)}&body=${Uri.encodeComponent(body)}',
    );
  }

  void _launchUrl(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      _copyUrlToClipboard(url.toString());
    }
  }

  void _copyUrlToClipboard(String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).urlCopiedToClipboard)),
      );
    }
  }
}
