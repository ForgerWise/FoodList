import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.white,
      appBar: SettingAppbar(title: S.of(context).about),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).aboutContent,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: Colors.black12, height: 1),
            const SizedBox(height: 32),
            
            _buildSection(
              title: 'GitHub',
              content: S.of(context).aboutContentGithub,
              url: githubUri,
            ),
            const SizedBox(height: 24),
            
            _buildSection(
              title: S.of(context).officialWebsite,
              content: S.of(context).aboutContentHomepage,
              url: homepageUri,
            ),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackPage()),
        ),
        label: Text(S.of(context).feedback,
            style: const TextStyle(color: Colors.white)),
        icon: const Icon(Icons.rate_review_outlined, color: Colors.white),
        backgroundColor: Colors.blueGrey,
        elevation: 2,
      ),
    );
  }

  Widget _buildSection({required String title, required String content, Uri? url}) {
    Widget section = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: url != null ? Colors.blue : Colors.blueGrey,
                letterSpacing: 1.0,
              ),
            ),
            if (url != null) ...[
              const SizedBox(width: 4),
              const Icon(Icons.open_in_new, size: 14, color: Colors.blue),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Colors.black87,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );

    if (url != null) {
      return InkWell(
        onTap: () async {
          try {
            await launchUrl(url);
          } catch (e) {
            debugPrint('Could not launch $url: $e');
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: section,
        ),
      );
    }
    return section;
  }
}

