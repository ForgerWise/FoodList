import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../generated/l10n.dart';

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
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: SvgPicture.asset(
                      'assets/images/github-mark.svg',
                      width: 24,
                      height: 24,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    label: Text(
                      S.of(context).githubRepository,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (await canLaunchUrl(githubUri)) {
                        await launchUrl(githubUri);
                      } else {
                        throw 'Could not launch $githubUri';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/images/FW-logo-icon.png',
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      S.of(context).homepage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (await canLaunchUrl(homepageUri)) {
                        await launchUrl(homepageUri);
                      } else {
                        throw 'Could not launch $homepageUri';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
