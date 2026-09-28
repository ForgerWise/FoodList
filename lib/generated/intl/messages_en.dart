// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(days) => "${days} days";

  static String m1(days) => "${days} days left";

  static String m2(expireDate) => "Expire Date: ${expireDate}";

  static String m3(days) =>
      "${Intl.plural(days, one: 'Expired yesterday', other: 'Expired ${days} days ago')}";

  static String m4(todayItems, tomorrowItems) =>
      "Today: ${todayItems} / Tomorrow: ${tomorrowItems}";

  static String m5(name) => "Added ${name}";

  static String m6(itemName) => "\"${itemName}\" Deleted";

  static String m7(name, count) => "${name}: ×${count} left";

  static String m8(number) => "and ${number} more items";

  static String m9(selectedHour, selectedMinute) =>
      "Selected Time: ${selectedHour}:${selectedMinute}";

  static String m10(days) => "Within ${days} days";

  static String m11(name) => "${name} used up";

  static String m12(version) => "Version: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutContent": MessageLookupByLibrary.simpleMessage(
      "This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables\' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste.",
    ),
    "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
      "This app is totally open source and free to use. If you have any suggestions or want to contribute to this project, feel free to visit the GitHub repository.",
    ),
    "aboutContentHomepage": MessageLookupByLibrary.simpleMessage(
      "If you have interest in other our projects, please visit our homepage.",
    ),
    "aboutFoodlist": MessageLookupByLibrary.simpleMessage("About FoodList"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
    "addIngredients": MessageLookupByLibrary.simpleMessage("Add Ingredient"),
    "addSubcategory": MessageLookupByLibrary.simpleMessage("Add Subcategory"),
    "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "apple": MessageLookupByLibrary.simpleMessage("Apple"),
    "barcodeNotFound": MessageLookupByLibrary.simpleMessage(
      "Product not found. Type its name — we\'ll remember this barcode next time.",
    ),
    "bean": MessageLookupByLibrary.simpleMessage("Bean"),
    "beef": MessageLookupByLibrary.simpleMessage("Beef"),
    "bugReport": MessageLookupByLibrary.simpleMessage("Bug report"),
    "bugReportOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "Bug Report of FoodList",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Camera unavailable. Allow camera access in Settings, or just type the name.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "carrot": MessageLookupByLibrary.simpleMessage("Carrot"),
    "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
      "This ingredient\'s Category or Subcategory is deleted, cannot edit. If you want to edit the content of this ingredient, please delete the ingredient and add again.",
    ),
    "categoriesResetHint": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to reset the categories to default?",
    ),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryName": MessageLookupByLibrary.simpleMessage("Category Name"),
    "chicken": MessageLookupByLibrary.simpleMessage("Chicken"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("Clear filters"),
    "clickToChangeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Click to change reminder time",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmCategoryDelete": MessageLookupByLibrary.simpleMessage(
      "Delete this category? Items in it will move to \"Others\".",
    ),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
    "confirmReset": MessageLookupByLibrary.simpleMessage("Confirm Reset"),
    "confirmsubcategorydelete": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this subcategory?",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "contributeCode": MessageLookupByLibrary.simpleMessage("Contribute code"),
    "contributeTranslation": MessageLookupByLibrary.simpleMessage(
      "Contribute translation",
    ),
    "contributeTranslationOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "Contribute Translation of FoodList",
    ),
    "customDate": MessageLookupByLibrary.simpleMessage("Pick date"),
    "dataSources": MessageLookupByLibrary.simpleMessage("Product data"),
    "dataSourcesContent": MessageLookupByLibrary.simpleMessage(
      "Product names come from Open Food Facts (ODbL) and, in Japan, Yahoo!ショッピング.",
    ),
    "dateFromPhoto": MessageLookupByLibrary.simpleMessage(
      "Date read from the photo",
    ),
    "daysChip": m0,
    "daysLeft": m1,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
    "dragToReorderHint": MessageLookupByLibrary.simpleMessage(
      "Long press the right handle to reorder",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editCategoriesNotSupportedHint": MessageLookupByLibrary.simpleMessage(
      "Edit categories is not supported yet!",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit Category"),
    "editIngredients": MessageLookupByLibrary.simpleMessage("Edit Ingredient"),
    "editResetCategories": MessageLookupByLibrary.simpleMessage(
      "Edit/Reset Categories",
    ),
    "editSubategory": MessageLookupByLibrary.simpleMessage("Edit Subategory"),
    "editSubcategory": MessageLookupByLibrary.simpleMessage("Edit Subcategory"),
    "egg": MessageLookupByLibrary.simpleMessage("Egg"),
    "eggMilk": MessageLookupByLibrary.simpleMessage("Egg & Milk"),
    "emailCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "Email copied to clipboard",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Enabled"),
    "enterNewCategoryName": MessageLookupByLibrary.simpleMessage(
      "Enter new category name",
    ),
    "enterNewSubcategoryName": MessageLookupByLibrary.simpleMessage(
      "Enter new subcategory name",
    ),
    "entryDate": MessageLookupByLibrary.simpleMessage("Entry Date"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "example": MessageLookupByLibrary.simpleMessage("Example"),
    "expireDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
    "expireDateConfirmMessage": m2,
    "expiredDaysAgo": m3,
    "expiresToday": MessageLookupByLibrary.simpleMessage("Expires today!"),
    "expiresTomorrow": MessageLookupByLibrary.simpleMessage(
      "Expires tomorrow!",
    ),
    "expiryFromBarcode": MessageLookupByLibrary.simpleMessage(
      "Expiry date read from the barcode",
    ),
    "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
    "faqHowToEditItem": MessageLookupByLibrary.simpleMessage(
      "How do I edit, use up or delete an item?",
    ),
    "faqHowToEditItemAns": MessageLookupByLibrary.simpleMessage(
      "Tap an item to edit it. Swipe it to the left for \"Used one\" (lowers the quantity, or removes it when only one is left) and \"Delete\". Both can be undone right after.",
    ),
    "faqHowToEditSubcategories": MessageLookupByLibrary.simpleMessage(
      "How to edit subcategories?",
    ),
    "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
      "To edit subcategories, tap on the category you want to edit. Then you will be redirected to the subcategory edit page.",
    ),
    "faqWhatDoesScanSend": MessageLookupByLibrary.simpleMessage(
      "What does barcode scanning send?",
    ),
    "faqWhatDoesScanSendAns": MessageLookupByLibrary.simpleMessage(
      "Only the barcode number, to Open Food Facts (and Yahoo! Shopping for Japanese products), to look up the product name. Camera images never leave your phone. Names you type are remembered on your phone.",
    ),
    "faqWhatWillResetCategoriesDo": MessageLookupByLibrary.simpleMessage(
      "What will happen if I reset the categories?",
    ),
    "faqWhatWillResetCategoriesDoAns": MessageLookupByLibrary.simpleMessage(
      "Resetting restores the default categories and icons. Your saved ingredients are not deleted.",
    ),
    "faqWhyEditNotLoad": MessageLookupByLibrary.simpleMessage(
      "Why didn\'\'t the data load to the edit page automatically?",
    ),
    "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
      "Due to the data structure, if your data was saved in a different language previously, it will not be loaded automatically. However, you can still edit it starting from a blank state.",
    ),
    "faqWhyNotificationDelay": MessageLookupByLibrary.simpleMessage(
      "Why is the notification delayed?",
    ),
    "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
      "FoodList uses a system alarm that may be delayed by a few minutes by Android to save battery. This is normal and expected. If the delay is more than 30 minutes, try disabling battery optimization for the app.",
    ),
    "faqWhyNotificationNotWork": MessageLookupByLibrary.simpleMessage(
      "Why isn\'\'t the notification working?",
    ),
    "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
      "1. Go to your device Settings > Apps > FoodList > Notifications and make sure notifications are enabled.\n2. Disable battery optimization for FoodList (Settings > Battery > Battery Optimization > FoodList > Don\'\'t optimize).\n3. Toggle the notification switch off and on again in the app to re-register the alarm.",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "filterAll": MessageLookupByLibrary.simpleMessage("All"),
    "filterExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "filterExpiringSoon": MessageLookupByLibrary.simpleMessage("Expiring Soon"),
    "fish": MessageLookupByLibrary.simpleMessage("Fish"),
    "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
    "foodlistExpiryNotification": MessageLookupByLibrary.simpleMessage(
      "🍱 Food Expiry Reminder",
    ),
    "foodlistExpiryNotificationContent": m4,
    "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
    "forgerwisesGithub": MessageLookupByLibrary.simpleMessage(
      "ForgerWise\'s GitHub",
    ),
    "fruit": MessageLookupByLibrary.simpleMessage("Fruit"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "GitHub Repository",
    ),
    "gotIt": MessageLookupByLibrary.simpleMessage("Get started"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homepage": MessageLookupByLibrary.simpleMessage("Homepage"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "inStoreBarcode": MessageLookupByLibrary.simpleMessage(
      "This is a store-label barcode (weighed/fresh items). Type the name once and it will be filled in next time.",
    ),
    "ingredientManagement": MessageLookupByLibrary.simpleMessage(
      "Ingredient Management",
    ),
    "ingredientName": MessageLookupByLibrary.simpleMessage("Name"),
    "ingredientNameHint": MessageLookupByLibrary.simpleMessage(
      "Name, or pick below",
    ),
    "itemAdded": m5,
    "itemDeleted": m6,
    "languageNotSupportedYetMessage": MessageLookupByLibrary.simpleMessage(
      "This language is not supported yet! We\'\'re working on it!",
    ),
    "languages": MessageLookupByLibrary.simpleMessage("Languages"),
    "leftCount": m7,
    "license": MessageLookupByLibrary.simpleMessage("License"),
    "lookingUp": MessageLookupByLibrary.simpleMessage("Looking up…"),
    "meat": MessageLookupByLibrary.simpleMessage("Meat"),
    "mesOfBugReport": MessageLookupByLibrary.simpleMessage(
      "Bug: \n\nDevice: \n\nOS: \n\nApp version: \n\nSteps to reproduce: \n\n*If you have a screenshot, please attach it.\n\n*If you don\'t know details of your device, you can skip writing it.",
    ),
    "mesOfContributeTrans": MessageLookupByLibrary.simpleMessage(
      "Language I want to contribute: \n\n*If you want to contribute a whole new language, we will send you a file to translate.",
    ),
    "mesOfTransError": MessageLookupByLibrary.simpleMessage(
      "Language: \n\nError translation: \n\nCorrect translation: \n\n",
    ),
    "milk": MessageLookupByLibrary.simpleMessage("Milk"),
    "mushroom": MessageLookupByLibrary.simpleMessage("Mushroom"),
    "noDateFound": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t find a date — please pick it",
    ),
    "noIngredients": MessageLookupByLibrary.simpleMessage("No ingredients yet"),
    "noIngredientsHint": MessageLookupByLibrary.simpleMessage(
      "Tap + to add your first ingredient!",
    ),
    "noMatches": MessageLookupByLibrary.simpleMessage(
      "No suggestions — just save what you typed",
    ),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "nothingExpiringSoon": MessageLookupByLibrary.simpleMessage(
      "Nothing expires today or tomorrow — nice work! 🎉",
    ),
    "nothingMatches": MessageLookupByLibrary.simpleMessage("Nothing matches"),
    "notificationContent": MessageLookupByLibrary.simpleMessage(
      "Get one reminder a day about items expiring today and tomorrow.",
    ),
    "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
      "Notifications may arrive a few minutes after the set time on some devices. This is expected behavior due to Android battery optimization.",
    ),
    "notificationMoreItems": m8,
    "notificationSetting": MessageLookupByLibrary.simpleMessage(
      "Notification Setting",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "ocrUnavailable": MessageLookupByLibrary.simpleMessage(
      "Text recognition is still downloading. Try again in a minute.",
    ),
    "officialWebsite": MessageLookupByLibrary.simpleMessage("Official website"),
    "onboardingAdd": MessageLookupByLibrary.simpleMessage(
      "Tap Add and pick a common item — name and date are filled in for you.",
    ),
    "onboardingSwipe": MessageLookupByLibrary.simpleMessage(
      "Swipe an item left to mark it used or delete it.",
    ),
    "onboardingTap": MessageLookupByLibrary.simpleMessage(
      "Tap an item to edit it.",
    ),
    "onboardingTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to FoodList",
    ),
    "openSettings": MessageLookupByLibrary.simpleMessage("Open settings"),
    "other": MessageLookupByLibrary.simpleMessage("other"),
    "otherBeans": MessageLookupByLibrary.simpleMessage("Other Beans"),
    "otherEggMilk": MessageLookupByLibrary.simpleMessage("Other Egg & Milk"),
    "otherFishes": MessageLookupByLibrary.simpleMessage("Other Fishes"),
    "otherFruits": MessageLookupByLibrary.simpleMessage("Other Fruits"),
    "otherItems": MessageLookupByLibrary.simpleMessage("Other Items"),
    "otherMeats": MessageLookupByLibrary.simpleMessage("Other Meats"),
    "otherMushrooms": MessageLookupByLibrary.simpleMessage("Other Mushrooms"),
    "otherProcessedFoods": MessageLookupByLibrary.simpleMessage(
      "Other Processed Foods",
    ),
    "otherVegetables": MessageLookupByLibrary.simpleMessage("Other Vegetables"),
    "others": MessageLookupByLibrary.simpleMessage("Others"),
    "oyster": MessageLookupByLibrary.simpleMessage("Oyster"),
    "policy": MessageLookupByLibrary.simpleMessage("Policy"),
    "pork": MessageLookupByLibrary.simpleMessage("Pork"),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "privacyContent": MessageLookupByLibrary.simpleMessage(
      "Last updated: 2026-09-28 (version 3.1.0)\n\nYour food list never leaves your phone, and we do not collect personal data.\n\n1. Data on your device\nEverything you enter — items, dates, quantities, categories and settings — is stored only on your device. There is no server and no account. Uninstalling the app deletes it.\n\n2. Barcode scanning (optional)\nThe camera is used only while the scan screen is open; images are processed on the device and never saved or uploaded.\nTo fill in a product name, only the barcode number is sent to Open Food Facts and, for Japanese products, the Yahoo! JAPAN Shopping Web API. No name, account or location is sent. Like any web request, these services can see your IP address.\nNames you type for barcodes are remembered on your device.\n\n3. Notifications\nReminders are scheduled and shown locally. Nothing is sent to a server.\n\n4. Ratings\nThe app may show Google Play\'s built-in rating dialog, which is provided by Google. FoodList receives no data from it.\n\n5. Changes\nIf a future version sends more data (for example, sync), this policy will be updated first.\n\nContact: forgerwise@gmail.com",
    ),
    "processedfood": MessageLookupByLibrary.simpleMessage("Processed Food"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "quickPick": MessageLookupByLibrary.simpleMessage("Quick pick"),
    "rateApp": MessageLookupByLibrary.simpleMessage("Rate FoodList"),
    "rateThisApp": MessageLookupByLibrary.simpleMessage("Rate this app"),
    "readDate": MessageLookupByLibrary.simpleMessage("Read from photo"),
    "reminderTime": MessageLookupByLibrary.simpleMessage("Reminder Time"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "salmon": MessageLookupByLibrary.simpleMessage("Salmon"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveAndNext": MessageLookupByLibrary.simpleMessage("Save & add another"),
    "scanBarcode": MessageLookupByLibrary.simpleMessage("Scan barcode"),
    "scanBarcodeHint": MessageLookupByLibrary.simpleMessage(
      "Point the camera at the barcode",
    ),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search ingredients..."),
    "selectDate": MessageLookupByLibrary.simpleMessage("Select Date"),
    "selectedTime": m9,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "slideToDelete": MessageLookupByLibrary.simpleMessage("Slide to Delete"),
    "soonThreshold": MessageLookupByLibrary.simpleMessage(
      "\"Expiring soon\" range",
    ),
    "soonThresholdHint": MessageLookupByLibrary.simpleMessage(
      "Items expiring within this range are shown in orange.",
    ),
    "soonThresholdValue": m10,
    "soybean": MessageLookupByLibrary.simpleMessage("Soybean"),
    "specialThanksToAllContributorsBelow": MessageLookupByLibrary.simpleMessage(
      "Special thanks to all contributors below!",
    ),
    "summaryExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "summaryExpiringSoon": MessageLookupByLibrary.simpleMessage(
      "Expiring Soon",
    ),
    "summaryFresh": MessageLookupByLibrary.simpleMessage("Fresh"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System default"),
    "torch": MessageLookupByLibrary.simpleMessage("Flashlight"),
    "translationError": MessageLookupByLibrary.simpleMessage(
      "Translation error",
    ),
    "translationErrorOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "Translation Error of FoodList",
    ),
    "tuna": MessageLookupByLibrary.simpleMessage("Tuna"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "urlCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "URL copied to clipboard",
    ),
    "useOne": MessageLookupByLibrary.simpleMessage("Used"),
    "usedUp": m11,
    "vegetable": MessageLookupByLibrary.simpleMessage("Vegetable"),
    "versionVersion": m12,
    "whichDate": MessageLookupByLibrary.simpleMessage(
      "Which one is the expiry date?",
    ),
  };
}
