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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Edit Ingredient`
  String get editIngredients {
    return Intl.message(
      'Edit Ingredient',
      name: 'editIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Add Ingredient`
  String get addIngredients {
    return Intl.message(
      'Add Ingredient',
      name: 'addIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Name`
  String get ingredientName {
    return Intl.message('Name', name: 'ingredientName', desc: '', args: []);
  }

  /// `Name, or pick below`
  String get ingredientNameHint {
    return Intl.message(
      'Name, or pick below',
      name: 'ingredientNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Expiry Date`
  String get expireDate {
    return Intl.message('Expiry Date', name: 'expireDate', desc: '', args: []);
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Expire Date: {expireDate}`
  String expireDateConfirmMessage(DateTime expireDate) {
    final DateFormat expireDateDateFormat = DateFormat.yMd(
      Intl.getCurrentLocale(),
    );
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
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
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
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `Policy`
  String get policy {
    return Intl.message('Policy', name: 'policy', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste.`
  String get aboutContent {
    return Intl.message(
      'This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables\' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste.',
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

  /// `Get one reminder a day about items expiring today and tomorrow.`
  String get notificationContent {
    return Intl.message(
      'Get one reminder a day about items expiring today and tomorrow.',
      name: 'notificationContent',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: 2026-09-28 (version 3.1.0)\n\nYour food list never leaves your phone, and we do not collect personal data.\n\n1. Data on your device\nEverything you enter — items, dates, quantities, categories and settings — is stored only on your device. There is no server and no account. Uninstalling the app deletes it.\n\n2. Barcode scanning (optional)\nThe camera is used only while the scan screen is open; images are processed on the device and never saved or uploaded.\nTo fill in a product name, only the barcode number is sent to Open Food Facts and, for Japanese products, the Yahoo! JAPAN Shopping Web API. No name, account or location is sent. Like any web request, these services can see your IP address.\nNames you type for barcodes are remembered on your device.\n\n3. Notifications\nReminders are scheduled and shown locally. Nothing is sent to a server.\n\n4. Ratings\nThe app may show Google Play's built-in rating dialog, which is provided by Google. FoodList receives no data from it.\n\n5. Changes\nIf a future version sends more data (for example, sync), this policy will be updated first.\n\nContact: forgerwise@gmail.com`
  String get privacyContent {
    return Intl.message(
      'Last updated: 2026-09-28 (version 3.1.0)\n\nYour food list never leaves your phone, and we do not collect personal data.\n\n1. Data on your device\nEverything you enter — items, dates, quantities, categories and settings — is stored only on your device. There is no server and no account. Uninstalling the app deletes it.\n\n2. Barcode scanning (optional)\nThe camera is used only while the scan screen is open; images are processed on the device and never saved or uploaded.\nTo fill in a product name, only the barcode number is sent to Open Food Facts and, for Japanese products, the Yahoo! JAPAN Shopping Web API. No name, account or location is sent. Like any web request, these services can see your IP address.\nNames you type for barcodes are remembered on your device.\n\n3. Notifications\nReminders are scheduled and shown locally. Nothing is sent to a server.\n\n4. Ratings\nThe app may show Google Play\'s built-in rating dialog, which is provided by Google. FoodList receives no data from it.\n\n5. Changes\nIf a future version sends more data (for example, sync), this policy will be updated first.\n\nContact: forgerwise@gmail.com',
      name: 'privacyContent',
      desc: '',
      args: [],
    );
  }

  /// `Entry Date`
  String get entryDate {
    return Intl.message('Entry Date', name: 'entryDate', desc: '', args: []);
  }

  /// `{days} days left`
  String daysLeft(int days) {
    return Intl.message(
      '$days days left',
      name: 'daysLeft',
      desc: '',
      args: [days],
    );
  }

  /// `Expires today!`
  String get expiresToday {
    return Intl.message(
      'Expires today!',
      name: 'expiresToday',
      desc: '',
      args: [],
    );
  }

  /// `Expires tomorrow!`
  String get expiresTomorrow {
    return Intl.message(
      'Expires tomorrow!',
      name: 'expiresTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `{days, plural, =1{Expired yesterday} other{Expired {days} days ago}}`
  String expiredDaysAgo(int days) {
    return Intl.plural(
      days,
      one: 'Expired yesterday',
      other: 'Expired $days days ago',
      name: 'expiredDaysAgo',
      desc: '',
      args: [days],
    );
  }

  /// `Expired`
  String get summaryExpired {
    return Intl.message('Expired', name: 'summaryExpired', desc: '', args: []);
  }

  /// `Expiring Soon`
  String get summaryExpiringSoon {
    return Intl.message(
      'Expiring Soon',
      name: 'summaryExpiringSoon',
      desc: '',
      args: [],
    );
  }

  /// `Fresh`
  String get summaryFresh {
    return Intl.message('Fresh', name: 'summaryFresh', desc: '', args: []);
  }

  /// `All`
  String get filterAll {
    return Intl.message('All', name: 'filterAll', desc: '', args: []);
  }

  /// `Expiring Soon`
  String get filterExpiringSoon {
    return Intl.message(
      'Expiring Soon',
      name: 'filterExpiringSoon',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get filterExpired {
    return Intl.message('Expired', name: 'filterExpired', desc: '', args: []);
  }

  /// `Search ingredients...`
  String get searchHint {
    return Intl.message(
      'Search ingredients...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `No ingredients yet`
  String get noIngredients {
    return Intl.message(
      'No ingredients yet',
      name: 'noIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Tap + to add your first ingredient!`
  String get noIngredientsHint {
    return Intl.message(
      'Tap + to add your first ingredient!',
      name: 'noIngredientsHint',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
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

  /// `🍱 Food Expiry Reminder`
  String get foodlistExpiryNotification {
    return Intl.message(
      '🍱 Food Expiry Reminder',
      name: 'foodlistExpiryNotification',
      desc: '',
      args: [],
    );
  }

  /// `Today: {todayItems} / Tomorrow: {tomorrowItems}`
  String foodlistExpiryNotificationContent(
    String todayItems,
    String tomorrowItems,
  ) {
    return Intl.message(
      'Today: $todayItems / Tomorrow: $tomorrowItems',
      name: 'foodlistExpiryNotificationContent',
      desc: '',
      args: [todayItems, tomorrowItems],
    );
  }

  /// `Example`
  String get example {
    return Intl.message('Example', name: 'example', desc: '', args: []);
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
    return Intl.message('Meat', name: 'meat', desc: '', args: []);
  }

  /// `Fish`
  String get fish {
    return Intl.message('Fish', name: 'fish', desc: '', args: []);
  }

  /// `Vegetable`
  String get vegetable {
    return Intl.message('Vegetable', name: 'vegetable', desc: '', args: []);
  }

  /// `Fruit`
  String get fruit {
    return Intl.message('Fruit', name: 'fruit', desc: '', args: []);
  }

  /// `Bean`
  String get bean {
    return Intl.message('Bean', name: 'bean', desc: '', args: []);
  }

  /// `Egg & Milk`
  String get eggMilk {
    return Intl.message('Egg & Milk', name: 'eggMilk', desc: '', args: []);
  }

  /// `Mushroom`
  String get mushroom {
    return Intl.message('Mushroom', name: 'mushroom', desc: '', args: []);
  }

  /// `Processed Food`
  String get processedfood {
    return Intl.message(
      'Processed Food',
      name: 'processedfood',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message('Others', name: 'others', desc: '', args: []);
  }

  /// `Beef`
  String get beef {
    return Intl.message('Beef', name: 'beef', desc: '', args: []);
  }

  /// `Pork`
  String get pork {
    return Intl.message('Pork', name: 'pork', desc: '', args: []);
  }

  /// `Chicken`
  String get chicken {
    return Intl.message('Chicken', name: 'chicken', desc: '', args: []);
  }

  /// `Other Meats`
  String get otherMeats {
    return Intl.message('Other Meats', name: 'otherMeats', desc: '', args: []);
  }

  /// `Tuna`
  String get tuna {
    return Intl.message('Tuna', name: 'tuna', desc: '', args: []);
  }

  /// `Salmon`
  String get salmon {
    return Intl.message('Salmon', name: 'salmon', desc: '', args: []);
  }

  /// `Oyster`
  String get oyster {
    return Intl.message('Oyster', name: 'oyster', desc: '', args: []);
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
    return Intl.message('Carrot', name: 'carrot', desc: '', args: []);
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
    return Intl.message('Apple', name: 'apple', desc: '', args: []);
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
    return Intl.message('Soybean', name: 'soybean', desc: '', args: []);
  }

  /// `Other Beans`
  String get otherBeans {
    return Intl.message('Other Beans', name: 'otherBeans', desc: '', args: []);
  }

  /// `Egg`
  String get egg {
    return Intl.message('Egg', name: 'egg', desc: '', args: []);
  }

  /// `Milk`
  String get milk {
    return Intl.message('Milk', name: 'milk', desc: '', args: []);
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
    return Intl.message('Other Items', name: 'otherItems', desc: '', args: []);
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

  /// `Notifications may arrive a few minutes after the set time on some devices. This is expected behavior due to Android battery optimization.`
  String get notificationContentWarn {
    return Intl.message(
      'Notifications may arrive a few minutes after the set time on some devices. This is expected behavior due to Android battery optimization.',
      name: 'notificationContentWarn',
      desc: '',
      args: [],
    );
  }

  /// `other`
  String get other {
    return Intl.message('other', name: 'other', desc: '', args: []);
  }

  /// `FAQ`
  String get faq {
    return Intl.message('FAQ', name: 'faq', desc: '', args: []);
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

  /// `1. Go to your device Settings > Apps > FoodList > Notifications and make sure notifications are enabled.\n2. Disable battery optimization for FoodList (Settings > Battery > Battery Optimization > FoodList > Don''t optimize).\n3. Toggle the notification switch off and on again in the app to re-register the alarm.`
  String get faqWhyNotificationNotWorkAns {
    return Intl.message(
      '1. Go to your device Settings > Apps > FoodList > Notifications and make sure notifications are enabled.\n2. Disable battery optimization for FoodList (Settings > Battery > Battery Optimization > FoodList > Don\'\'t optimize).\n3. Toggle the notification switch off and on again in the app to re-register the alarm.',
      name: 'faqWhyNotificationNotWorkAns',
      desc: '',
      args: [],
    );
  }

  /// `Why is the notification delayed?`
  String get faqWhyNotificationDelay {
    return Intl.message(
      'Why is the notification delayed?',
      name: 'faqWhyNotificationDelay',
      desc: '',
      args: [],
    );
  }

  /// `FoodList uses a system alarm that may be delayed by a few minutes by Android to save battery. This is normal and expected. If the delay is more than 30 minutes, try disabling battery optimization for the app.`
  String get faqWhyNotificationDelayAns {
    return Intl.message(
      'FoodList uses a system alarm that may be delayed by a few minutes by Android to save battery. This is normal and expected. If the delay is more than 30 minutes, try disabling battery optimization for the app.',
      name: 'faqWhyNotificationDelayAns',
      desc: '',
      args: [],
    );
  }

  /// `Edit/Reset Categories`
  String get editResetCategories {
    return Intl.message(
      'Edit/Reset Categories',
      name: 'editResetCategories',
      desc: '',
      args: [],
    );
  }

  /// `Edit categories is not supported yet!`
  String get editCategoriesNotSupportedHint {
    return Intl.message(
      'Edit categories is not supported yet!',
      name: 'editCategoriesNotSupportedHint',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Confirm Reset`
  String get confirmReset {
    return Intl.message(
      'Confirm Reset',
      name: 'confirmReset',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset the categories to default?`
  String get categoriesResetHint {
    return Intl.message(
      'Are you sure you want to reset the categories to default?',
      name: 'categoriesResetHint',
      desc: '',
      args: [],
    );
  }

  /// `What will happen if I reset the categories?`
  String get faqWhatWillResetCategoriesDo {
    return Intl.message(
      'What will happen if I reset the categories?',
      name: 'faqWhatWillResetCategoriesDo',
      desc: '',
      args: [],
    );
  }

  /// `Resetting restores the default categories and icons. Your saved ingredients are not deleted.`
  String get faqWhatWillResetCategoriesDoAns {
    return Intl.message(
      'Resetting restores the default categories and icons. Your saved ingredients are not deleted.',
      name: 'faqWhatWillResetCategoriesDoAns',
      desc: '',
      args: [],
    );
  }

  /// `This app is totally open source and free to use. If you have any suggestions or want to contribute to this project, feel free to visit the GitHub repository.`
  String get aboutContentGithub {
    return Intl.message(
      'This app is totally open source and free to use. If you have any suggestions or want to contribute to this project, feel free to visit the GitHub repository.',
      name: 'aboutContentGithub',
      desc: '',
      args: [],
    );
  }

  /// `GitHub Repository`
  String get githubRepository {
    return Intl.message(
      'GitHub Repository',
      name: 'githubRepository',
      desc: '',
      args: [],
    );
  }

  /// `If you have interest in other our projects, please visit our homepage.`
  String get aboutContentHomepage {
    return Intl.message(
      'If you have interest in other our projects, please visit our homepage.',
      name: 'aboutContentHomepage',
      desc: '',
      args: [],
    );
  }

  /// `ForgerWise`
  String get forgerwise {
    return Intl.message('ForgerWise', name: 'forgerwise', desc: '', args: []);
  }

  /// `FoodList`
  String get foodlist {
    return Intl.message('FoodList', name: 'foodlist', desc: '', args: []);
  }

  /// `This ingredient's Category or Subcategory is deleted, cannot edit. If you want to edit the content of this ingredient, please delete the ingredient and add again.`
  String get catOrSubcatIsDelError {
    return Intl.message(
      'This ingredient\'s Category or Subcategory is deleted, cannot edit. If you want to edit the content of this ingredient, please delete the ingredient and add again.',
      name: 'catOrSubcatIsDelError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Delete this category? Items in it will move to "Others".`
  String get confirmCategoryDelete {
    return Intl.message(
      'Delete this category? Items in it will move to "Others".',
      name: 'confirmCategoryDelete',
      desc: '',
      args: [],
    );
  }

  /// `Enter new category name`
  String get enterNewCategoryName {
    return Intl.message(
      'Enter new category name',
      name: 'enterNewCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit Subcategory`
  String get editSubcategory {
    return Intl.message(
      'Edit Subcategory',
      name: 'editSubcategory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this subcategory?`
  String get confirmsubcategorydelete {
    return Intl.message(
      'Are you sure you want to delete this subcategory?',
      name: 'confirmsubcategorydelete',
      desc: '',
      args: [],
    );
  }

  /// `Edit Subategory`
  String get editSubategory {
    return Intl.message(
      'Edit Subategory',
      name: 'editSubategory',
      desc: '',
      args: [],
    );
  }

  /// `Enter new subcategory name`
  String get enterNewSubcategoryName {
    return Intl.message(
      'Enter new subcategory name',
      name: 'enterNewSubcategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Add Subcategory`
  String get addSubcategory {
    return Intl.message(
      'Add Subcategory',
      name: 'addSubcategory',
      desc: '',
      args: [],
    );
  }

  /// `To edit subcategories, tap on the category you want to edit. Then you will be redirected to the subcategory edit page.`
  String get faqHowToEditSubcategoriesAns {
    return Intl.message(
      'To edit subcategories, tap on the category you want to edit. Then you will be redirected to the subcategory edit page.',
      name: 'faqHowToEditSubcategoriesAns',
      desc: '',
      args: [],
    );
  }

  /// `How to edit subcategories?`
  String get faqHowToEditSubcategories {
    return Intl.message(
      'How to edit subcategories?',
      name: 'faqHowToEditSubcategories',
      desc: '',
      args: [],
    );
  }

  /// `Email copied to clipboard`
  String get emailCopiedToClipboard {
    return Intl.message(
      'Email copied to clipboard',
      name: 'emailCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Homepage`
  String get homepage {
    return Intl.message('Homepage', name: 'homepage', desc: '', args: []);
  }

  /// `URL copied to clipboard`
  String get urlCopiedToClipboard {
    return Intl.message(
      'URL copied to clipboard',
      name: 'urlCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `Rate this app`
  String get rateThisApp {
    return Intl.message(
      'Rate this app',
      name: 'rateThisApp',
      desc: '',
      args: [],
    );
  }

  /// `Official website`
  String get officialWebsite {
    return Intl.message(
      'Official website',
      name: 'officialWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Translation error`
  String get translationError {
    return Intl.message(
      'Translation error',
      name: 'translationError',
      desc: '',
      args: [],
    );
  }

  /// `Contribute translation`
  String get contributeTranslation {
    return Intl.message(
      'Contribute translation',
      name: 'contributeTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Contribute code`
  String get contributeCode {
    return Intl.message(
      'Contribute code',
      name: 'contributeCode',
      desc: '',
      args: [],
    );
  }

  /// `ForgerWise's GitHub`
  String get forgerwisesGithub {
    return Intl.message(
      'ForgerWise\'s GitHub',
      name: 'forgerwisesGithub',
      desc: '',
      args: [],
    );
  }

  /// `Bug report`
  String get bugReport {
    return Intl.message('Bug report', name: 'bugReport', desc: '', args: []);
  }

  /// `About FoodList`
  String get aboutFoodlist {
    return Intl.message(
      'About FoodList',
      name: 'aboutFoodlist',
      desc: '',
      args: [],
    );
  }

  /// `Bug Report of FoodList`
  String get bugReportOfFoodlist {
    return Intl.message(
      'Bug Report of FoodList',
      name: 'bugReportOfFoodlist',
      desc: '',
      args: [],
    );
  }

  /// `Bug: \n\nDevice: \n\nOS: \n\nApp version: \n\nSteps to reproduce: \n\n*If you have a screenshot, please attach it.\n\n*If you don't know details of your device, you can skip writing it.`
  String get mesOfBugReport {
    return Intl.message(
      'Bug: \n\nDevice: \n\nOS: \n\nApp version: \n\nSteps to reproduce: \n\n*If you have a screenshot, please attach it.\n\n*If you don\'t know details of your device, you can skip writing it.',
      name: 'mesOfBugReport',
      desc: '',
      args: [],
    );
  }

  /// `Translation Error of FoodList`
  String get translationErrorOfFoodlist {
    return Intl.message(
      'Translation Error of FoodList',
      name: 'translationErrorOfFoodlist',
      desc: '',
      args: [],
    );
  }

  /// `Language: \n\nError translation: \n\nCorrect translation: \n\n`
  String get mesOfTransError {
    return Intl.message(
      'Language: \n\nError translation: \n\nCorrect translation: \n\n',
      name: 'mesOfTransError',
      desc: '',
      args: [],
    );
  }

  /// `Contribute Translation of FoodList`
  String get contributeTranslationOfFoodlist {
    return Intl.message(
      'Contribute Translation of FoodList',
      name: 'contributeTranslationOfFoodlist',
      desc: '',
      args: [],
    );
  }

  /// `Language I want to contribute: \n\n*If you want to contribute a whole new language, we will send you a file to translate.`
  String get mesOfContributeTrans {
    return Intl.message(
      'Language I want to contribute: \n\n*If you want to contribute a whole new language, we will send you a file to translate.',
      name: 'mesOfContributeTrans',
      desc: '',
      args: [],
    );
  }

  /// `Version: {version}`
  String versionVersion(String version) {
    return Intl.message(
      'Version: $version',
      name: 'versionVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Special thanks to all contributors below!`
  String get specialThanksToAllContributorsBelow {
    return Intl.message(
      'Special thanks to all contributors below!',
      name: 'specialThanksToAllContributorsBelow',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message('License', name: 'license', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Enabled`
  String get enabled {
    return Intl.message('Enabled', name: 'enabled', desc: '', args: []);
  }

  /// `Disabled`
  String get disabled {
    return Intl.message('Disabled', name: 'disabled', desc: '', args: []);
  }

  /// `Ingredient Management`
  String get ingredientManagement {
    return Intl.message(
      'Ingredient Management',
      name: 'ingredientManagement',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Time`
  String get reminderTime {
    return Intl.message(
      'Reminder Time',
      name: 'reminderTime',
      desc: '',
      args: [],
    );
  }

  /// `Click to change reminder time`
  String get clickToChangeReminderTime {
    return Intl.message(
      'Click to change reminder time',
      name: 'clickToChangeReminderTime',
      desc: '',
      args: [],
    );
  }

  /// `Long press the right handle to reorder`
  String get dragToReorderHint {
    return Intl.message(
      'Long press the right handle to reorder',
      name: 'dragToReorderHint',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `"{itemName}" Deleted`
  String itemDeleted(String itemName) {
    return Intl.message(
      '"$itemName" Deleted',
      name: 'itemDeleted',
      desc: '',
      args: [itemName],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
  }

  /// `Scan barcode`
  String get scanBarcode {
    return Intl.message(
      'Scan barcode',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Point the camera at the barcode`
  String get scanBarcodeHint {
    return Intl.message(
      'Point the camera at the barcode',
      name: 'scanBarcodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Product not found. Type its name — we'll remember this barcode next time.`
  String get barcodeNotFound {
    return Intl.message(
      'Product not found. Type its name — we\'ll remember this barcode next time.',
      name: 'barcodeNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Looking up…`
  String get lookingUp {
    return Intl.message('Looking up…', name: 'lookingUp', desc: '', args: []);
  }

  /// `Quick pick`
  String get quickPick {
    return Intl.message('Quick pick', name: 'quickPick', desc: '', args: []);
  }

  /// `{days} days`
  String daysChip(int days) {
    return Intl.message('$days days', name: 'daysChip', desc: '', args: [days]);
  }

  /// `Pick date`
  String get customDate {
    return Intl.message('Pick date', name: 'customDate', desc: '', args: []);
  }

  /// `Save & add another`
  String get saveAndNext {
    return Intl.message(
      'Save & add another',
      name: 'saveAndNext',
      desc: '',
      args: [],
    );
  }

  /// `Added {name}`
  String itemAdded(String name) {
    return Intl.message(
      'Added $name',
      name: 'itemAdded',
      desc: '',
      args: [name],
    );
  }

  /// `Rate FoodList`
  String get rateApp {
    return Intl.message('Rate FoodList', name: 'rateApp', desc: '', args: []);
  }

  /// `No suggestions — just save what you typed`
  String get noMatches {
    return Intl.message(
      'No suggestions — just save what you typed',
      name: 'noMatches',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `System default`
  String get themeSystem {
    return Intl.message(
      'System default',
      name: 'themeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `"Expiring soon" range`
  String get soonThreshold {
    return Intl.message(
      '"Expiring soon" range',
      name: 'soonThreshold',
      desc: '',
      args: [],
    );
  }

  /// `Within {days} days`
  String soonThresholdValue(int days) {
    return Intl.message(
      'Within $days days',
      name: 'soonThresholdValue',
      desc: '',
      args: [days],
    );
  }

  /// `Items expiring within this range are shown in orange.`
  String get soonThresholdHint {
    return Intl.message(
      'Items expiring within this range are shown in orange.',
      name: 'soonThresholdHint',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to FoodList`
  String get onboardingTitle {
    return Intl.message(
      'Welcome to FoodList',
      name: 'onboardingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap Add and pick a common item — name and date are filled in for you.`
  String get onboardingAdd {
    return Intl.message(
      'Tap Add and pick a common item — name and date are filled in for you.',
      name: 'onboardingAdd',
      desc: '',
      args: [],
    );
  }

  /// `Tap an item to edit it.`
  String get onboardingTap {
    return Intl.message(
      'Tap an item to edit it.',
      name: 'onboardingTap',
      desc: '',
      args: [],
    );
  }

  /// `Swipe an item left to mark it used or delete it.`
  String get onboardingSwipe {
    return Intl.message(
      'Swipe an item left to mark it used or delete it.',
      name: 'onboardingSwipe',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get gotIt {
    return Intl.message('Get started', name: 'gotIt', desc: '', args: []);
  }

  /// `This is a store-label barcode (weighed/fresh items). Type the name once and it will be filled in next time.`
  String get inStoreBarcode {
    return Intl.message(
      'This is a store-label barcode (weighed/fresh items). Type the name once and it will be filled in next time.',
      name: 'inStoreBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Expiry date read from the barcode`
  String get expiryFromBarcode {
    return Intl.message(
      'Expiry date read from the barcode',
      name: 'expiryFromBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Flashlight`
  String get torch {
    return Intl.message('Flashlight', name: 'torch', desc: '', args: []);
  }

  /// `Product data`
  String get dataSources {
    return Intl.message(
      'Product data',
      name: 'dataSources',
      desc: '',
      args: [],
    );
  }

  /// `Product names come from Open Food Facts (ODbL) and, in Japan, Yahoo!ショッピング.`
  String get dataSourcesContent {
    return Intl.message(
      'Product names come from Open Food Facts (ODbL) and, in Japan, Yahoo!ショッピング.',
      name: 'dataSourcesContent',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Used`
  String get useOne {
    return Intl.message('Used', name: 'useOne', desc: '', args: []);
  }

  /// `{name} used up`
  String usedUp(String name) {
    return Intl.message(
      '$name used up',
      name: 'usedUp',
      desc: '',
      args: [name],
    );
  }

  /// `Nothing matches`
  String get nothingMatches {
    return Intl.message(
      'Nothing matches',
      name: 'nothingMatches',
      desc: '',
      args: [],
    );
  }

  /// `Clear filters`
  String get clearFilters {
    return Intl.message(
      'Clear filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `How do I edit, use up or delete an item?`
  String get faqHowToEditItem {
    return Intl.message(
      'How do I edit, use up or delete an item?',
      name: 'faqHowToEditItem',
      desc: '',
      args: [],
    );
  }

  /// `Tap an item to edit it. Swipe it to the left for "Used one" (lowers the quantity, or removes it when only one is left) and "Delete". Both can be undone right after.`
  String get faqHowToEditItemAns {
    return Intl.message(
      'Tap an item to edit it. Swipe it to the left for "Used one" (lowers the quantity, or removes it when only one is left) and "Delete". Both can be undone right after.',
      name: 'faqHowToEditItemAns',
      desc: '',
      args: [],
    );
  }

  /// `What does barcode scanning send?`
  String get faqWhatDoesScanSend {
    return Intl.message(
      'What does barcode scanning send?',
      name: 'faqWhatDoesScanSend',
      desc: '',
      args: [],
    );
  }

  /// `Only the barcode number, to Open Food Facts (and Yahoo! Shopping for Japanese products), to look up the product name. Camera images never leave your phone. Names you type are remembered on your phone.`
  String get faqWhatDoesScanSendAns {
    return Intl.message(
      'Only the barcode number, to Open Food Facts (and Yahoo! Shopping for Japanese products), to look up the product name. Camera images never leave your phone. Names you type are remembered on your phone.',
      name: 'faqWhatDoesScanSendAns',
      desc: '',
      args: [],
    );
  }

  /// `{name}: ×{count} left`
  String leftCount(String name, int count) {
    return Intl.message(
      '$name: ×$count left',
      name: 'leftCount',
      desc: '',
      args: [name, count],
    );
  }

  /// `Nothing expires today or tomorrow — nice work! 🎉`
  String get nothingExpiringSoon {
    return Intl.message(
      'Nothing expires today or tomorrow — nice work! 🎉',
      name: 'nothingExpiringSoon',
      desc: '',
      args: [],
    );
  }

  /// `Read from photo`
  String get readDate {
    return Intl.message(
      'Read from photo',
      name: 'readDate',
      desc: '',
      args: [],
    );
  }

  /// `Date read from the photo`
  String get dateFromPhoto {
    return Intl.message(
      'Date read from the photo',
      name: 'dateFromPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't find a date — please pick it`
  String get noDateFound {
    return Intl.message(
      'Couldn\'t find a date — please pick it',
      name: 'noDateFound',
      desc: '',
      args: [],
    );
  }

  /// `Text recognition is still downloading. Try again in a minute.`
  String get ocrUnavailable {
    return Intl.message(
      'Text recognition is still downloading. Try again in a minute.',
      name: 'ocrUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Which one is the expiry date?`
  String get whichDate {
    return Intl.message(
      'Which one is the expiry date?',
      name: 'whichDate',
      desc: '',
      args: [],
    );
  }

  /// `Camera unavailable. Allow camera access in Settings, or just type the name.`
  String get cameraUnavailable {
    return Intl.message(
      'Camera unavailable. Allow camera access in Settings, or just type the name.',
      name: 'cameraUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get openSettings {
    return Intl.message(
      'Open settings',
      name: 'openSettings',
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
