import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../generated/l10n.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => FeedbackState();
}

class FeedbackState extends State<FeedbackPage> {
  String foodlistPlayStoreUrl =
      "https://play.google.com/store/apps/details?id=com.forgerwise.foodlist";
  String forgerwiseOfficialWebsite = "https://www.forgerwise.com";
  String forgerwiseGithub = "https://github.com/ForgerWise";
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SettingAppbar(title: S.of(context).feedback),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        children: [
          Center(
            child: Text(S.of(context).versionVersion(_version),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ),
          const SizedBox(height: 32),
          _buildListItem(
            icon: Icons.star_rate_rounded,
            title: S.of(context).rateThisApp,
            onTap: () => _launchUrl(Uri.parse(foodlistPlayStoreUrl)),
          ),
          _buildListItem(
            icon: Icons.language_rounded,
            title: S.of(context).officialWebsite,
            onTap: () => _launchUrl(Uri.parse(forgerwiseOfficialWebsite)),
          ),
          _buildListItem(
            icon: Icons.code_rounded,
            title: S.of(context).forgerwisesGithub,
            onTap: () => _launchUrl(Uri.parse(forgerwiseGithub)),
          ),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.mail_outline_rounded,
            title: S.of(context).contactUs,
            onTap: () => _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfContactUs)),
          ),
          _buildListItem(
            icon: Icons.bug_report_outlined,
            title: S.of(context).bugReport,
            onTap: () => _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfBugReport,
                message: messageOfBugReport)),
          ),
          _buildListItem(
            icon: Icons.g_translate_rounded,
            title: S.of(context).translationError,
            onTap: () => _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfTranslationError,
                message: messageOfTranslationError)),
          ),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.translate_rounded,
            title: S.of(context).contributeTranslation,
            onTap: () => _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfContributeTranslation,
                message: messageOfContributeTranslation)),
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "PBL 12班のみんな",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
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
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey.shade500),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade300, size: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        onTap: onTap,
      ),
    );
  }

  Uri _combineEmailAndTitleAndMessage(String email, String title,
      {String message = ""}) {
    return Uri.parse("mailto:$email?subject=$title&body=$message");
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
        SnackBar(
            content: Text(S.of(context).urlCopiedToClipboard),
            backgroundColor: Colors.blueGrey),
      );
    }
  }
}
