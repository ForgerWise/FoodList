import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/data.dart';
import 'database/languagedb.dart';
import 'generated/l10n.dart';
import 'page/add_page.dart';
import 'page/homepage.dart';
import 'page/setting_page.dart';
import 'util/alarm.dart';
import 'util/app_settings.dart';
import 'util/notification.dart';
import 'util/review.dart';
import 'util/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await openStorage();
  await NotificationService().init();
  await AlarmService().init();
  await ReviewService.markFirstOpen();
  await AppSettings.load();

  final locale = LanguageDB.languageToLocale(await LanguageDB.getLanguage());

  // Keep Flutter in edge-to-edge mode without using deprecated system bar
  // color APIs. Android enables the backward-compatible window behavior in
  // MainActivity.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MyApp(locale: locale));
}

class MyApp extends StatefulWidget {
  final Locale? locale;
  const MyApp({Key? key, this.locale}) : super(key: key);

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, mode, _) => MaterialApp(
        title: 'Foodlist',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/add': (context) => const AddPage(),
        },
        theme: buildAppTheme(Brightness.light),
        darkTheme: buildAppTheme(Brightness.dark),
        themeMode: mode,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [const HomePage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => index = 0); // back on Settings → Home
      },
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.kitchen_outlined),
              selectedIcon: const Icon(Icons.kitchen, color: AppColors.primary),
              label: S.of(context).home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(
                Icons.settings,
                color: AppColors.primary,
              ),
              label: S.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
