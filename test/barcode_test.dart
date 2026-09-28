import 'package:flutter_test/flutter_test.dart';
import 'package:foodlist/util/barcode.dart';

void main() {
  test('retail codes from any country normalise to EAN-13', () {
    expect(parseScan('4902220770199').gtin, '4902220770199'); // JP JAN
    expect(parseScan('049000028911').gtin, '0049000028911'); // US UPC-A
    expect(parseScan('4710018000102').gtin, '4710018000102'); // TW
    expect(parseScan('40111445').gtin, '40111445'); // EAN-8
    expect(parseScan('04902220770199').gtin, '4902220770199'); // GTIN-14
  });

  test('in-store (weighed) labels are recognised, keyed by item part', () {
    final a = parseScan('0212345012980'), b = parseScan('0212345034567');
    expect(a.inStore, isTrue);
    expect(a.gtin, isNull);
    expect(a.cacheKey, b.cacheKey); // same item, different price
    expect(parseScan('2123456789012').inStore, isTrue);
  });

  test('GS1 element string / DataMatrix carries expiry', () {
    final i = parseScan(']d2010490222077019917261031\x1d10ABC123');
    expect(i.gtin, '4902220770199');
    expect(i.expiry, DateTime(2026, 10, 31));
    expect(
      parseScan(
        '0104902220770199172611'
        '00',
      ).expiry,
      DateTime(2026, 11, 30),
    );
  });

  test('GS1 Digital Link QR', () {
    final i = parseScan('https://id.gs1.org/01/04902220770199/10/AB?17=270115');
    expect(i.gtin, '4902220770199');
    expect(i.expiry, DateTime(2027, 1, 15));
  });

  test('other codes become a personal memory key', () {
    final i = parseScan('https://example.com/menu');
    expect(i.gtin, isNull);
    expect(i.inStore, isFalse);
    expect(i.cacheKey, 'https://example.com/menu');
  });

  test('real Yahoo! Shopping titles are cleaned', () {
    expect(cleanShopTitle('コカ・コーラ 500ml 1セット（6本）'), 'コカ・コーラ 500ml');
    expect(
      cleanShopTitle('サントリー　天然水　２Ｌ　ペットボトル　１セット（２４本：６本×４ケース）'),
      'サントリー 天然水 2L ペットボトル',
    );
    expect(
      cleanShopTitle('ポイント3倍 サントリー 天然水 2L 2000ml ペットボトル 9本 1ケース 送料無'),
      'サントリー 天然水 2L 2000ml ペットボトル',
    );
    expect(
      cleanShopTitle('カルビー スナック菓子 選べる 2ケース 合計24個 セット まとめ買い'),
      'カルビー スナック菓子',
    );
  });

  test('shop titles are cleaned', () {
    expect(
      cleanShopTitle('【送料無料】明治 ミルクチョコレート 50g×10個 ケース'),
      '明治 ミルクチョコレート 50g',
    );
  });
}
