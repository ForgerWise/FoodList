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

  static String m0(expireDate) => "消費期限: ${expireDate}";

  static String m1(todayItems, tomorrowItems) =>
      "今日まで: ${todayItems}\n明日まで: ${tomorrowItems}";

  static String m2(number) => "と ${number} 件のその他の食材";

  static String m3(selectedHour, selectedMinute) =>
      "選択した時間: ${selectedHour}:${selectedMinute}";

  static String m4(version) => "バージョン: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("このアプリについて"),
        "aboutContent": MessageLookupByLibrary.simpleMessage(
            "このアプリは、フードロスを減らすために作成されました。実際、廃棄される食品のほぼ半分は家庭で発生しています。そこで、ユーザーが生鮮食品の賞味期限を簡単に管理できるツールを提供します。私たちの目標は、不必要な購入を減らし、家庭での食品廃棄物を減少させることです。"),
        "aboutContentGithub": MessageLookupByLibrary.simpleMessage(
            "このアプリは完全にオープンソースで、無料で使用できます。ご意見やプロジェクトへの貢献がありましたら、GitHubリポジトリをご覧ください。"),
        "aboutContentHomepage": MessageLookupByLibrary.simpleMessage(
            "他のプロジェクトにご興味がある場合は、公式サイトをご覧ください。"),
        "aboutFoodlist": MessageLookupByLibrary.simpleMessage("FoodListについて"),
        "add": MessageLookupByLibrary.simpleMessage("追加"),
        "addCategory": MessageLookupByLibrary.simpleMessage("カテゴリを追加"),
        "addIngredients": MessageLookupByLibrary.simpleMessage("食材を追加する"),
        "addSubcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを追加"),
        "addToSubcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリに追加"),
        "apple": MessageLookupByLibrary.simpleMessage("リンゴ"),
        "bean": MessageLookupByLibrary.simpleMessage("豆類"),
        "beef": MessageLookupByLibrary.simpleMessage("牛肉"),
        "bugReport": MessageLookupByLibrary.simpleMessage("バグ報告"),
        "bugReportOfFoodlist":
            MessageLookupByLibrary.simpleMessage("FoodListのバグ報告"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "carrot": MessageLookupByLibrary.simpleMessage("ニンジン"),
        "catOrSubcatIsDelError": MessageLookupByLibrary.simpleMessage(
            "この食材のカテゴリまたはサブカテゴリが削除されているため、編集できません。この食材の内容を編集するには、食材を削除して再度追加してください。"),
        "categoriesResetHint":
            MessageLookupByLibrary.simpleMessage("カテゴリをデフォルトにリセットしますか？"),
        "category": MessageLookupByLibrary.simpleMessage("カテゴリ"),
        "chicken": MessageLookupByLibrary.simpleMessage("鶏肉"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "confirmCategoryDelete":
            MessageLookupByLibrary.simpleMessage("このカテゴリを削除してもよろしいですか？"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("削除を確認"),
        "confirmReset": MessageLookupByLibrary.simpleMessage("リセットを確認"),
        "confirmsubcategorydelete":
            MessageLookupByLibrary.simpleMessage("このサブカテゴリを削除してもよろしいですか？"),
        "contactUs": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
        "contributeCode": MessageLookupByLibrary.simpleMessage("コードに貢献"),
        "contributeTranslation": MessageLookupByLibrary.simpleMessage("翻訳に貢献"),
        "contributeTranslationOfFoodlist":
            MessageLookupByLibrary.simpleMessage("FoodListの翻訳に貢献"),
        "edit": MessageLookupByLibrary.simpleMessage("編集"),
        "editCategoriesNotSupportedHint":
            MessageLookupByLibrary.simpleMessage("カテゴリの編集機能はまだサポートされていません！"),
        "editCategory": MessageLookupByLibrary.simpleMessage("カテゴリを編集"),
        "editIngredients": MessageLookupByLibrary.simpleMessage("食材を編集する"),
        "editResetCategories":
            MessageLookupByLibrary.simpleMessage("カテゴリを編集/リセット"),
        "editSubategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを編集"),
        "editSubcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリを編集"),
        "egg": MessageLookupByLibrary.simpleMessage("卵"),
        "eggMilk": MessageLookupByLibrary.simpleMessage("卵と乳製品"),
        "emailCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("電子メールがクリップボードにコピーされました"),
        "enterNewCategoryName":
            MessageLookupByLibrary.simpleMessage("新しいカテゴリ名を入力"),
        "enterNewSubcategoryName":
            MessageLookupByLibrary.simpleMessage("新しいサブカテゴリ名を入力"),
        "entryDate": MessageLookupByLibrary.simpleMessage("入力日付"),
        "error": MessageLookupByLibrary.simpleMessage("エラー"),
        "example": MessageLookupByLibrary.simpleMessage("例"),
        "expireDate": MessageLookupByLibrary.simpleMessage("消費期限"),
        "expireDateConfirmMessage": m0,
        "faq": MessageLookupByLibrary.simpleMessage("よくある質問"),
        "faqHowToEditSubcategories":
            MessageLookupByLibrary.simpleMessage("サブカテゴリを編集する方法"),
        "faqHowToEditSubcategoriesAns": MessageLookupByLibrary.simpleMessage(
            "サブカテゴリを編集するには、編集したいカテゴリをタップしてください。その後、サブカテゴリ編集ページにリダイレクトされます。"),
        "faqWhatWillResetCategoriesDo":
            MessageLookupByLibrary.simpleMessage("カテゴリをリセットすると何が起こりますか？"),
        "faqWhatWillResetCategoriesDoAns": MessageLookupByLibrary.simpleMessage(
            "カテゴリをリセットすると、すべてのカテゴリとサブカテゴリがデフォルト値にリセットされます。"),
        "faqWhyEditNotLoad": MessageLookupByLibrary.simpleMessage(
            "なぜデータが自動的に編集ページにロードされなかったのですか？"),
        "faqWhyEditNotLoadAns": MessageLookupByLibrary.simpleMessage(
            "データ構造のため、以前に異なる言語で保存されたデータは自動的にロードされません。ただし、空の状態から編集を開始することはできます。"),
        "faqWhyNotificationDelay":
            MessageLookupByLibrary.simpleMessage("なぜ通知が遅れているのですか？"),
        "faqWhyNotificationDelayAns": MessageLookupByLibrary.simpleMessage(
            "バッテリー最適化設定やAndroidの制限により、一部のデバイスでは通知が遅れる場合があります。"),
        "faqWhyNotificationNotWork":
            MessageLookupByLibrary.simpleMessage("なぜ通知が機能していないのですか？"),
        "faqWhyNotificationNotWorkAns": MessageLookupByLibrary.simpleMessage(
            "デバイスの設定でアプリの通知が有効になっていることを確認してください。それでも動作しない場合は、バッテリー最適化設定を確認し、アプリのバッテリー最適化を無効にしてください。"),
        "feedback": MessageLookupByLibrary.simpleMessage("フィードバック"),
        "fish": MessageLookupByLibrary.simpleMessage("魚"),
        "foodlist": MessageLookupByLibrary.simpleMessage("FoodList"),
        "foodlistExpiryNotification":
            MessageLookupByLibrary.simpleMessage("FoodList 消費期限通知"),
        "foodlistExpiryNotificationContent": m1,
        "forgerwise": MessageLookupByLibrary.simpleMessage("ForgerWise"),
        "forgerwisesGithub":
            MessageLookupByLibrary.simpleMessage("ForgerWiseのGitHub"),
        "fruit": MessageLookupByLibrary.simpleMessage("果物"),
        "githubRepository": MessageLookupByLibrary.simpleMessage("GitHubリポジトリ"),
        "home": MessageLookupByLibrary.simpleMessage("ホーム"),
        "homepage": MessageLookupByLibrary.simpleMessage("公式サイト"),
        "languageNotSupportedYetMessage": MessageLookupByLibrary.simpleMessage(
            "この言語はまだサポートされていません！しかし、将来的にサポートされる予定です！"),
        "languages": MessageLookupByLibrary.simpleMessage("言語"),
        "meat": MessageLookupByLibrary.simpleMessage("肉類"),
        "mesOfBugReport": MessageLookupByLibrary.simpleMessage(
            "バグ: \n\nデバイス: \n\nOS: \n\nアプリバージョン: \n\n再現手順: \n\n*スクリーンショットがある場合は添付してください。\n\n*デバイスの部分の詳細資料がわからない場合は、スキップして書かなくでも大丈夫です。"),
        "mesOfContributeTrans": MessageLookupByLibrary.simpleMessage(
            "貢献したい言語: \n\n*新しい言語に貢献したい場合は、翻訳するファイルをお送りします。"),
        "mesOfTransError": MessageLookupByLibrary.simpleMessage(
            "言語: \n\n翻訳エラー: \n\n正しい翻訳: \n\n"),
        "milk": MessageLookupByLibrary.simpleMessage("牛乳"),
        "mushroom": MessageLookupByLibrary.simpleMessage("キノコ"),
        "none": MessageLookupByLibrary.simpleMessage("なし"),
        "notificationContent": MessageLookupByLibrary.simpleMessage(
            "通知を受け取りたい時間を設定してください。これにより、すぐに期限切れになるアイテムを知ることができます。"),
        "notificationContentWarn": MessageLookupByLibrary.simpleMessage(
            "一部のデバイスでは、バッテリー最適化設定や Android の制限により、通知が遅れる可能性があります。"),
        "notificationMoreItems": m2,
        "notificationSetting": MessageLookupByLibrary.simpleMessage("通知設定"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "officialWebsite": MessageLookupByLibrary.simpleMessage("公式サイト"),
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
        "privacyContent": MessageLookupByLibrary.simpleMessage(
            "このプライバシーポリシーは、当社のモバイルアプリケーション（以下「アプリ」といいます）が、あなたの情報を収集、使用、開示する方法について説明しています。アプリはユーザーのプライバシー保護を重視しています。当社のプライバシーポリシーは、あなたが共有することを決めた個人情報をどのように収集・使用するかを理解し、アプリを使用する際に十分な判断を行えるように設計されています。\n\nアプリを使用またはアクセスすることで、あなたはこのプライバシーポリシーに記載されている慣行に同意したものとみなされます。本ポリシーに同意しない場合は、アプリを使用しないでください。当社は、このポリシーを随時変更する権利を留保しており、頻繁にご確認ください。アプリの継続的な使用は、改訂されたプライバシーポリシーに同意したことを意味します。\n\n1. 収集データ\n現在、アプリは個人データを一切収集していません。アプリは、あなたの食品に関するすべてのデータをデバイス内に保存するよう設計されており、個人データを収集する機能はありません。\n\n2. データの保存と保護\nデータはあなたのデバイスに保存されており、デバイスの提供者やあなたが共有しない限り、他者がアクセスすることはできません。\n\n3. 将来の更新\n将来、同期機能などのためにユーザーデータのアップロード機能が追加された場合でも、この情報を第三者に開示することはありません。これらの機能が追加された際には、プライバシーポリシーの更新をお知らせします。\n\n4. プライバシーポリシーの変更\nアプリは、このポリシーおよびサービス利用規約をいつでも変更する権利を有します。当社は、あなたのアカウントに指定された主要な電子メールアドレスに通知を送信するか、当社サイトに目立つ通知を掲示することで、プライバシーポリシーの重要な変更をお知らせします。重要な変更は通知後30日以内に有効となります。軽微な変更や明確化は即時に有効となります。最新の情報を確認するために、サイトおよびこのプライバシーページを定期的に確認してください。"),
        "processedfood": MessageLookupByLibrary.simpleMessage("加工食品"),
        "rateThisApp": MessageLookupByLibrary.simpleMessage("このアプリを評価する"),
        "reset": MessageLookupByLibrary.simpleMessage("リセット"),
        "salmon": MessageLookupByLibrary.simpleMessage("サーモン"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "selectCategoryHint": MessageLookupByLibrary.simpleMessage("カテゴリを選択"),
        "selectDate": MessageLookupByLibrary.simpleMessage("日付を選択"),
        "selectSubcategoryHint":
            MessageLookupByLibrary.simpleMessage("サブカテゴリを選択"),
        "selectedTime": m3,
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "slideToDelete": MessageLookupByLibrary.simpleMessage("スライドして削除"),
        "soybean": MessageLookupByLibrary.simpleMessage("大豆"),
        "subcategory": MessageLookupByLibrary.simpleMessage("サブカテゴリ"),
        "subcategoryName": MessageLookupByLibrary.simpleMessage("サブカテゴリ名"),
        "subcategoryNameInputHint":
            MessageLookupByLibrary.simpleMessage("サブカテゴリ名を入力してください"),
        "translationError": MessageLookupByLibrary.simpleMessage("翻訳エラー"),
        "translationErrorOfFoodlist":
            MessageLookupByLibrary.simpleMessage("FoodListの翻訳エラー"),
        "tuna": MessageLookupByLibrary.simpleMessage("マグロ"),
        "urlCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("URLがクリップボードにコピーされました"),
        "vegetable": MessageLookupByLibrary.simpleMessage("野菜"),
        "versionVersion": m4
      };
}
