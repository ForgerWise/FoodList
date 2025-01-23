import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';

import '../generated/l10n.dart';
import 'feedback.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  final Uri githubUri = Uri.parse("https://github.com/ForgerWise/FoodList");
  final Uri homepageUri = Uri.parse("https://www.forgerwise.com");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).about),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12),
              Text(
                S.of(context).aboutContent,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).aboutContentGithub,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).aboutContentHomepage,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackPage()),
        ),
        label: Text(S.of(context).feedback,
            style: const TextStyle(color: Colors.white)),
        icon: const Icon(Icons.rate_review, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
