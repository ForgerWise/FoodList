import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyState();
}

class _PolicyState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(S.of(context).policy,
            style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Text(
                S.of(context).privacyContent,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
