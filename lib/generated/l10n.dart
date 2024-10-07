// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit Ingredients`
  String get editIngredients {
    return Intl.message(
      'Edit Ingredients',
      name: 'editIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Add Ingredients`
  String get addIngredients {
    return Intl.message(
      'Add Ingredients',
      name: 'addIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory`
  String get subcategory {
    return Intl.message(
      'Subcategory',
      name: 'subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get subcategoryName {
    return Intl.message(
      'Name',
      name: 'subcategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Please input the name of the ingredient`
  String get subcategoryNameInputHint {
    return Intl.message(
      'Please input the name of the ingredient',
      name: 'subcategoryNameInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Select Subcategory`
  String get selectSubcategoryHint {
    return Intl.message(
      'Select Subcategory',
      name: 'selectSubcategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategoryHint {
    return Intl.message(
      'Select Category',
      name: 'selectCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Add to Subcategory`
  String get addToSubcategory {
    return Intl.message(
      'Add to Subcategory',
      name: 'addToSubcategory',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date`
  String get expireDate {
    return Intl.message(
      'Expire Date',
      name: 'expireDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date: {expireDate}`
  String expireDateConfirmMessage(DateTime expireDate) {
    final DateFormat expireDateDateFormat =
        DateFormat.yMd(Intl.getCurrentLocale());
    final String expireDateString = expireDateDateFormat.format(expireDate);

    return Intl.message(
      'Expire Date: $expireDateString',
      name: 'expireDateConfirmMessage',
      desc: '',
      args: [expireDateString],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Policy`
  String get policy {
    return Intl.message(
      'Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables'' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste.`
  String get aboutContent {
    return Intl.message(
      'This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables\'\' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste.',
      name: 'aboutContent',
      desc: '',
      args: [],
    );
  }

  /// `This language is not supported yet! We''re working on it!`
  String get languageNotSupportedYetMessage {
    return Intl.message(
      'This language is not supported yet! We\'\'re working on it!',
      name: 'languageNotSupportedYetMessage',
      desc: '',
      args: [],
    );
  }

  /// `Notification Setting`
  String get notificationSetting {
    return Intl.message(
      'Notification Setting',
      name: 'notificationSetting',
      desc: '',
      args: [],
    );
  }

  /// `Set the time at which you would like to receive notifications. This helps you to know which items are expiring soon. `
  String get notificationContent {
    return Intl.message(
      'Set the time at which you would like to receive notifications. This helps you to know which items are expiring soon. ',
      name: 'notificationContent',
      desc: '',
      args: [],
    );
  }

  /// `This Privacy Policy describes how our mobile application, (hereinafter referred to as ''the App''), collects, uses, and discloses your information. The App is committed to maintaining robust privacy protections for its users. Our Privacy Policy is designed to help you understand how we collect and use the personal information you decide to share and help you make informed decisions when using the App.\n\nBy using or accessing the App, you accept the practices described in this Privacy Policy. If you do not agree to this policy, please do not use the App. We reserve the right to modify this policy from time to time, so please review it frequently. Your continued use of the App signifies your acceptance of our Privacy Policy as modified.\n\n1. Data We Collect\nCurrently, the App does not collect any personal data. The App is designed to store all data related to your food within the device itself and does not have any feature to collect your personal data.\n\n2. Data Storage and Protection\nYour data is stored on your device and is not accessible by anyone but you, unless the data on your device is shared by you or your device provider.\n\n3. Future Updates\nIn future updates, if there is a feature that allows user data upload for functionalities such as synchronization, we still will not disclose this information to any third party. We will announce the update of our privacy policy when these features are added.\n\n4. Changes to Our Privacy Policy\nThe App reserves the right to change this policy and our Terms of Service at any time. We will notify users of significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a prominent notice on our site. Significant changes will go into effect 30 days following such notification. Non-material changes or clarifications will take effect immediately. You should periodically check the Site and this privacy page for updates.`
  String get privacyContent {
    return Intl.message(
      'This Privacy Policy describes how our mobile application, (hereinafter referred to as \'\'the App\'\'), collects, uses, and discloses your information. The App is committed to maintaining robust privacy protections for its users. Our Privacy Policy is designed to help you understand how we collect and use the personal information you decide to share and help you make informed decisions when using the App.\n\nBy using or accessing the App, you accept the practices described in this Privacy Policy. If you do not agree to this policy, please do not use the App. We reserve the right to modify this policy from time to time, so please review it frequently. Your continued use of the App signifies your acceptance of our Privacy Policy as modified.\n\n1. Data We Collect\nCurrently, the App does not collect any personal data. The App is designed to store all data related to your food within the device itself and does not have any feature to collect your personal data.\n\n2. Data Storage and Protection\nYour data is stored on your device and is not accessible by anyone but you, unless the data on your device is shared by you or your device provider.\n\n3. Future Updates\nIn future updates, if there is a feature that allows user data upload for functionalities such as synchronization, we still will not disclose this information to any third party. We will announce the update of our privacy policy when these features are added.\n\n4. Changes to Our Privacy Policy\nThe App reserves the right to change this policy and our Terms of Service at any time. We will notify users of significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a prominent notice on our site. Significant changes will go into effect 30 days following such notification. Non-material changes or clarifications will take effect immediately. You should periodically check the Site and this privacy page for updates.',
      name: 'privacyContent',
      desc: '',
      args: [],
    );
  }

  /// `Entry Date`
  String get entryDate {
    return Intl.message(
      'Entry Date',
      name: 'entryDate',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `and {number} more items`
  String notificationMoreItems(int number) {
    return Intl.message(
      'and $number more items',
      name: 'notificationMoreItems',
      desc: '',
      args: [number],
    );
  }

  /// `FoodList Expiry Notification`
  String get foodlistExpiryNotification {
    return Intl.message(
      'FoodList Expiry Notification',
      name: 'foodlistExpiryNotification',
      desc: '',
      args: [],
    );
  }

  /// `Expiring today: {todayItems}\nExpiring tomorrow: {tomorrowItems}`
  String foodlistExpiryNotificationContent(
      String todayItems, String tomorrowItems) {
    return Intl.message(
      'Expiring today: $todayItems\nExpiring tomorrow: $tomorrowItems',
      name: 'foodlistExpiryNotificationContent',
      desc: '',
      args: [todayItems, tomorrowItems],
    );
  }

  /// `Example`
  String get example {
    return Intl.message(
      'Example',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Slide to Delete`
  String get slideToDelete {
    return Intl.message(
      'Slide to Delete',
      name: 'slideToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Meat`
  String get meat {
    return Intl.message(
      'Meat',
      name: 'meat',
      desc: '',
      args: [],
    );
  }

  /// `Fish`
  String get fish {
    return Intl.message(
      'Fish',
      name: 'fish',
      desc: '',
      args: [],
    );
  }

  /// `Vegetable`
  String get vegetable {
    return Intl.message(
      'Vegetable',
      name: 'vegetable',
      desc: '',
      args: [],
    );
  }

  /// `Fruit`
  String get fruit {
    return Intl.message(
      'Fruit',
      name: 'fruit',
      desc: '',
      args: [],
    );
  }

  /// `Bean`
  String get bean {
    return Intl.message(
      'Bean',
      name: 'bean',
      desc: '',
      args: [],
    );
  }

  /// `Egg & Milk`
  String get eggMilk {
    return Intl.message(
      'Egg & Milk',
      name: 'eggMilk',
      desc: '',
      args: [],
    );
  }

  /// `Mushroom`
  String get mushroom {
    return Intl.message(
      'Mushroom',
      name: 'mushroom',
      desc: '',
      args: [],
    );
  }

  /// `Processed_food`
  String get processedfood {
    return Intl.message(
      'Processed_food',
      name: 'processedfood',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Beef`
  String get beef {
    return Intl.message(
      'Beef',
      name: 'beef',
      desc: '',
      args: [],
    );
  }

  /// `Pork`
  String get pork {
    return Intl.message(
      'Pork',
      name: 'pork',
      desc: '',
      args: [],
    );
  }

  /// `Chicken`
  String get chicken {
    return Intl.message(
      'Chicken',
      name: 'chicken',
      desc: '',
      args: [],
    );
  }

  /// `Other Meats`
  String get otherMeats {
    return Intl.message(
      'Other Meats',
      name: 'otherMeats',
      desc: '',
      args: [],
    );
  }

  /// `Tuna`
  String get tuna {
    return Intl.message(
      'Tuna',
      name: 'tuna',
      desc: '',
      args: [],
    );
  }

  /// `Salmon`
  String get salmon {
    return Intl.message(
      'Salmon',
      name: 'salmon',
      desc: '',
      args: [],
    );
  }

  /// `Oyster`
  String get oyster {
    return Intl.message(
      'Oyster',
      name: 'oyster',
      desc: '',
      args: [],
    );
  }

  /// `Other Fishes`
  String get otherFishes {
    return Intl.message(
      'Other Fishes',
      name: 'otherFishes',
      desc: '',
      args: [],
    );
  }

  /// `Carrot`
  String get carrot {
    return Intl.message(
      'Carrot',
      name: 'carrot',
      desc: '',
      args: [],
    );
  }

  /// `Other Vegetables`
  String get otherVegetables {
    return Intl.message(
      'Other Vegetables',
      name: 'otherVegetables',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get apple {
    return Intl.message(
      'Apple',
      name: 'apple',
      desc: '',
      args: [],
    );
  }

  /// `Other Fruits`
  String get otherFruits {
    return Intl.message(
      'Other Fruits',
      name: 'otherFruits',
      desc: '',
      args: [],
    );
  }

  /// `Soybean`
  String get soybean {
    return Intl.message(
      'Soybean',
      name: 'soybean',
      desc: '',
      args: [],
    );
  }

  /// `Other Beans`
  String get otherBeans {
    return Intl.message(
      'Other Beans',
      name: 'otherBeans',
      desc: '',
      args: [],
    );
  }

  /// `Egg`
  String get egg {
    return Intl.message(
      'Egg',
      name: 'egg',
      desc: '',
      args: [],
    );
  }

  /// `Milk`
  String get milk {
    return Intl.message(
      'Milk',
      name: 'milk',
      desc: '',
      args: [],
    );
  }

  /// `Other Egg & Milk`
  String get otherEggMilk {
    return Intl.message(
      'Other Egg & Milk',
      name: 'otherEggMilk',
      desc: '',
      args: [],
    );
  }

  /// `Other Mushrooms`
  String get otherMushrooms {
    return Intl.message(
      'Other Mushrooms',
      name: 'otherMushrooms',
      desc: '',
      args: [],
    );
  }

  /// `Other Processed Foods`
  String get otherProcessedFoods {
    return Intl.message(
      'Other Processed Foods',
      name: 'otherProcessedFoods',
      desc: '',
      args: [],
    );
  }

  /// `Other Items`
  String get otherItems {
    return Intl.message(
      'Other Items',
      name: 'otherItems',
      desc: '',
      args: [],
    );
  }

  /// `Selected Time: {selectedHour}:{selectedMinute}`
  String selectedTime(String selectedHour, String selectedMinute) {
    return Intl.message(
      'Selected Time: $selectedHour:$selectedMinute',
      name: 'selectedTime',
      desc: '',
      args: [selectedHour, selectedMinute],
    );
  }

  /// `Notifications may be delayed on some devices due to battery optimization settings or android restrictions.`
  String get notificationContentWarn {
    return Intl.message(
      'Notifications may be delayed on some devices due to battery optimization settings or android restrictions.',
      name: 'notificationContentWarn',
      desc: '',
      args: [],
    );
  }

  /// `other`
  String get other {
    return Intl.message(
      'other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Why didn''t the data load to the edit page automatically?`
  String get faqWhyEditNotLoad {
    return Intl.message(
      'Why didn\'\'t the data load to the edit page automatically?',
      name: 'faqWhyEditNotLoad',
      desc: '',
      args: [],
    );
  }

  /// `Due to the data structure, if your data was saved in a different language previously, it will not be loaded automatically. However, you can still edit it starting from a blank state.`
  String get faqWhyEditNotLoadAns {
    return Intl.message(
      'Due to the data structure, if your data was saved in a different language previously, it will not be loaded automatically. However, you can still edit it starting from a blank state.',
      name: 'faqWhyEditNotLoadAns',
      desc: '',
      args: [],
    );
  }

  /// `Why isn''t the notification working?`
  String get faqWhyNotificationNotWork {
    return Intl.message(
      'Why isn\'\'t the notification working?',
      name: 'faqWhyNotificationNotWork',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that you have enabled notifications for the app in your device settings. If it still doesn''t work, check the battery optimization settings and disable battery optimization for the app.`
  String get faqWhyNotificationNotWorkAns {
    return Intl.message(
      'Please ensure that you have enabled notifications for the app in your device settings. If it still doesn\'\'t work, check the battery optimization settings and disable battery optimization for the app.',
      name: 'faqWhyNotificationNotWorkAns',
      desc: '',
      args: [],
    );
  }

  /// `Why is the notification being delayed?`
  String get faqWhyNotificationDelay {
    return Intl.message(
      'Why is the notification being delayed?',
      name: 'faqWhyNotificationDelay',
      desc: '',
      args: [],
    );
  }

  /// `Notifications may be delayed on some devices due to battery optimization settings or android restrictions.`
  String get faqWhyNotificationDelayAns {
    return Intl.message(
      'Notifications may be delayed on some devices due to battery optimization settings or android restrictions.',
      name: 'faqWhyNotificationDelayAns',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}