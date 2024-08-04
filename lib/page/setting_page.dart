import 'package:flutter/material.dart';

import '../setting/language.dart';
import '../setting/policy.dart';
import '../setting/about.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final String email = "forgerwise@gmail.com";

  void _sendMail() {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      launchUrl(emailUri);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text('Settings',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(
                Icons.language,
                color: Colors.black,
                size: 24,
              ),
              title: const Text(
                'Languages',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguagePage(),
                  ),
                )
              },
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(
                Icons.policy,
                color: Colors.black,
                size: 24,
              ),
              title: const Text(
                'Policy',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PolicyPage(),
                  ),
                )
              },
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.black,
                size: 24,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                )
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sendMail,
        label: const Text("Contact Us", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.email, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
