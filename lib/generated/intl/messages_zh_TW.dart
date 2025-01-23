// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(expireDate) => "有效日期: ${expireDate}";

  static String m1(todayItems, tomorrowItems) =>
      "今日過期: ${todayItems}\n明日過期: ${tomorrowItems}";

  static String m2(number) => "以及 ${number} 項其他食材";

  static String m3(selectedHour, selectedMinute) =>
      "選擇的時間: ${selectedHour}:${selectedMinute}";

  static String m4(version) => "版本: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "aboutContent": MessageLookupByLibrary.simpleMessage(
            "這個應用程式源自我們對抗食物浪費的承諾。由於家庭食物浪費佔了近一半，我們提供了一個簡單易用的工具，幫助使用者管理食物的保存期限。希望透過這個工具，減少不必要的購買，並減少家庭中的食物浪費。"),
        "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
            "這個應用程式是完全開源且免費使用的。如果您有任何建議或想要貢獻此專案，請隨時訪問 GitHub 儲存庫。"),
        "aboutContentHomepage":
            MessageLookupByLibrary.simpleMessage("如果您對我們的其他專案有興趣，歡迎造訪我們的官方網站。"),
        "aboutFoodlist": MessageLookupByLibrary.simpleMessage("關於 FoodList"),
        "add": MessageLookupByLibrary.simpleMessage("新增"),
        "addCategory": MessageLookupByLibrary.simpleMessage("新增類別"),
        "addIngredients": MessageLookupByLibrary.simpleMessage("新增食材"),
        "addSubcategory": MessageLookupByLibrary.simpleMessage("新增子類別"),
        "addToSubcategory": MessageLookupByLibrary.simpleMessage("新增至子類別"),
        "apple": MessageLookupByLibrary.simpleMessage("蘋果"),
        "bean": MessageLookupByLibrary.simpleMessage("豆類"),
        "beef": MessageLookupByLibrary.simpleMessage("牛肉"),
        "bugReport": MessageLookupByLibrary.simpleMessage("錯誤報告"),
        "bugReportOfFoodlist":
            MessageLookupByLibrary.simpleMessage("FoodList 的錯誤報告"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "carrot": MessageLookupByLibrary.simpleMessage("紅蘿蔔"),
        "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
            "此食材的類別或子類別已被刪除，無法編輯。如果要編輯此食材的內容，請刪除該食材並重新添加。"),
        "categoriesResetHint":
            MessageLookupByLibrary.simpleMessage("確認重置類別為預設值？"),
        "category": MessageLookupByLibrary.simpleMessage("類別"),
        "chicken": MessageLookupByLibrary.simpleMessage("雞肉"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "confirmCategoryDelete":
            MessageLookupByLibrary.simpleMessage("您確定要刪除此類別嗎？"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("確認刪除"),
        "confirmReset": MessageLookupByLibrary.simpleMessage("確認重置"),
        "confirmsubcategorydelete":
            MessageLookupByLibrary.simpleMessage("您確定要刪除此子類別嗎？"),
        "contactUs": MessageLookupByLibrary.simpleMessage("聯絡我們"),
        "contributeCode": MessageLookupByLibrary.simpleMessage("貢獻程式碼"),
        "contributeTranslation": MessageLookupByLibrary.simpleMessage("貢獻翻譯"),
        "contributeTranslationOfFoodlist":
            MessageLookupByLibrary.simpleMessage("貢獻 FoodList 的翻譯"),
        "edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "editCategoriesNotSupportedHint":
            MessageLookupByLibrary.simpleMessage("編輯類別功能尚未支援！"),
        "editCategory": MessageLookupByLibrary.simpleMessage("編輯類別"),
        "editIngredients": MessageLookupByLibrary.simpleMessage("編輯食材"),
        "editResetCategories": MessageLookupByLibrary.simpleMessage("編輯/重置類別"),
        "editSubategory": MessageLookupByLibrary.simpleMessage("編輯子類別"),
        "editSubcategory": MessageLookupByLibrary.simpleMessage("編輯子類別"),
        "egg": MessageLookupByLibrary.simpleMessage("蛋"),
        "eggMilk": MessageLookupByLibrary.simpleMessage("蛋奶"),
        "emailCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("電子郵件已複製到剪貼簿"),
        "enterNewCategoryName": MessageLookupByLibrary.simpleMessage("輸入新類別名稱"),
        "enterNewSubcategoryName":
            MessageLookupByLibrary.simpleMessage("輸入新子類別名稱"),
        "entryDate": MessageLookupByLibrary.simpleMessage("輸入日期"),
        "error": MessageLookupByLibrary.simpleMessage("錯誤"),
        "example": MessageLookupByLibrary.simpleMessage("範例"),
        "expireDate": MessageLookupByLibrary.simpleMessage("有效日期"),
        "expireDateConfirmMessage": m0,
        "faq": MessageLookupByLibrary.simpleMessage("常見問題"),
        "faqHowToEditSubcategories":
            MessageLookupByLibrary.simpleMessage("如何編輯子類別？"),
        "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
            "要編輯子類別，請點擊您想要編輯的類別。接著您將移動到子類別編輯頁面。"),
        "faqWhatWillResetCategoriesDo":
            MessageLookupByLibrary.simpleMessage("重置類別會發生什麼事？"),
        "faqWhatWillResetCategoriesDoAns":
            MessageLookupByLibrary.simpleMessage("重置類別將會將所有類別和子類別重設為預設值。"),
        "faqWhyEditNotLoad":
            MessageLookupByLibrary.simpleMessage("為什麼資料沒有自動載入到編輯頁面？"),
        "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
            "由於資料結構的原因，如果您的資料之前是以不同語言儲存的，則不會自動載入。但是，您仍然可以從空白狀態開始編輯。"),
        "faqWhyNotificationDelay":
            MessageLookupByLibrary.simpleMessage("為什麼通知會延遲？"),
        "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
            "由於電池最佳化設定或 Android 限制，某些裝置上的通知可能會延遲。"),
        "faqWhyNotificationNotWork":
            MessageLookupByLibrary.simpleMessage("為什麼通知沒有正常運作？"),
        "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
            "請確保您在裝置的設定中已啟用應用程式的通知。如果仍然無法正常運作，請檢查電池最佳化設定，並為該應用程式禁用電池最佳化。"),
        "feedback": MessageLookupByLibrary.simpleMessage("回饋"),
        "fish": MessageLookupByLibrary.simpleMessage("魚類"),
        "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
        "foodlistExpiryNotification":
            MessageLookupByLibrary.simpleMessage("FoodList 有效日期通知"),
        "foodlistExpiryNotificationContent": m1,
        "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
        "forgerwisesGithub":
            MessageLookupByLibrary.simpleMessage("ForgerWise 的 GitHub"),
        "fruit": MessageLookupByLibrary.simpleMessage("水果"),
        "githubRepository": MessageLookupByLibrary.simpleMessage("GitHub 儲存庫"),
        "home": MessageLookupByLibrary.simpleMessage("首頁"),
        "homepage": MessageLookupByLibrary.simpleMessage("官方網站"),
        "languageNotSupportedYetMessage":
            MessageLookupByLibrary.simpleMessage("此語言尚未支援！但我們預計會在未來支援此語言！"),
        "languages": MessageLookupByLibrary.simpleMessage("語言"),
        "meat": MessageLookupByLibrary.simpleMessage("肉類"),
        "mesOfBugReport": MessageLookupByLibrary.simpleMessage(
            "錯誤: \n\n裝置: \n\n作業系統: \n\n應用程式版本: \n\n重現錯誤的流程: \n\n*如果您有螢幕截圖，請一併附上。\n\n*如果您不清楚您的裝置詳細資訊，可以跳過該部分不填寫。"),
        "mesOfContributeTrans": MessageLookupByLibrary.simpleMessage(
            "我想貢獻的語言: \n\n*如果您想貢獻一項新語言，我們將提供翻譯檔案。"),
        "mesOfTransError": MessageLookupByLibrary.simpleMessage(
            "語言: \n\n錯誤的翻譯: \n\n正確的翻譯: \n\n"),
        "milk": MessageLookupByLibrary.simpleMessage("牛奶"),
        "mushroom": MessageLookupByLibrary.simpleMessage("菇類"),
        "none": MessageLookupByLibrary.simpleMessage("無"),
        "notificationContent": MessageLookupByLibrary.simpleMessage(
            "設定您希望接收通知的時間，這將幫助您了解哪些物品即將過期。"),
        "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
            "在部分設備可能因為電池優化設定或 Android 限制而導致通知延遲。"),
        "notificationMoreItems": m2,
        "notificationSetting": MessageLookupByLibrary.simpleMessage("通知設定"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "officialWebsite": MessageLookupByLibrary.simpleMessage("官方網站"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "otherBeans": MessageLookupByLibrary.simpleMessage("其他豆類"),
        "otherEggMilk": MessageLookupByLibrary.simpleMessage("其他蛋奶"),
        "otherFishes": MessageLookupByLibrary.simpleMessage("其他魚類"),
        "otherFruits": MessageLookupByLibrary.simpleMessage("其他水果"),
        "otherItems": MessageLookupByLibrary.simpleMessage("其他食材"),
        "otherMeats": MessageLookupByLibrary.simpleMessage("其他肉類"),
        "otherMushrooms": MessageLookupByLibrary.simpleMessage("其他菇類"),
        "otherProcessedFoods": MessageLookupByLibrary.simpleMessage("其他加工食品"),
        "otherVegetables": MessageLookupByLibrary.simpleMessage("其他蔬菜"),
        "others": MessageLookupByLibrary.simpleMessage("其他"),
        "oyster": MessageLookupByLibrary.simpleMessage("牡蠣"),
        "policy": MessageLookupByLibrary.simpleMessage("隱私政策"),
        "pork": MessageLookupByLibrary.simpleMessage("豬肉"),
        "privacyContent": MessageLookupByLibrary.simpleMessage(
            "本隱私政策說明我們的應用程式（以下簡稱為“應用程式”）如何收集、使用及披露您的資訊。應用程式致力於維護用戶的隱私權。我們的隱私政策旨在幫助您了解我們如何收集及使用您決定分享的個人資訊，並幫助您在使用應用程式時做出明智的決定。\n\n使用或訪問應用程式即表示您接受本隱私政策中描述的做法。如果您不同意此政策，請勿使用應用程式。我們保留隨時修改此政策的權利，請經常查看更新。您繼續使用應用程式即表示接受我們修改後的隱私政策。\n\n1. 我們收集的數據\n目前，應用程式不會收集任何個人數據。應用程式的設計是將與您的食物相關的所有數據儲存在裝置內，並且沒有任何功能可用來收集您的個人數據。\n\n2. 數據儲存與保護\n您的數據儲存在您的裝置中，除非由您或裝置提供商分享，否則其他人無法存取。\n\n3. 未來更新\n未來若有允許用戶上傳數據以進行同步的功能，我們仍不會將此資訊透露給第三方。我們將在這些功能新增時公告隱私政策的更新。\n\n4. 隱私政策變更\n應用程式保留隨時更改本政策及服務條款的權利。我們將通過向您帳戶中指定的主要電子郵件地址發送通知或在我們的網站上放置醒目的通知來告知您對隱私政策的重大更改。重大更改將在通知後30天生效。非重大更改或澄清將立即生效。您應定期檢查網站和本隱私頁面以了解更新。"),
        "processedfood": MessageLookupByLibrary.simpleMessage("加工食品"),
        "rateThisApp": MessageLookupByLibrary.simpleMessage("為此應用程式評分"),
        "reset": MessageLookupByLibrary.simpleMessage("重置"),
        "salmon": MessageLookupByLibrary.simpleMessage("鮭魚"),
        "save": MessageLookupByLibrary.simpleMessage("儲存"),
        "selectCategoryHint": MessageLookupByLibrary.simpleMessage("選擇類別"),
        "selectDate": MessageLookupByLibrary.simpleMessage("選擇日期"),
        "selectSubcategoryHint": MessageLookupByLibrary.simpleMessage("選擇子類別"),
        "selectedTime": m3,
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "slideToDelete": MessageLookupByLibrary.simpleMessage("滑動以刪除"),
        "soybean": MessageLookupByLibrary.simpleMessage("黃豆"),
        "specialThanksToAllContributorsBelow":
            MessageLookupByLibrary.simpleMessage("特別感謝以下所有貢獻者！"),
        "subcategory": MessageLookupByLibrary.simpleMessage("子類別"),
        "subcategoryName": MessageLookupByLibrary.simpleMessage("子類別名稱"),
        "subcategoryNameInputHint":
            MessageLookupByLibrary.simpleMessage("請輸入子類別名稱"),
        "translationError": MessageLookupByLibrary.simpleMessage("翻譯錯誤"),
        "translationErrorOfFoodlist":
            MessageLookupByLibrary.simpleMessage("FoodList 的翻譯錯誤"),
        "tuna": MessageLookupByLibrary.simpleMessage("鮪魚"),
        "urlCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("網址已複製到剪貼簿"),
        "vegetable": MessageLookupByLibrary.simpleMessage("蔬菜"),
        "versionVersion": m4
      };
}
