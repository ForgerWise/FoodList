import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Asks for a Google Play rating at a happy moment (right after saving an
/// item), only for engaged users, and at most once per [_cooldown].
/// Google Play also silently rate-limits the dialog, so this may no-op.
class ReviewService {
  static const _minSaves = 5;
  static const _minDaysInstalled = 3;
  static const _cooldown = Duration(days: 90);

  static Future<void> markFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('review_first_open')) {
      await prefs.setInt(
        'review_first_open',
        DateTime.now().millisecondsSinceEpoch,
      );
    }
  }

  static Future<void> onItemSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saves = (prefs.getInt('review_saves') ?? 0) + 1;
    await prefs.setInt('review_saves', saves);

    final now = DateTime.now().millisecondsSinceEpoch;
    final first = prefs.getInt('review_first_open') ?? now;
    final last = prefs.getInt('review_last_ask') ?? 0;
    if (!shouldAsk(
      saves: saves,
      firstOpenMs: first,
      lastAskMs: last,
      nowMs: now,
    )) {
      return;
    }

    final review = InAppReview.instance;
    if (!await review.isAvailable()) return;
    await prefs.setInt('review_last_ask', now);
    await prefs.setInt('review_saves', 0);
    await review.requestReview();
  }

  static bool shouldAsk({
    required int saves,
    required int firstOpenMs,
    required int lastAskMs,
    required int nowMs,
  }) {
    const day = 86400000;
    return saves >= _minSaves &&
        nowMs - firstOpenMs >= _minDaysInstalled * day &&
        nowMs - lastAskMs >= _cooldown.inMilliseconds;
  }

  /// Settings "Rate us" — always opens the Play Store page.
  static Future<void> openStore() => InAppReview.instance.openStoreListing();
}
