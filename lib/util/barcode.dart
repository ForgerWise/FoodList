import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../database/food_catalog.dart';
import '../generated/l10n.dart';

/// Full-screen camera; pops with the raw value of the first code it reads.
class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({super.key});

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  bool _done = false;
  double _zoom = 0;

  // All formats: EAN/UPC/JAN, GS1 QR & DataMatrix (can carry expiry dates),
  // Code128, ITF… Unknown ones still work as a personal "remember this" key.
  // 1080p + autoZoom lets small or distant barcodes read without moving closer
  // (the default 640×480 stream needs the phone almost touching the pack).
  final _controller = MobileScannerController(
    cameraResolution: const Size(1920, 1080),
    autoZoom: true,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          S.of(context).scanBarcode,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            tooltip: S.of(context).torch,
            icon: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, state, __) => Icon(
                state.torchState == TorchState.on
                    ? Icons.flashlight_on
                    : Icons.flashlight_off_outlined,
              ),
            ),
            onPressed: _controller.toggleTorch,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, box) => Stack(
          fit:
              StackFit.expand, // fill the screen even before the preview starts
          children: [
            GestureDetector(
              onTapUp: (d) => _controller.setFocusPoint(
                Offset(
                  d.localPosition.dx / box.maxWidth,
                  d.localPosition.dy / box.maxHeight,
                ),
              ),
              child: MobileScanner(
                controller: _controller,
                errorBuilder: (context, error) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.no_photography_outlined,
                          color: Colors.white70,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          S.of(context).cameraUnavailable,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: openAppSettings,
                          child: Text(S.of(context).openSettings),
                        ),
                      ],
                    ),
                  ),
                ),
                onDetect: (capture) {
                  final code = capture.barcodes.firstOrNull?.rawValue;
                  if (_done || code == null || code.isEmpty) return;
                  _done = true;
                  Navigator.pop(context, code);
                },
              ),
            ),
            IgnorePointer(
              child: Center(
                child: Container(
                  width: 280,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            // Scrim so the hint and zoom bar stay readable over bright scenes.
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 200,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Text(
                      S.of(context).scanBarcodeHint,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.zoom_out, color: Colors.white70),
                        Expanded(
                          child: Slider(
                            value: _zoom,
                            onChanged: (v) {
                              setState(() => _zoom = v);
                              _controller.setZoomScale(v);
                            },
                          ),
                        ),
                        const Icon(Icons.zoom_in, color: Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// Parsing
// ───────────────────────────────────────────────────────────────────────────

/// What a scanned code means for us.
class ScanInfo {
  /// GTIN normalised to EAN-13 (or 8/14 digits) — null if not a product code.
  final String? gtin;

  /// Expiry / best-before date encoded in GS1 QR, DataMatrix or Digital Link.
  final DateTime? expiry;

  /// Store-internal code (weighed fresh food etc.) — no database knows it.
  final bool inStore;

  /// Key used to remember the user's name for this code.
  final String cacheKey;

  const ScanInfo({
    this.gtin,
    this.expiry,
    this.inStore = false,
    required this.cacheKey,
  });
}

final _digits = RegExp(r'^\d+$');

ScanInfo parseScan(String raw) {
  var s = raw.trim();
  // AIM symbology identifier some scanners prepend, e.g. "]d2", "]Q3", "]C1".
  if (RegExp(r'^\][A-Za-z]\d').hasMatch(s)) s = s.substring(3);

  String? gtin;
  DateTime? expiry;

  final link = Uri.tryParse(s);
  if (link != null &&
      link.hasScheme &&
      RegExp(r'/01/\d{8,14}').hasMatch(link.path)) {
    // GS1 Digital Link: https://id.gs1.org/01/<gtin>/…?17=YYMMDD
    gtin = RegExp(r'/01/(\d{8,14})').firstMatch(link.path)!.group(1);
    expiry = _gs1Date(link.queryParameters['17'] ?? link.queryParameters['15']);
  } else if (_digits.hasMatch(s) && [8, 12, 13, 14].contains(s.length)) {
    gtin = s;
  } else if (s.startsWith('01') || s.contains('\x1d')) {
    final ai = _parseElementString(s);
    gtin = ai['01'];
    expiry = _gs1Date(ai['17'] ?? ai['15']);
  }

  if (gtin == null) {
    return ScanInfo(cacheKey: s.length > 200 ? s.substring(0, 200) : s);
  }

  gtin = _normaliseGtin(gtin);
  // GS1 restricted-circulation prefixes 02x, 04x, 2xx: in-store labels whose
  // tail encodes weight/price, so we remember the item part only.
  // ponytail: first 7 digits = prefix + 5-digit item code (JP/EU norm); some
  // chains use 4-digit item codes, which then just match less often.
  final inStore =
      gtin.length == 13 &&
      (gtin.startsWith('02') || gtin.startsWith('04') || gtin.startsWith('2'));
  return ScanInfo(
    gtin: inStore ? null : gtin,
    expiry: expiry,
    inStore: inStore,
    cacheKey: inStore ? 'store:${gtin.substring(0, 7)}' : gtin,
  );
}

/// UPC-A (12) → EAN-13; GTIN-14 with leading 0 → EAN-13.
String _normaliseGtin(String g) {
  if (g.length == 12) return '0$g';
  if (g.length == 14 && g.startsWith('0')) return g.substring(1);
  return g;
}

/// GS1 element string → {AI: value}. Fixed-length AIs are listed; variable
/// ones end at GS (0x1D).
Map<String, String> _parseElementString(String s) {
  const fixed = {
    '00': 18,
    '01': 14,
    '02': 14,
    '11': 6,
    '12': 6,
    '13': 6,
    '15': 6,
    '16': 6,
    '17': 6,
    '20': 2,
  };
  final out = <String, String>{};
  var i = 0;
  while (i + 2 <= s.length) {
    if (s[i] == '\x1d') {
      i++;
      continue;
    }
    final ai = s.substring(i, i + 2);
    i += 2;
    final len = fixed[ai];
    if (len != null) {
      if (i + len > s.length) break;
      out[ai] = s.substring(i, i + len);
      i += len;
    } else {
      // Variable length (10 batch, 21 serial, 3xxx …): skip to next GS.
      final end = s.indexOf('\x1d', i);
      if (end == -1) break;
      i = end + 1;
    }
  }
  return out;
}

/// GS1 YYMMDD; DD=00 means last day of month.
DateTime? _gs1Date(String? v) {
  if (v == null || !RegExp(r'^\d{6}$').hasMatch(v)) return null;
  final y = 2000 + int.parse(v.substring(0, 2));
  final m = int.parse(v.substring(2, 4));
  final d = int.parse(v.substring(4, 6));
  if (m < 1 || m > 12 || d > 31) return null;
  return d == 0 ? DateTime(y, m + 1, 0) : DateTime(y, m, d);
}

// ───────────────────────────────────────────────────────────────────────────
// Lookup
// ───────────────────────────────────────────────────────────────────────────

/// Yahoo!ショッピング Client ID, injected at build time so it is not in the
/// public repo: put it in dart_defines.json (git-ignored) and build with
/// `--dart-define-from-file=dart_defines.json`.
/// Terms: non-commercial use; show "Web Services by Yahoo! JAPAN" (done on
/// the About page and must be on the Play Store listing).
const _yahooAppId = String.fromEnvironment('YAHOO_JP_APPID');

/// Local memory first (instant, offline, covers anything the user named
/// before), then public databases. Returns null when nobody knows it.
/// `days` is 0 because shelf life of packaged goods is printed, not known.
Future<FoodSuggestion?> lookupBarcode(ScanInfo info) async {
  final cached = FoodCatalog.cachedBarcode(info.cacheKey);
  if (cached != null) return cached;
  final gtin = info.gtin;
  if (gtin == null) return null;

  final lang = Intl.getCurrentLocale().split('_').first; // en / zh / ja
  final japanese = gtin.startsWith('45') || gtin.startsWith('49');
  final sources = [
    if (japanese) () => _yahooJapan(gtin),
    () => _openFoodFacts(gtin, lang),
    if (!japanese) () => _yahooJapan(gtin), // imports sold in Japan
  ];
  for (final source in sources) {
    final hit = await source();
    if (hit != null) return hit;
  }
  return null;
}

Future<dynamic> _getJson(
  Uri uri, {
  String userAgent = 'FoodList-Android (github.com/ForgerWise)',
}) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 6);
  try {
    final req = await client.getUrl(uri);
    req.headers.set('User-Agent', userAgent);
    final res = await req.close().timeout(const Duration(seconds: 8));
    if (res.statusCode != 200) return null;
    return jsonDecode(await res.transform(utf8.decoder).join());
  } catch (_) {
    return null; // offline / timeout — user just types the name
  } finally {
    client.close();
  }
}

/// Open Food Facts — ODbL, attribution on the About page. Strong in Europe
/// and the US (USDA branded foods), partial in Taiwan/Japan.
Future<FoodSuggestion?> _openFoodFacts(String gtin, String lang) async {
  final json = await _getJson(
    Uri.parse(
      'https://world.openfoodfacts.org/api/v2/product/$gtin.json'
      '?fields=product_name,product_name_$lang,product_name_en,categories_tags',
    ),
  );
  final p = json?['product'];
  if (json?['status'] != 1 || p == null) return null;

  // App language first, then the product's own main name, then English.
  final String name =
      [p['product_name_$lang'], p['product_name'], p['product_name_en']]
          .firstWhere(
            (n) => n is String && n.trim().isNotEmpty,
            orElse: () => '',
          )
          .trim();
  if (name.isEmpty) return null;
  final tags = (p['categories_tags'] as List?)?.join(' ') ?? '';
  return FoodSuggestion(_guessCategory(tags), name, 0);
}

/// Yahoo!ショッピング item search by JAN — best coverage for Japan.
Future<FoodSuggestion?> _yahooJapan(String gtin) async {
  if (_yahooAppId.isEmpty) return null;
  // Yahoo 403s without this UA, and rejects appid in both UA and query.
  final json = await _getJson(
    Uri.https('shopping.yahooapis.jp', '/ShoppingWebService/V3/itemSearch', {
      'jan_code': gtin,
      'results': '5',
    }),
    userAgent: 'Yahoo AppID: $_yahooAppId',
  );
  final hits = json?['hits'] as List?;
  if (hits == null || hits.isEmpty) return null;
  final names = [
    for (final h in hits) cleanShopTitle(h['name'] as String? ?? ''),
  ]..removeWhere((n) => n.isEmpty);
  if (names.isEmpty) return null;
  names.sort((a, b) => a.length.compareTo(b.length)); // shortest = least noise
  return FoodSuggestion('processedfood', names.first, 0);
}

/// Shop listings look like "【送料無料】明治 ミルクチョコレート 50g×10個 ケース".
/// Strip bracketed promos and pack-size tails.
String cleanShopTitle(String t) {
  // Full-width ASCII (２Ｌ, １セット) and ideographic spaces → half-width.
  var s = String.fromCharCodes(
    t.runes.map(
      (c) => c == 0x3000 ? 0x20 : (c >= 0xFF01 && c <= 0xFF5E ? c - 0xFEE0 : c),
    ),
  );
  s = s
      // bracketed promos / pack notes: 【送料無料】 (6本) ［公式］
      .replaceAll(
        RegExp(r'【[^】]*】|［[^］]*］|\[[^\]]*\]|＜[^＞]*＞|<[^>]*>|（[^）]*）|\([^)]*\)'),
        ' ',
      );
  s = s.split(RegExp(r'\s*[×xX＊*]\s*\d')).first; // "…50g×10個" → "…50g"
  s = s
      // shop words
      .replaceAll(
        RegExp(
          r'送料\S*|まとめ買い|箱買い|ケース販売|あす楽|ポイント\S*|\d+倍|'
          r'イチオシ|選べる|食べ比べ|詰め合わせ|アソート|お買い得|公式|'
          r'計\d+\S*|合計\S*',
        ),
        ' ',
      )
      // pack counts: 9本 1ケース 1箱 1セット 24個 12袋 6本入
      .replaceAll(
        RegExp(r'(?<![\w.])\d*\s*(本入り?|個入り?|袋入り?|本|個|袋|箱|ケース|セット|パック)(?=\s|$)'),
        ' ',
      )
      .replaceAll(RegExp(r'(?<=\s|^)(セット|ケース|入り?)(?=\s|$)'), ' ');
  return s.replaceAll(RegExp(r'\s+'), ' ').trim();
}

String _guessCategory(String tags) {
  const rules = {
    'fish': ['seafood', 'fishes', 'fish'],
    'meat': ['meats', 'meat', 'sausages', 'hams'],
    'eggMilk': ['dairies', 'milks', 'cheeses', 'yogurts', 'eggs'],
    'mushroom': ['mushrooms'],
    'bean': ['tofu', 'soy', 'legumes'],
    'fruit': ['fruits'],
    'vegetable': ['vegetables'],
  };
  for (final r in rules.entries) {
    if (r.value.any((w) => tags.contains('en:$w'))) return r.key;
  }
  return 'processedfood';
}
