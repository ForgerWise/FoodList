import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/util/review.dart';

void main() {
  const day = 86400000;
  const now = 100 * day;
  bool ask(int saves, int installedDays, int lastAskDaysAgo) =>
      ReviewService.shouldAsk(
        saves: saves,
        firstOpenMs: now - installedDays * day,
        lastAskMs: lastAskDaysAgo < 0 ? 0 : now - lastAskDaysAgo * day,
        nowMs: now,
      );

  test('review prompt gating', () {
    expect(ask(5, 3, -1), isTrue); // engaged, never asked
    expect(ask(4, 30, -1), isFalse); // not enough saves
    expect(ask(10, 2, -1), isFalse); // installed too recently
    expect(ask(10, 99, 30), isFalse); // asked 30 days ago
    expect(ask(10, 99, 90), isTrue); // cooldown over
  });
}
