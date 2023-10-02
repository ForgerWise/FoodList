import 'package:flutter/material.dart';
import 'package:refrigerator_manage/setting/author.dart';
import 'package:refrigerator_manage/setting/special_thanks.dart';

import '../setting/language.dart';
import '../setting/policy.dart';
import '../setting/about.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            shape: Border(
                bottom:
                    BorderSide(color: Colors.black54, style: BorderStyle.none)),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1,
              title: Text('Settings',
                  style: TextStyle(color: Colors.white, fontSize: 70)),
              background: ColoredBox(color: Colors.transparent),
            ),
            floating: true,
            pinned: true,
          )
        ],
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
                  'Privacy Policy',
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
                  'About App',
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
      ),
    );
  }
}
