// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(days) => "${days}日";

  static String m1(days) => "あと ${days} 日";

  static String m2(expireDate) => "消費期限: ${expireDate}";

  static String m3(days) => "${days} 日前に期限切れ";

  static String m4(todayItems, tomorrowItems) =>
      "今日: ${todayItems} ／ 明日: ${tomorrowItems}";

  static String m5(name) => "${name} を追加しました";

  static String m6(itemName) => "\"${itemName}\" を削除しました";

  static String m7(name, count) => "${name}：残り ×${count}";

  static String m8(number) => "と ${number} 件のその他の食材";

  static String m9(selectedHour, selectedMinute) =>
      "選択した時間: ${selectedHour}:${selectedMinute}";

  static String m10(days) => "${days}日以内";

  static String m11(name) => "${name} を使い切りました";

  static String m12(version) => "バージョン: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("このアプリについて"),
    "aboutContent": MessageLookupByLibrary.simpleMessage(
      "このアプリは、フードロスを減らすために作成されました。実際、廃棄される食品のほぼ半分は家庭で発生しています。そこで、ユーザーが生鮮食品の賞味期限を簡単に管理できるツールを提供します。私たちの目標は、不必要な購入を減らし、家庭での食品廃棄物を減少させることです。",
    ),
    "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
      "このアプリは完全にオープンソースで、無料で使用できます。ご意見やプロジェクトへの貢献がありましたら、GitHubリポジトリをご覧ください。",
    ),
    "aboutContentHomepage": MessageLookupByLibrary.simpleMessage(
      "他のプロジェクトにご興味がある場合は、公式サイトをご覧ください。",
    ),
    "aboutFoodlist": MessageLookupByLibrary.simpleMessage("FoodListについて"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addCategory": MessageLookupByLibrary.simpleMessage("カテゴリを追加"),
    "addIngredients": MessageLookupByLibrary.simpleMessage("食材を追加する"),
    "addSubcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを追加"),
    "appearance": MessageLookupByLibrary.simpleMessage("外観"),
    "apple": MessageLookupByLibrary.simpleMessage("リンゴ"),
    "barcodeNotFound": MessageLookupByLibrary.simpleMessage(
      "商品が見つかりません。名前を入力すると次回から自動入力されます",
    ),
    "bean": MessageLookupByLibrary.simpleMessage("豆類"),
    "beef": MessageLookupByLibrary.simpleMessage("牛肉"),
    "bugReport": MessageLookupByLibrary.simpleMessage("バグ報告"),
    "bugReportOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "FoodListのバグ報告",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "カメラを使用できません。設定でカメラへのアクセスを許可するか、名前を入力してください。",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "carrot": MessageLookupByLibrary.simpleMessage("ニンジン"),
    "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
      "この食材のカテゴリまたはサブカテゴリが削除されているため、編集できません。この食材の内容を編集するには、食材を削除して再度追加してください。",
    ),
    "categoriesResetHint": MessageLookupByLibrary.simpleMessage(
      "カテゴリをデフォルトにリセットしますか？",
    ),
    "category": MessageLookupByLibrary.simpleMessage("カテゴリ"),
    "categoryName": MessageLookupByLibrary.simpleMessage("カテゴリー名"),
    "chicken": MessageLookupByLibrary.simpleMessage("鶏肉"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("絞り込みを解除"),
    "clickToChangeReminderTime": MessageLookupByLibrary.simpleMessage(
      "タップして時間を変更",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmCategoryDelete": MessageLookupByLibrary.simpleMessage(
      "このカテゴリを削除しますか？中の食材は「その他」に移動します。",
    ),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("削除を確認"),
    "confirmReset": MessageLookupByLibrary.simpleMessage("リセットを確認"),
    "confirmsubcategorydelete": MessageLookupByLibrary.simpleMessage(
      "このサブカテゴリを削除してもよろしいですか？",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
    "contributeCode": MessageLookupByLibrary.simpleMessage("コードに貢献"),
    "contributeTranslation": MessageLookupByLibrary.simpleMessage("翻訳に貢献"),
    "contributeTranslationOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "FoodListの翻訳に貢献",
    ),
    "customDate": MessageLookupByLibrary.simpleMessage("日付を選択"),
    "dataSources": MessageLookupByLibrary.simpleMessage("商品データ"),
    "dataSourcesContent": MessageLookupByLibrary.simpleMessage(
      "商品名は Open Food Facts（ODbL）と、日本では Yahoo!ショッピングから取得しています。",
    ),
    "dateFromPhoto": MessageLookupByLibrary.simpleMessage("写真から期限を読み取りました"),
    "daysChip": m0,
    "daysLeft": m1,
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "disabled": MessageLookupByLibrary.simpleMessage("オフ"),
    "dragToReorderHint": MessageLookupByLibrary.simpleMessage(
      "右側のハンドルを長押しして並べ替える",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editCategoriesNotSupportedHint": MessageLookupByLibrary.simpleMessage(
      "カテゴリの編集機能はまだサポートされていません！",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("カテゴリを編集"),
    "editIngredients": MessageLookupByLibrary.simpleMessage("食材を編集する"),
    "editResetCategories": MessageLookupByLibrary.simpleMessage("カテゴリを編集/リセット"),
    "editSubategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを編集"),
    "editSubcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを編集"),
    "egg": MessageLookupByLibrary.simpleMessage("卵"),
    "eggMilk": MessageLookupByLibrary.simpleMessage("卵と乳製品"),
    "emailCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "電子メールがクリップボードにコピーされました",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("オン"),
    "enterNewCategoryName": MessageLookupByLibrary.simpleMessage("新しいカテゴリ名を入力"),
    "enterNewSubcategoryName": MessageLookupByLibrary.simpleMessage(
      "新しいサブカテゴリ名を入力",
    ),
    "entryDate": MessageLookupByLibrary.simpleMessage("入力日付"),
    "error": MessageLookupByLibrary.simpleMessage("エラー"),
    "example": MessageLookupByLibrary.simpleMessage("例"),
    "expireDate": MessageLookupByLibrary.simpleMessage("消費期限"),
    "expireDateConfirmMessage": m2,
    "expiredDaysAgo": m3,
    "expiresToday": MessageLookupByLibrary.simpleMessage("今日まで！"),
    "expiresTomorrow": MessageLookupByLibrary.simpleMessage("明日まで！"),
    "expiryFromBarcode": MessageLookupByLibrary.simpleMessage(
      "バーコードから期限を読み取りました",
    ),
    "faq": MessageLookupByLibrary.simpleMessage("よくある質問"),
    "faqHowToEditItem": MessageLookupByLibrary.simpleMessage(
      "食材の編集・使用・削除はどうすればいいですか？",
    ),
    "faqHowToEditItemAns": MessageLookupByLibrary.simpleMessage(
      "食材をタップすると編集できます。左にスワイプすると「1つ使った」（数量を1減らし、最後の1つなら削除）と「削除」が表示され、どちらもすぐに元に戻せます。",
    ),
    "faqHowToEditSubcategories": MessageLookupByLibrary.simpleMessage(
      "サブカテゴリを編集する方法",
    ),
    "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
      "サブカテゴリを編集するには、編集したいカテゴリをタップしてください。その後、サブカテゴリ編集ページにリダイレクトされます。",
    ),
    "faqWhatDoesScanSend": MessageLookupByLibrary.simpleMessage(
      "バーコードスキャンでは何が送信されますか？",
    ),
    "faqWhatDoesScanSendAns": MessageLookupByLibrary.simpleMessage(
      "商品名を調べるため、バーコードの番号のみを Open Food Facts（日本の商品は Yahoo!ショッピングにも）へ送信します。カメラ画像が端末の外に出ることはなく、入力した名前も端末内にのみ保存されます。",
    ),
    "faqWhatWillResetCategoriesDo": MessageLookupByLibrary.simpleMessage(
      "カテゴリをリセットすると何が起こりますか？",
    ),
    "faqWhatWillResetCategoriesDoAns": MessageLookupByLibrary.simpleMessage(
      "リセットするとカテゴリとアイコンが初期状態に戻ります。保存済みの食材は削除されません。",
    ),
    "faqWhyEditNotLoad": MessageLookupByLibrary.simpleMessage(
      "なぜデータが自動的に編集ページにロードされなかったのですか？",
    ),
    "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
      "データ構造のため、以前に異なる言語で保存されたデータは自動的にロードされません。ただし、空の状態から編集を開始することはできます。",
    ),
    "faqWhyNotificationDelay": MessageLookupByLibrary.simpleMessage(
      "なぜ通知が遅れているのですか？",
    ),
    "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
      "FoodList はシステムアラームを使用しており、Android の省電力機能により数分遅れる場合があります。これは正常な動作です。30分以上遅れる場合は、アプリのバッテリー最適化を無効にすることをお勧めします。",
    ),
    "faqWhyNotificationNotWork": MessageLookupByLibrary.simpleMessage(
      "なぜ通知が機能していないのですか？",
    ),
    "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
      "1. デバイスの設定 > アプリ > FoodList > 通知 で通知が有効になっているか確認してください。\n2. FoodListのバッテリー最適化を無効にしてください（設定 > バッテリー > バッテリー最適化 > FoodList > 最適化しない）。\n3. アプリ内の通知スイッチをオフにしてから再度オンにして、アラームを再登録してください。",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("フィードバック"),
    "filterAll": MessageLookupByLibrary.simpleMessage("すべて"),
    "filterExpired": MessageLookupByLibrary.simpleMessage("期限切れ"),
    "filterExpiringSoon": MessageLookupByLibrary.simpleMessage("もうすぐ期限"),
    "fish": MessageLookupByLibrary.simpleMessage("魚"),
    "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
    "foodlistExpiryNotification": MessageLookupByLibrary.simpleMessage(
      "🍱 食材の期限通知",
    ),
    "foodlistExpiryNotificationContent": m4,
    "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
    "forgerwisesGithub": MessageLookupByLibrary.simpleMessage(
      "ForgerWiseのGitHub",
    ),
    "fruit": MessageLookupByLibrary.simpleMessage("果物"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("GitHubリポジトリ"),
    "gotIt": MessageLookupByLibrary.simpleMessage("はじめる"),
    "home": MessageLookupByLibrary.simpleMessage("ホーム"),
    "homepage": MessageLookupByLibrary.simpleMessage("公式サイト"),
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "inStoreBarcode": MessageLookupByLibrary.simpleMessage(
      "店内で貼られたバーコード（量り売り・生鮮品）です。一度名前を入力すると次回から自動入力されます。",
    ),
    "ingredientManagement": MessageLookupByLibrary.simpleMessage("食材の管理"),
    "ingredientName": MessageLookupByLibrary.simpleMessage("食材名"),
    "ingredientNameHint": MessageLookupByLibrary.simpleMessage(
      "名前を入力、または下から選択",
    ),
    "itemAdded": m5,
    "itemDeleted": m6,
    "languageNotSupportedYetMessage": MessageLookupByLibrary.simpleMessage(
      "この言語はまだサポートされていません！しかし、将来的にサポートされる予定です！",
    ),
    "languages": MessageLookupByLibrary.simpleMessage("言語"),
    "leftCount": m7,
    "license": MessageLookupByLibrary.simpleMessage("ライセンス"),
    "lookingUp": MessageLookupByLibrary.simpleMessage("検索中…"),
    "meat": MessageLookupByLibrary.simpleMessage("肉類"),
    "mesOfBugReport": MessageLookupByLibrary.simpleMessage(
      "バグ: \n\nデバイス: \n\nOS: \n\nアプリバージョン: \n\n再現手順: \n\n*スクリーンショットがある場合は添付してください。\n\n*デバイスの部分の詳細資料がわからない場合は、スキップして書かなくでも大丈夫です。",
    ),
    "mesOfContributeTrans": MessageLookupByLibrary.simpleMessage(
      "貢献したい言語: \n\n*新しい言語に貢献したい場合は、翻訳するファイルをお送りします。",
    ),
    "mesOfTransError": MessageLookupByLibrary.simpleMessage(
      "言語: \n\n翻訳エラー: \n\n正しい翻訳: \n\n",
    ),
    "milk": MessageLookupByLibrary.simpleMessage("牛乳"),
    "mushroom": MessageLookupByLibrary.simpleMessage("キノコ"),
    "noDateFound": MessageLookupByLibrary.simpleMessage(
      "日付を読み取れませんでした。手動で選んでください",
    ),
    "noIngredients": MessageLookupByLibrary.simpleMessage("食材がまだありません"),
    "noIngredientsHint": MessageLookupByLibrary.simpleMessage(
      "+ をタップして最初の食材を追加！",
    ),
    "noMatches": MessageLookupByLibrary.simpleMessage(
      "候補はありません。入力した名前でそのまま保存できます",
    ),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "nothingExpiringSoon": MessageLookupByLibrary.simpleMessage(
      "今日と明日に期限が来る食材はありません。この調子！🎉",
    ),
    "nothingMatches": MessageLookupByLibrary.simpleMessage("該当する食材はありません"),
    "notificationContent": MessageLookupByLibrary.simpleMessage(
      "今日と明日に期限が来る食材を1日1回お知らせします。",
    ),
    "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
      "一部のデバイスでは、設定時刻より数分遅れて通知が届く場合があります。これは Android のバッテリー最適化による正常な動作です。",
    ),
    "notificationMoreItems": m8,
    "notificationSetting": MessageLookupByLibrary.simpleMessage("通知設定"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "ocrUnavailable": MessageLookupByLibrary.simpleMessage(
      "文字認識モデルをダウンロード中です。少し待ってからお試しください。",
    ),
    "officialWebsite": MessageLookupByLibrary.simpleMessage("公式サイト"),
    "onboardingAdd": MessageLookupByLibrary.simpleMessage(
      "「追加」を押してよく使う食材を選ぶだけで、名前と日付が自動入力されます。",
    ),
    "onboardingSwipe": MessageLookupByLibrary.simpleMessage(
      "食材を左にスワイプすると「使った」または削除ができます。",
    ),
    "onboardingTap": MessageLookupByLibrary.simpleMessage("食材をタップすると編集できます。"),
    "onboardingTitle": MessageLookupByLibrary.simpleMessage("FoodList へようこそ"),
    "openSettings": MessageLookupByLibrary.simpleMessage("設定を開く"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "otherBeans": MessageLookupByLibrary.simpleMessage("その他の豆類"),
    "otherEggMilk": MessageLookupByLibrary.simpleMessage("その他の卵と乳製品"),
    "otherFishes": MessageLookupByLibrary.simpleMessage("その他の魚類"),
    "otherFruits": MessageLookupByLibrary.simpleMessage("その他の果物"),
    "otherItems": MessageLookupByLibrary.simpleMessage("その他のアイテム"),
    "otherMeats": MessageLookupByLibrary.simpleMessage("その他の肉類"),
    "otherMushrooms": MessageLookupByLibrary.simpleMessage("その他のキノコ"),
    "otherProcessedFoods": MessageLookupByLibrary.simpleMessage("その他の加工食品"),
    "otherVegetables": MessageLookupByLibrary.simpleMessage("その他の野菜"),
    "others": MessageLookupByLibrary.simpleMessage("その他"),
    "oyster": MessageLookupByLibrary.simpleMessage("牡蠣"),
    "policy": MessageLookupByLibrary.simpleMessage("プライバシーポリシー"),
    "pork": MessageLookupByLibrary.simpleMessage("豚肉"),
    "preferences": MessageLookupByLibrary.simpleMessage("設定"),
    "privacyContent": MessageLookupByLibrary.simpleMessage(
      "最終更新：2026-09-28（バージョン 3.1.0）\n\n食材リストがスマートフォンの外に出ることはなく、個人データも収集しません。\n\n1. 端末に保存されるデータ\n入力した内容（食材・日付・数量・カテゴリ・設定）はすべて端末内にのみ保存されます。サーバーやアカウントはありません。アプリをアンインストールするとデータも削除されます。\n\n2. バーコードスキャン（任意）\nカメラはスキャン画面を開いている間だけ使用し、画像は端末内でバーコードの読み取りにのみ使われ、保存・送信されません。\n商品名を入力するため、バーコードの番号のみを Open Food Facts と、日本の商品については Yahoo! JAPAN ショッピング Web API に送信します。氏名・アカウント・位置情報は送信しません。通常の通信と同様に、これらのサービスは IP アドレスを知ることができます。\nバーコードに付けた名前は端末内に保存されます。\n\n3. 通知\n期限のお知らせは端末内で予約・表示され、サーバーには送信されません。\n\n4. 評価\nGoogle Play 標準の評価ダイアログを表示することがあります。これは Google が提供するもので、FoodList がデータを受け取ることはありません。\n\n5. 変更\n今後のバージョンでより多くのデータを送信する機能（同期など）を追加する場合は、事前に本ポリシーを更新します。\n\nお問い合わせ：forgerwise@gmail.com",
    ),
    "processedfood": MessageLookupByLibrary.simpleMessage("加工食品"),
    "quantity": MessageLookupByLibrary.simpleMessage("数量"),
    "quickPick": MessageLookupByLibrary.simpleMessage("クイック選択"),
    "rateApp": MessageLookupByLibrary.simpleMessage("FoodList を評価"),
    "rateThisApp": MessageLookupByLibrary.simpleMessage("このアプリを評価する"),
    "readDate": MessageLookupByLibrary.simpleMessage("写真で読取"),
    "reminderTime": MessageLookupByLibrary.simpleMessage("通知時間"),
    "reset": MessageLookupByLibrary.simpleMessage("リセット"),
    "salmon": MessageLookupByLibrary.simpleMessage("サーモン"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveAndNext": MessageLookupByLibrary.simpleMessage("保存して続けて追加"),
    "scanBarcode": MessageLookupByLibrary.simpleMessage("バーコードをスキャン"),
    "scanBarcodeHint": MessageLookupByLibrary.simpleMessage(
      "バーコードを枠内に合わせてください",
    ),
    "searchHint": MessageLookupByLibrary.simpleMessage("食材を検索..."),
    "selectDate": MessageLookupByLibrary.simpleMessage("日付を選択"),
    "selectedTime": m9,
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "slideToDelete": MessageLookupByLibrary.simpleMessage("スライドして削除"),
    "soonThreshold": MessageLookupByLibrary.simpleMessage("「期限間近」の範囲"),
    "soonThresholdHint": MessageLookupByLibrary.simpleMessage(
      "この日数以内に期限が来る食材はオレンジ色で表示されます。",
    ),
    "soonThresholdValue": m10,
    "soybean": MessageLookupByLibrary.simpleMessage("大豆"),
    "specialThanksToAllContributorsBelow": MessageLookupByLibrary.simpleMessage(
      "以下のすべての貢献者に特別な感謝を！",
    ),
    "summaryExpired": MessageLookupByLibrary.simpleMessage("期限切れ"),
    "summaryExpiringSoon": MessageLookupByLibrary.simpleMessage("もうすぐ期限"),
    "summaryFresh": MessageLookupByLibrary.simpleMessage("新鮮"),
    "themeDark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "themeLight": MessageLookupByLibrary.simpleMessage("ライト"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("システムに合わせる"),
    "torch": MessageLookupByLibrary.simpleMessage("ライト"),
    "translationError": MessageLookupByLibrary.simpleMessage("翻訳エラー"),
    "translationErrorOfFoodlist": MessageLookupByLibrary.simpleMessage(
      "FoodListの翻訳エラー",
    ),
    "tuna": MessageLookupByLibrary.simpleMessage("マグロ"),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "urlCopiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "URLがクリップボードにコピーされました",
    ),
    "useOne": MessageLookupByLibrary.simpleMessage("使った"),
    "usedUp": m11,
    "vegetable": MessageLookupByLibrary.simpleMessage("野菜"),
    "versionVersion": m12,
    "whichDate": MessageLookupByLibrary.simpleMessage("どれが期限ですか？"),
  };
}
