import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../util/app_scaffold.dart';
import '../util/theme.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyState();
}

class _PolicyState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text(S.of(context).policy)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).privacyContent,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: context.c.text,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
