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
      appBar: SettingAppbar(title: S.of(context).feedback),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(S.of(context).versionVersion(_version),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ),
          const SizedBox(height: 12),
          const Divider(),
          _buildTextButton(S.of(context).rateThisApp, () {
            _launchUrl(Uri.parse(foodlistPlayStoreUrl));
          }),
          const Divider(),
          _buildTextButton(S.of(context).officialWebsite, () {
            _launchUrl(Uri.parse(forgerwiseOfficialWebsite));
          }),
          const Divider(),
          _buildTextButton(S.of(context).forgerwisesGithub, () {
            _launchUrl(Uri.parse(forgerwiseGithub));
          }),
          const Divider(),
          _buildTextButton(S.of(context).contactUs, () {
            _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfContactUs));
          }),
          const Divider(),
          _buildTextButton(S.of(context).bugReport, () {
            _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfBugReport,
                message: messageOfBugReport));
          }),
          const Divider(),
          _buildTextButton(S.of(context).translationError, () {
            _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfTranslationError,
                message: messageOfTranslationError));
          }),
          const Divider(),
          _buildTextButton(S.of(context).contributeTranslation, () {
            _launchUrl(_combineEmailAndTitleAndMessage(
                forgerwiseEmail, titleOfContributeTranslation,
                message: messageOfContributeTranslation));
          }),
          const Divider(),
          _buildTextButton(S.of(context).contributeCode, () {
            _launchUrl(Uri.parse(foodlistGithubRepository));
          }),
          const Divider(),
          const SizedBox(height: 12),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Special thanks to all contributors below!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "PBL 12班のみんな",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextButton _buildTextButton(String text, Function() onPressed) {
    return TextButton(onPressed: onPressed, child: _buildTextText(text));
  }

  Text _buildTextText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey));
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
