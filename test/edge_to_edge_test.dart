import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/generated/l10n.dart';
import 'package:foodlist/util/app_scaffold.dart';

void main() {
  testWidgets('application scaffold applies horizontal and bottom insets', (
    tester,
  ) async {
    const bodyKey = Key('safe-body');
    late MediaQueryData bodyMediaQuery;

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: const MediaQueryData(
            size: Size(800, 600),
            padding: EdgeInsets.fromLTRB(18, 32, 24, 40),
            viewPadding: EdgeInsets.fromLTRB(18, 32, 24, 40),
          ),
          child: child!,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: AppScaffold(
          appBar: AppBar(title: const Text('Insets')),
          body: Builder(
            builder: (context) {
              bodyMediaQuery = MediaQuery.of(context);
              return const SizedBox.expand(key: bodyKey);
            },
          ),
        ),
      ),
    );
    await tester.pump();

    final bodyRect = tester.getRect(find.byKey(bodyKey));
    expect(bodyRect.left, 18);
    expect(bodyRect.right, 776);
    expect(bodyRect.bottom, 560);
    expect(bodyMediaQuery.padding.left, 0);
    expect(bodyMediaQuery.padding.right, 0);
    expect(bodyMediaQuery.padding.bottom, 0);
    expect(bodyMediaQuery.padding.top, 0);
  });
}
