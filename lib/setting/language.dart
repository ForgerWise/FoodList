import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguageState();
}

class _LanguageState extends State<LanguagePage> {
  final languageNames = {
    'en': 'English',
    'ja': '日本語',
    'zh': '繁體中文',
  };

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
              title: Text('Languages',
                  style: TextStyle(color: Colors.white, fontSize: 60)),
              background: ColoredBox(color: Colors.transparent),
              titlePadding: EdgeInsets.all(24),
            ),
            floating: true,
            pinned: true,
          )
        ],
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 50),
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Colors.blueGrey,
                            ),
                            const Text(
                              "English",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
