// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodlist/database/languagedb.dart';
import 'package:foodlist/util/alarm.dart';
import 'package:foodlist/util/notification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/sub_category.dart';
import 'generated/l10n.dart';
import 'page/add_page.dart';
import 'page/homepage.dart';
import 'page/setting_page.dart';
import 'setting/faq.dart';
import 'setting/language.dart';
import 'setting/notification.dart';
import 'setting/policy.dart';
import 'setting/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SubCategoryAdapter());
  var box = await Hive.openBox("mybox");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('selectedLanguage');

  await NotificationService().init();
  await AlarmService().init();

  Locale? locale;
  if (languageCode != null) {
    locale = LanguageDB.languageToLocale(languageCode);
  } else {
    locale = LanguageDB.languageToLocale(
        await LanguageDB.getLanguageWithoutContext());
  }

  runApp(MyApp(locale: locale));
}

class MyApp extends StatefulWidget {
  final Locale? locale;
  const MyApp({Key? key, this.locale}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      title: 'Foodlist',
      locale: _locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/home': (context) => const HomePage(),
        '/add': (context) => AddPage(),
        '/setting': (context) => SettingPage(),
        '/language': (context) => LanguagePage(),
        '/policy': (context) => const PolicyPage(),
        '/about': (context) => const AboutPage(),
        '/notification': (context) => const NotificationSettingPage(),
        '/faq': (context) => FAQPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'IBM Plex Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
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
  final screens = [
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueGrey,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: S.of(context).home,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings, color: Colors.white),
              label: S.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
