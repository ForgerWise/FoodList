import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/util/date_ocr.dart';

void main() {
  final now = DateTime(2026, 9, 28);
  List<DateTime> f(String s, [DateOrder o = DateOrder.dmy]) =>
      findDates(s, now: now, order: o);
  DateTime d(int y, int m, int day) => DateTime(y, m, day);

  test('Taiwan / Japan: year first', () {
    expect(f('有效日期 2026.10.05'), [d(2026, 10, 5)]);
    expect(f('賞味期限 2026年10月5日'), [d(2026, 10, 5)]);
    expect(f('賞味期限 26.10.05', DateOrder.ymd), [d(2026, 10, 5)]);
    expect(f('EXP 20261005'), [d(2026, 10, 5)]);
  });

  test('Europe / US: day-month order resolved or offered', () {
    expect(f('Best before 25.10.2026'), [d(2026, 10, 25)]);
    expect(f('EXP 10/25/2026'), [d(2026, 10, 25)]);
    // Ambiguous all-number dates follow the phone's region…
    expect(f('05/11/2026'), [d(2026, 11, 5)]); // Europe: 5 Nov
    // US reading "May 11" is months in the past → the other reading wins.
    expect(f('05/11/2026', DateOrder.mdy), [d(2026, 11, 5)]);
    expect(f('11/05/2026', DateOrder.mdy), [d(2026, 11, 5)]); // US: Nov 5
    expect(f('12/11/2026', DateOrder.mdy), [d(2026, 12, 11)]); // US: Dec 11
    expect(f('12/11/2026'), [d(2026, 11, 12)]); // Europe: 12 Nov
    // …unless only one reading is possible or plausible.
    expect(f('25/10/2026', DateOrder.mdy), [d(2026, 10, 25)]);
    // Two-digit years
    expect(f('26.10.05', DateOrder.ymd), [d(2026, 10, 5)]);
    expect(f('05.10.26'), [d(2026, 10, 5)]);
    expect(f('10.05.26', DateOrder.mdy), [d(2026, 10, 5)]);
    expect(f('BB 05 OCT 2026'), [d(2026, 10, 5)]);
    expect(f('USE BY OCT 05, 2026'), [d(2026, 10, 5)]);
    expect(f('EXP 11/2026'), [d(2026, 11, 30)]);
  });

  test('production + expiry: latest first', () {
    expect(f('製造日 2026.09.20\n有效日期 2027.03.20'), [
      d(2027, 3, 20),
      d(2026, 9, 20),
    ]);
  });

  test('OCR slips and noise', () {
    expect(f('EXP 2O26.1O.O5'), [d(2026, 10, 5)]);
    expect(f('Lot 4902220770199 Tel 03-1234-5678'), isEmpty);
    expect(f('1999.01.01'), isEmpty); // outside plausible window
    expect(f('2026.02.31'), isEmpty); // impossible date
  });
}
