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

  static String m0(expireDate) => "Expire Date: ${expireDate}";

  static String m1(todayItems, tomorrowItems) =>
      "Expiring today: ${todayItems}\nExpiring tomorrow: ${tomorrowItems}";

  static String m2(number) => "and ${number} more items";

  static String m3(selectedHour, selectedMinute) =>
      "Selected Time: ${selectedHour}:${selectedMinute}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "aboutContent": MessageLookupByLibrary.simpleMessage(
            "This app was created from our commitment to fight food waste. Given that nearly half of all wasted food happens at home, we provide a straightforward tool for users to manage their perishables\'\' expiration dates. Our goal is to reduce unnecessary buying and cut down household food waste."),
        "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
            "This app is totally open source and free to use. If you have any suggestions or want to contribute to this project, feel free to visit the GitHub repository."),
        "aboutContentHomepage": MessageLookupByLibrary.simpleMessage(
            "If you have interest in other our projects, please visit our homepage."),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
        "addIngredients":
            MessageLookupByLibrary.simpleMessage("Add Ingredients"),
        "addSubcategory":
            MessageLookupByLibrary.simpleMessage("Add Subcategory"),
        "addToSubcategory":
            MessageLookupByLibrary.simpleMessage("Add to Subcategory"),
        "apple": MessageLookupByLibrary.simpleMessage("Apple"),
        "bean": MessageLookupByLibrary.simpleMessage("Bean"),
        "beef": MessageLookupByLibrary.simpleMessage("Beef"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "carrot": MessageLookupByLibrary.simpleMessage("Carrot"),
        "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
            "This ingredient\'s Category or Subcategory is deleted, cannot edit. If you want to edit the content of this ingredient, please delete the ingredient and add again."),
        "categoriesResetHint": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to reset the categories to default?"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "chicken": MessageLookupByLibrary.simpleMessage("Chicken"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmCategoryDelete": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this category?"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
        "confirmReset": MessageLookupByLibrary.simpleMessage("Confirm Reset"),
        "confirmsubcategorydelete": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this subcategory?"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editCategoriesNotSupportedHint": MessageLookupByLibrary.simpleMessage(
            "Edit categories is not supported yet!"),
        "editCategory": MessageLookupByLibrary.simpleMessage("Edit Category"),
        "editIngredients":
            MessageLookupByLibrary.simpleMessage("Edit Ingredients"),
        "editResetCategories":
            MessageLookupByLibrary.simpleMessage("Edit/Reset Categories"),
        "editSubategory":
            MessageLookupByLibrary.simpleMessage("Edit Subategory"),
        "editSubcategory":
            MessageLookupByLibrary.simpleMessage("Edit Subcategory"),
        "egg": MessageLookupByLibrary.simpleMessage("Egg"),
        "eggMilk": MessageLookupByLibrary.simpleMessage("Egg & Milk"),
        "emailCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Email copied to clipboard"),
        "enterNewCategoryName":
            MessageLookupByLibrary.simpleMessage("Enter new category name"),
        "enterNewSubcategoryName":
            MessageLookupByLibrary.simpleMessage("Enter new subcategory name"),
        "entryDate": MessageLookupByLibrary.simpleMessage("Entry Date"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "example": MessageLookupByLibrary.simpleMessage("Example"),
        "expireDate": MessageLookupByLibrary.simpleMessage("Expire Date"),
        "expireDateConfirmMessage": m0,
        "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
        "faqHowToEditSubcategories":
            MessageLookupByLibrary.simpleMessage("How to edit subcategories?"),
        "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
            "To edit subcategories, tap on the category you want to edit. Then you will be redirected to the subcategory edit page."),
        "faqWhatWillResetCategoriesDo": MessageLookupByLibrary.simpleMessage(
            "What will happen if I reset the categories?"),
        "faqWhatWillResetCategoriesDoAns": MessageLookupByLibrary.simpleMessage(
            "Resetting the categories will reset all the categories and subcategories to their default values."),
        "faqWhyEditNotLoad": MessageLookupByLibrary.simpleMessage(
            "Why didn\'\'t the data load to the edit page automatically?"),
        "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
            "Due to the data structure, if your data was saved in a different language previously, it will not be loaded automatically. However, you can still edit it starting from a blank state."),
        "faqWhyNotificationDelay": MessageLookupByLibrary.simpleMessage(
            "Why is the notification being delayed?"),
        "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
            "Notifications may be delayed on some devices due to battery optimization settings or android restrictions."),
        "faqWhyNotificationNotWork": MessageLookupByLibrary.simpleMessage(
            "Why isn\'\'t the notification working?"),
        "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
            "Please ensure that you have enabled notifications for the app in your device settings. If it still doesn\'\'t work, check the battery optimization settings and disable battery optimization for the app."),
        "fish": MessageLookupByLibrary.simpleMessage("Fish"),
        "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
        "foodlistExpiryNotification": MessageLookupByLibrary.simpleMessage(
            "FoodList Expiry Notification"),
        "foodlistExpiryNotificationContent": m1,
        "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
        "fruit": MessageLookupByLibrary.simpleMessage("Fruit"),
        "githubRepository":
            MessageLookupByLibrary.simpleMessage("GitHub Repository"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "homepage": MessageLookupByLibrary.simpleMessage("Homepage"),
        "languageNotSupportedYetMessage": MessageLookupByLibrary.simpleMessage(
            "This language is not supported yet! We\'\'re working on it!"),
        "languages": MessageLookupByLibrary.simpleMessage("Languages"),
        "meat": MessageLookupByLibrary.simpleMessage("Meat"),
        "milk": MessageLookupByLibrary.simpleMessage("Milk"),
        "mushroom": MessageLookupByLibrary.simpleMessage("Mushroom"),
        "none": MessageLookupByLibrary.simpleMessage("None"),
        "notificationContent": MessageLookupByLibrary.simpleMessage(
            "Set the time at which you would like to receive notifications. This helps you to know which items are expiring soon. "),
        "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
            "Notifications may be delayed on some devices due to battery optimization settings or android restrictions."),
        "notificationMoreItems": m2,
        "notificationSetting":
            MessageLookupByLibrary.simpleMessage("Notification Setting"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "other": MessageLookupByLibrary.simpleMessage("other"),
        "otherBeans": MessageLookupByLibrary.simpleMessage("Other Beans"),
        "otherEggMilk":
            MessageLookupByLibrary.simpleMessage("Other Egg & Milk"),
        "otherFishes": MessageLookupByLibrary.simpleMessage("Other Fishes"),
        "otherFruits": MessageLookupByLibrary.simpleMessage("Other Fruits"),
        "otherItems": MessageLookupByLibrary.simpleMessage("Other Items"),
        "otherMeats": MessageLookupByLibrary.simpleMessage("Other Meats"),
        "otherMushrooms":
            MessageLookupByLibrary.simpleMessage("Other Mushrooms"),
        "otherProcessedFoods":
            MessageLookupByLibrary.simpleMessage("Other Processed Foods"),
        "otherVegetables":
            MessageLookupByLibrary.simpleMessage("Other Vegetables"),
        "others": MessageLookupByLibrary.simpleMessage("Others"),
        "oyster": MessageLookupByLibrary.simpleMessage("Oyster"),
        "policy": MessageLookupByLibrary.simpleMessage("Policy"),
        "pork": MessageLookupByLibrary.simpleMessage("Pork"),
        "privacyContent": MessageLookupByLibrary.simpleMessage(
            "This Privacy Policy describes how our mobile application, (hereinafter referred to as \'\'the App\'\'), collects, uses, and discloses your information. The App is committed to maintaining robust privacy protections for its users. Our Privacy Policy is designed to help you understand how we collect and use the personal information you decide to share and help you make informed decisions when using the App.\n\nBy using or accessing the App, you accept the practices described in this Privacy Policy. If you do not agree to this policy, please do not use the App. We reserve the right to modify this policy from time to time, so please review it frequently. Your continued use of the App signifies your acceptance of our Privacy Policy as modified.\n\n1. Data We Collect\nCurrently, the App does not collect any personal data. The App is designed to store all data related to your food within the device itself and does not have any feature to collect your personal data.\n\n2. Data Storage and Protection\nYour data is stored on your device and is not accessible by anyone but you, unless the data on your device is shared by you or your device provider.\n\n3. Future Updates\nIn future updates, if there is a feature that allows user data upload for functionalities such as synchronization, we still will not disclose this information to any third party. We will announce the update of our privacy policy when these features are added.\n\n4. Changes to Our Privacy Policy\nThe App reserves the right to change this policy and our Terms of Service at any time. We will notify users of significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a prominent notice on our site. Significant changes will go into effect 30 days following such notification. Non-material changes or clarifications will take effect immediately. You should periodically check the Site and this privacy page for updates."),
        "processedfood": MessageLookupByLibrary.simpleMessage("Processed Food"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "salmon": MessageLookupByLibrary.simpleMessage("Salmon"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "selectCategoryHint":
            MessageLookupByLibrary.simpleMessage("Select Category"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Select Date"),
        "selectSubcategoryHint":
            MessageLookupByLibrary.simpleMessage("Select Subcategory"),
        "selectedTime": m3,
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "slideToDelete":
            MessageLookupByLibrary.simpleMessage("Slide to Delete"),
        "soybean": MessageLookupByLibrary.simpleMessage("Soybean"),
        "subcategory": MessageLookupByLibrary.simpleMessage("Subcategory"),
        "subcategoryName": MessageLookupByLibrary.simpleMessage("Name"),
        "subcategoryNameInputHint": MessageLookupByLibrary.simpleMessage(
            "Please input the name of the ingredient"),
        "tuna": MessageLookupByLibrary.simpleMessage("Tuna"),
        "vegetable": MessageLookupByLibrary.simpleMessage("Vegetable")
      };
}
