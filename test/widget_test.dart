import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/database/sub_category.dart';
import 'package:foodlist/main.dart';
import 'package:foodlist/page/homepage.dart';
import 'package:foodlist/page/setting_page.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    Hive.init((await Directory.systemTemp.createTemp('foodlist_test_')).path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SubCategoryAdapter());
    }
    await Hive.openBox<dynamic>('mybox');
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'selectedLanguage': 'English',
      'notificationsEnabled': false,
    });
    await Hive.box<dynamic>('mybox').clear();
  });

  testWidgets('app launches and switches between primary destinations', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp(locale: Locale('en')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SettingPage), findsNothing);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    final navigationBar = tester.widget<NavigationBar>(
      find.byType(NavigationBar),
    );
    expect(navigationBar.selectedIndex, 1);
    expect(find.byType(SettingPage), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

}
