import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        backgroundColor: Colors.blueGrey,
        title: Text(S.of(context).about,
            style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 12),
              Text(
                S.of(context).aboutContent,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
