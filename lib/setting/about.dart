import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/theme.dart';

import '../generated/l10n.dart';
import '../util/app_scaffold.dart';

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
    return AppScaffold(
      appBar: AppBar(title: Text(S.of(context).about)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).aboutContent,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: context.c.text,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 32),
            Divider(color: context.c.border, height: 1),
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
            const SizedBox(height: 24),

            // Required attributions: Open Food Facts (ODbL) and Yahoo! JAPAN
            // Web API credit (exact wording, linked).
            _buildSection(
              title: S.of(context).dataSources,
              content: S.of(context).dataSourcesContent,
              url: Uri.parse('https://world.openfoodfacts.org/'),
            ),
            _buildSection(
              title: 'Web Services by Yahoo! JAPAN',
              content: '',
              url: Uri.parse('https://developer.yahoo.co.jp/sitemap/'),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    Uri? url,
  }) {
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
                color: context.c.accent,
                letterSpacing: 1.0,
              ),
            ),
            if (url != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.open_in_new, size: 14, color: context.c.accent),
            ],
          ],
        ),
        if (content.isNotEmpty) const SizedBox(height: 8),
        if (content.isNotEmpty)
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: context.c.text,
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
