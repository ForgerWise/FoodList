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

  static String m0(days) => "${days} 天";

  static String m1(days) => "還剩 ${days} 天";

  static String m2(expireDate) => "有效日期: ${expireDate}";

  static String m3(days) => "已過期 ${days} 天";

  static String m4(todayItems, tomorrowItems) =>
      "今日: ${todayItems} ／ 明日: ${tomorrowItems}";

  static String m5(name) => "已新增 ${name}";

  static String m6(itemName) => "\"${itemName}\" 已刪除";

  static String m7(name, count) => "${name}：剩 ×${count}";

  static String m8(number) => "以及 ${number} 項其他食材";

  static String m9(selectedHour, selectedMinute) =>
      "選擇的時間: ${selectedHour}:${selectedMinute}";

  static String m10(days) => "${days} 天內";

  static String m11(name) => "${name} 已用完";

  static String m12(version) => "版本: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("關於"),
    "aboutContent": MessageLookupByLibrary.simpleMessage(
      "這個應用程式源自我們對抗食物浪費的承諾。由於家庭食物浪費佔了近一半，我們提供了一個簡單易用的工具，幫助使用者管理食物的保存期限。希望透過這個工具，減少不必要的購買，並減少家庭中的食物浪費。",
    ),
    "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
      "這個應用程式是完全開源且免費使用的。如果您有任何建議或想要貢獻此專案，請隨時訪問 GitHub 儲存庫。",
    ),
    "aboutContentHomepage": MessageLookupByLibrary.simpleMessage(
      "如果您對我們的其他專案有興趣，歡迎造訪我們的官方網站。",
    ),
    "aboutFoodlist": MessageLookupByLibrary.simpleMessage("關於 FoodList"),
    "add": MessageLookupByLibrary.simpleMessage("新增"),
    "addCategory": MessageLookupByLibrary.simpleMessage("新增類別"),
    "addIngredients": MessageLookupByLibrary.simpleMessage("新增食材"),
    "addSubcategory": MessageLookupByLibrary.simpleMessage("新增子類別"),
    "appearance": MessageLookupByLibrary.simpleMessage("外觀"),
    "apple": MessageLookupByLibrary.simpleMessage("蘋果"),
    "barcodeNotFound": MessageLookupByLibrary.simpleMessage(
      "查無此商品。輸入名稱後，下次掃描會自動帶入",
    ),
    "bean": MessageLookupByLibrary.simpleMessage("豆類"),
    "beef": MessageLookupByLibrary.simpleMessage("牛肉"),
    "bugReport": MessageLookupByLibrary.simpleMessage("錯誤報告"),
    "bugReportOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "FoodList 的錯誤報告",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "無法使用相機。請在系統設定允許相機權限，或直接輸入名稱。",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "carrot": MessageLookupByLibrary.simpleMessage("紅蘿蔔"),
    "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
      "此食材的類別或子類別已被刪除，無法編輯。如果要編輯此食材的內容，請刪除該食材並重新添加。",
    ),
    "categoriesResetHint": MessageLookupByLibrary.simpleMessage("確認重置類別為預設值？"),
    "category": MessageLookupByLibrary.simpleMessage("類別"),
    "categoryName": MessageLookupByLibrary.simpleMessage("類別名稱"),
    "chicken": MessageLookupByLibrary.simpleMessage("雞肉"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("清除篩選"),
    "clickToChangeReminderTime": MessageLookupByLibrary.simpleMessage(
      "點擊修改提醒時間",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmCategoryDelete": MessageLookupByLibrary.simpleMessage(
      "要刪除這個類別嗎？其中的食材會移到「其他」。",
    ),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("確認刪除"),
    "confirmReset": MessageLookupByLibrary.simpleMessage("確認重置"),
    "confirmsubcategorydelete": MessageLookupByLibrary.simpleMessage(
      "您確定要刪除此子類別嗎？",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("聯絡我們"),
    "contributeCode": MessageLookupByLibrary.simpleMessage("貢獻程式碼"),
    "contributeTranslation": MessageLookupByLibrary.simpleMessage("貢獻翻譯"),
    "contributeTranslationOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "貢獻 FoodList 的翻譯",
    ),
    "customDate": MessageLookupByLibrary.simpleMessage("自訂日期"),
    "dataSources": MessageLookupByLibrary.simpleMessage("商品資料來源"),
    "dataSourcesContent": MessageLookupByLibrary.simpleMessage(
      "商品名稱來自 Open Food Facts（ODbL 授權），日本商品另使用 Yahoo!ショッピング。",
    ),
    "dateFromPhoto": MessageLookupByLibrary.simpleMessage("已從照片讀取日期"),
    "daysChip": m0,
    "daysLeft": m1,
    "delete": MessageLookupByLibrary.simpleMessage("刪除"),
    "disabled": MessageLookupByLibrary.simpleMessage("已關閉"),
    "dragToReorderHint": MessageLookupByLibrary.simpleMessage(
      "長按右側拖動手柄可調整排列順序",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("編輯"),
    "editCategoriesNotSupportedHint": MessageLookupByLibrary.simpleMessage(
      "編輯類別功能尚未支援！",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("編輯類別"),
    "editIngredients": MessageLookupByLibrary.simpleMessage("編輯食材"),
    "editResetCategories": MessageLookupByLibrary.simpleMessage("編輯/重置類別"),
    "editSubategory": MessageLookupByLibrary.simpleMessage("編輯子類別"),
    "editSubcategory": MessageLookupByLibrary.simpleMessage("編輯子類別"),
    "egg": MessageLookupByLibrary.simpleMessage("蛋"),
    "eggMilk": MessageLookupByLibrary.simpleMessage("蛋奶"),
    "emailCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "電子郵件已複製到剪貼簿",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("已開啟"),
    "enterNewCategoryName": MessageLookupByLibrary.simpleMessage("輸入新類別名稱"),
    "enterNewSubcategoryName": MessageLookupByLibrary.simpleMessage("輸入新子類別名稱"),
    "entryDate": MessageLookupByLibrary.simpleMessage("輸入日期"),
    "error": MessageLookupByLibrary.simpleMessage("錯誤"),
    "example": MessageLookupByLibrary.simpleMessage("範例"),
    "expireDate": MessageLookupByLibrary.simpleMessage("有效日期"),
    "expireDateConfirmMessage": m2,
    "expiredDaysAgo": m3,
    "expiresToday": MessageLookupByLibrary.simpleMessage("今天到期！"),
    "expiresTomorrow": MessageLookupByLibrary.simpleMessage("明天到期！"),
    "expiryFromBarcode": MessageLookupByLibrary.simpleMessage("已從條碼讀取到期日"),
    "faq": MessageLookupByLibrary.simpleMessage("常見問題"),
    "faqHowToEditItem": MessageLookupByLibrary.simpleMessage("如何編輯、用掉或刪除食材？"),
    "faqHowToEditItemAns": MessageLookupByLibrary.simpleMessage(
      "點一下食材即可編輯。往左滑會出現「用掉一個」（數量減一，只剩一個時會移除）與「刪除」，兩者都可以立即復原。",
    ),
    "faqHowToEditSubcategories": MessageLookupByLibrary.simpleMessage(
      "如何編輯子類別？",
    ),
    "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
      "要編輯子類別，請點擊您想要編輯的類別。接著您將移動到子類別編輯頁面。",
    ),
    "faqWhatDoesScanSend": MessageLookupByLibrary.simpleMessage("掃描條碼會傳送什麼資料？"),
    "faqWhatDoesScanSendAns": MessageLookupByLibrary.simpleMessage(
      "只會把條碼號碼傳給 Open Food Facts（日本商品另傳給 Yahoo! 購物）來查詢商品名稱。相機影像不會離開你的手機，你輸入的名稱只記在手機裡。",
    ),
    "faqWhatWillResetCategoriesDo": MessageLookupByLibrary.simpleMessage(
      "重置類別會發生什麼事？",
    ),
    "faqWhatWillResetCategoriesDoAns": MessageLookupByLibrary.simpleMessage(
      "重置會把類別與圖示恢復成預設值，已儲存的食材不會被刪除。",
    ),
    "faqWhyEditNotLoad": MessageLookupByLibrary.simpleMessage(
      "為什麼資料沒有自動載入到編輯頁面？",
    ),
    "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
      "由於資料結構的原因，如果您的資料之前是以不同語言儲存的，則不會自動載入。但是，您仍然可以從空白狀態開始編輯。",
    ),
    "faqWhyNotificationDelay": MessageLookupByLibrary.simpleMessage(
      "為什麼通知會延遲？",
    ),
    "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
      "FoodList 使用系統鬧鐘，Android 可能因為省電機制而將通知延遲幾分鐘，這屬於正常行為。若延遲超過 30 分鐘，建議關閉該 App 的電池最佳化設定。",
    ),
    "faqWhyNotificationNotWork": MessageLookupByLibrary.simpleMessage(
      "為什麼通知沒有正常運作？",
    ),
    "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
      "1. 前往裝置的設定 > 應用程式 > FoodList > 通知，確認已啟用通知。\n2. 關閉 FoodList 的電池最佳化（設定 > 電池 > 電池最佳化 > FoodList > 不要最佳化）。\n3. 在 App 中將通知開關關閉再重新開啟，以重新登記鬧鐘。",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("回饋"),
    "filterAll": MessageLookupByLibrary.simpleMessage("全部"),
    "filterExpired": MessageLookupByLibrary.simpleMessage("已過期"),
    "filterExpiringSoon": MessageLookupByLibrary.simpleMessage("即將到期"),
    "fish": MessageLookupByLibrary.simpleMessage("魚類"),
    "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
    "foodlistExpiryNotification": MessageLookupByLibrary.simpleMessage(
      "🍱 食材到期提醒",
    ),
    "foodlistExpiryNotificationContent": m4,
    "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
    "forgerwisesGithub": MessageLookupByLibrary.simpleMessage(
      "ForgerWise 的 GitHub",
    ),
    "fruit": MessageLookupByLibrary.simpleMessage("水果"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("GitHub 儲存庫"),
    "gotIt": MessageLookupByLibrary.simpleMessage("開始使用"),
    "home": MessageLookupByLibrary.simpleMessage("首頁"),
    "homepage": MessageLookupByLibrary.simpleMessage("官方網站"),
    "icon": MessageLookupByLibrary.simpleMessage("圖示"),
    "inStoreBarcode": MessageLookupByLibrary.simpleMessage(
      "這是店內自貼的條碼（生鮮秤重商品）。輸入名稱一次，下次就會自動帶入。",
    ),
    "ingredientManagement": MessageLookupByLibrary.simpleMessage("食材管理"),
    "ingredientName": MessageLookupByLibrary.simpleMessage("食材名稱"),
    "ingredientNameHint": MessageLookupByLibrary.simpleMessage("輸入名稱，或從下方直接選"),
    "itemAdded": m5,
    "itemDeleted": m6,
    "languageNotSupportedYetMessage": MessageLookupByLibrary.simpleMessage(
      "此語言尚未支援！但我們預計會在未來支援此語言！",
    ),
    "languages": MessageLookupByLibrary.simpleMessage("語言"),
    "leftCount": m7,
    "license": MessageLookupByLibrary.simpleMessage("授權"),
    "lookingUp": MessageLookupByLibrary.simpleMessage("查詢中…"),
    "meat": MessageLookupByLibrary.simpleMessage("肉類"),
    "mesOfBugReport": MessageLookupByLibrary.simpleMessage(
      "錯誤: \n\n裝置: \n\n作業系統: \n\n應用程式版本: \n\n重現錯誤的流程: \n\n*如果您有螢幕截圖，請一併附上。\n\n*如果您不清楚您的裝置詳細資訊，可以跳過該部分不填寫。",
    ),
    "mesOfContributeTrans": MessageLookupByLibrary.simpleMessage(
      "我想貢獻的語言: \n\n*如果您想貢獻一項新語言，我們將提供翻譯檔案。",
    ),
    "mesOfTransError": MessageLookupByLibrary.simpleMessage(
      "語言: \n\n錯誤的翻譯: \n\n正確的翻譯: \n\n",
    ),
    "milk": MessageLookupByLibrary.simpleMessage("牛奶"),
    "mushroom": MessageLookupByLibrary.simpleMessage("菇類"),
    "noDateFound": MessageLookupByLibrary.simpleMessage("讀不到日期，請手動選擇"),
    "noIngredients": MessageLookupByLibrary.simpleMessage("尚無食材"),
    "noIngredientsHint": MessageLookupByLibrary.simpleMessage("點擊 + 新增第一個食材！"),
    "noMatches": MessageLookupByLibrary.simpleMessage("沒有建議項目，直接儲存輸入的名稱即可"),
    "none": MessageLookupByLibrary.simpleMessage("無"),
    "nothingExpiringSoon": MessageLookupByLibrary.simpleMessage(
      "今明兩天沒有食材快到期，繼續保持！🎉",
    ),
    "nothingMatches": MessageLookupByLibrary.simpleMessage("沒有符合的食材"),
    "notificationContent": MessageLookupByLibrary.simpleMessage(
      "每天提醒一次今天與明天到期的食材。",
    ),
    "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
      "在部分設備上，通知可能會比設定時間晚幾分鐘到達，這是 Android 電池最佳化的正常行為。",
    ),
    "notificationMoreItems": m8,
    "notificationSetting": MessageLookupByLibrary.simpleMessage("通知設定"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "ocrUnavailable": MessageLookupByLibrary.simpleMessage("文字辨識模型下載中，請稍後再試。"),
    "officialWebsite": MessageLookupByLibrary.simpleMessage("官方網站"),
    "onboardingAdd": MessageLookupByLibrary.simpleMessage(
      "按「新增」，選一個常用食材，名稱和日期就自動填好。",
    ),
    "onboardingSwipe": MessageLookupByLibrary.simpleMessage(
      "把食材往左滑，可以標記用掉或刪除。",
    ),
    "onboardingTap": MessageLookupByLibrary.simpleMessage("點一下食材即可編輯。"),
    "onboardingTitle": MessageLookupByLibrary.simpleMessage("歡迎使用 FoodList"),
    "openSettings": MessageLookupByLibrary.simpleMessage("開啟設定"),
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
    "preferences": MessageLookupByLibrary.simpleMessage("偏好設定"),
    "privacyContent": MessageLookupByLibrary.simpleMessage(
      "最後更新：2026-09-28（版本 3.1.0）\n\n你的食材清單不會離開你的手機，我們也不收集任何個人資料。\n\n1. 儲存在裝置上的資料\n你輸入的所有內容（食材、日期、數量、類別與設定）都只儲存在你的裝置上。我們沒有伺服器，也沒有帳號系統。解除安裝 App 即會刪除這些資料。\n\n2. 條碼掃描（選用）\n相機只在掃描畫面開啟時使用，影像只在裝置上辨識條碼，不會儲存或上傳。\n為了帶入商品名稱，App 只會把「條碼號碼」傳送給 Open Food Facts；日本商品另外傳送給 Yahoo! JAPAN 購物 Web API。不會傳送姓名、帳號或位置。與一般網路連線相同，這些服務可以看到你的 IP 位址。\n你為條碼輸入的名稱會記在你的裝置上。\n\n3. 通知\n到期提醒由 App 在本機排程與顯示，不會傳送到伺服器。\n\n4. 評分\nApp 可能偶爾顯示 Google Play 內建的評分視窗，這由 Google 提供，FoodList 不會取得任何資料。\n\n5. 政策變更\n若未來版本會傳送更多資料（例如同步功能），我們會先更新本政策。\n\n聯絡我們：forgerwise@gmail.com",
    ),
    "processedfood": MessageLookupByLibrary.simpleMessage("加工食品"),
    "quantity": MessageLookupByLibrary.simpleMessage("數量"),
    "quickPick": MessageLookupByLibrary.simpleMessage("快速選擇"),
    "rateApp": MessageLookupByLibrary.simpleMessage("給 FoodList 評分"),
    "rateThisApp": MessageLookupByLibrary.simpleMessage("為此應用程式評分"),
    "readDate": MessageLookupByLibrary.simpleMessage("拍照讀日期"),
    "reminderTime": MessageLookupByLibrary.simpleMessage("提醒時間"),
    "reset": MessageLookupByLibrary.simpleMessage("重置"),
    "salmon": MessageLookupByLibrary.simpleMessage("鮭魚"),
    "save": MessageLookupByLibrary.simpleMessage("儲存"),
    "saveAndNext": MessageLookupByLibrary.simpleMessage("儲存並繼續新增"),
    "scanBarcode": MessageLookupByLibrary.simpleMessage("掃描條碼"),
    "scanBarcodeHint": MessageLookupByLibrary.simpleMessage("將條碼對準框內"),
    "searchHint": MessageLookupByLibrary.simpleMessage("搜尋食材..."),
    "selectDate": MessageLookupByLibrary.simpleMessage("選擇日期"),
    "selectedTime": m9,
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "slideToDelete": MessageLookupByLibrary.simpleMessage("滑動以刪除"),
    "soonThreshold": MessageLookupByLibrary.simpleMessage("「即將到期」的範圍"),
    "soonThresholdHint": MessageLookupByLibrary.simpleMessage(
      "在這個天數內到期的食材會顯示為橘色。",
    ),
    "soonThresholdValue": m10,
    "soybean": MessageLookupByLibrary.simpleMessage("黃豆"),
    "specialThanksToAllContributorsBelow": MessageLookupByLibrary.simpleMessage(
      "特別感謝以下所有貢獻者！",
    ),
    "summaryExpired": MessageLookupByLibrary.simpleMessage("已過期"),
    "summaryExpiringSoon": MessageLookupByLibrary.simpleMessage("即將到期"),
    "summaryFresh": MessageLookupByLibrary.simpleMessage("新鮮"),
    "themeDark": MessageLookupByLibrary.simpleMessage("深色"),
    "themeLight": MessageLookupByLibrary.simpleMessage("淺色"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("跟隨系統"),
    "torch": MessageLookupByLibrary.simpleMessage("手電筒"),
    "translationError": MessageLookupByLibrary.simpleMessage("翻譯錯誤"),
    "translationErrorOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "FoodList 的翻譯錯誤",
    ),
    "tuna": MessageLookupByLibrary.simpleMessage("鮪魚"),
    "undo": MessageLookupByLibrary.simpleMessage("復原"),
    "urlCopiedToClipboard": MessageLookupByLibrary.simpleMessage("網址已複製到剪貼簿"),
    "useOne": MessageLookupByLibrary.simpleMessage("用掉"),
    "usedUp": m11,
    "vegetable": MessageLookupByLibrary.simpleMessage("蔬菜"),
    "versionVersion": m12,
    "whichDate": MessageLookupByLibrary.simpleMessage("哪一個是有效日期？"),
  };
}
