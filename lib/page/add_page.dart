import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/data.dart';
import '../database/food_catalog.dart';
import '../database/category.dart';
import '../generated/l10n.dart';
import '../util/app_scaffold.dart';
import '../util/barcode.dart';
import '../util/date_ocr.dart';
import '../util/list_tile.dart';
import '../util/review.dart';
import '../util/theme.dart';

// ---------------------------------------------------------------------------
// AddPage — pass an [Ingredient] as route argument to edit it.
// One screen, smart defaults:
//   1. tap a quick-pick (or scan / type)  → name, category, expiry filled in
//   2. tap Save
// ---------------------------------------------------------------------------
class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  static const _quickDays = [3, 7, 14, 30];

  String? _categoryKey;
  final TextEditingController _nameController = TextEditingController();
  DateTime? _dateTime;
  int _quantity = 1;
  Ingredient? _editing; // original item when editing
  String? _pendingBarcode; // remembered with the name on save
  bool _lookingUp = false;
  bool _dateTouched = false; // user chose a date by hand — don't override it

  final InputDataBase _idb = InputDataBase();
  final CategoryDataBase _cdb = CategoryDataBase();

  bool get _isEdit => _editing != null;
  DateTime get _today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  // New items start with a week, so Save works right away; a quick pick or
  // scan replaces it with a better guess.
  DateTime get _defaultDate => _today.add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _dateTime = _defaultDate;
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleArguments());
  }

  Future<void> _loadData() async {
    await _cdb.loadData();
    if (!mounted) return;
    setState(() {
      _categoryKey ??= _cdb.categoryKeys.isNotEmpty
          ? _cdb.categoryKeys.first
          : 'others';
    });
  }

  void _handleArguments() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Ingredient) {
      setState(() {
        _editing = args;
        _categoryKey = args.categoryKey;
        _nameController.text = args.name;
        _dateTime = args.expiry;
        _quantity = args.quantity;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────────
  void _applySuggestion(FoodSuggestion s) {
    setState(() {
      _nameController.text = s.name;
      if (_cdb.categoryMap.containsKey(s.categoryKey)) {
        _categoryKey = s.categoryKey;
      }
      if (s.days > 0) _dateTime = _today.add(Duration(days: s.days));
    });
    FocusScope.of(context).unfocus();
  }

  /// Typing a known food ("chicken") should give its shelf life too, not the
  /// generic default — same as tapping the chip.
  void _onNameChanged(String text) {
    final t = text.trim().toLowerCase();
    final match = t.isEmpty
        ? null
        : FoodCatalog.suggestions(
            query: t,
          ).where((s) => s.name.toLowerCase() == t).firstOrNull;
    setState(() {
      if (match == null) return;
      if (_cdb.categoryMap.containsKey(match.categoryKey)) {
        _categoryKey = match.categoryKey;
      }
      if (!_dateTouched && !_isEdit && match.days > 0) {
        _dateTime = _today.add(Duration(days: match.days));
      }
    });
  }

  Future<void> _scan() async {
    final code = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const BarcodeScanPage()),
    );
    if (code == null || !mounted) return;
    final info = parseScan(code);
    setState(() {
      _lookingUp = true;
      _pendingBarcode = info.cacheKey;
    });
    final hit = await lookupBarcode(info);
    if (!mounted) return;
    setState(() => _lookingUp = false);
    if (hit != null) _applySuggestion(hit);
    if (info.expiry != null) setState(() => _dateTime = info.expiry);

    final s = S.of(context);
    final message = hit == null
        ? (info.inStore ? s.inStoreBarcode : s.barcodeNotFound)
        : (info.expiry != null ? s.expiryFromBarcode : null);
    if (message != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  /// Photo of the printed date → OCR → set it (or let the user choose).
  Future<void> _readDateFromPhoto() async {
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    List<DateTime>? dates;
    try {
      dates = await readDatesWithCamera();
    } on PlatformException {
      messenger.showSnackBar(SnackBar(content: Text(s.ocrUnavailable)));
      return;
    }
    if (dates == null || !mounted) return; // cancelled
    if (dates.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(s.noDateFound)));
      return;
    }
    var picked = dates.first;
    if (dates.length > 1) {
      final choice = await showModalBottomSheet<DateTime>(
        context: context,
        showDragHandle: true,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s.whichDate, style: TextStyle(color: ctx.c.textMuted)),
              for (final d in dates!)
                ListTile(
                  title: Text(Ingredient.formatDate(d)),
                  trailing: Text(_daysText(d.difference(_today).inDays)),
                  onTap: () => Navigator.pop(ctx, d),
                ),
            ],
          ),
        ),
      );
      if (choice == null || !mounted) return;
      picked = choice;
    } else {
      messenger.showSnackBar(SnackBar(content: Text(s.dateFromPhoto)));
    }
    setState(() {
      _dateTime = picked;
      _dateTouched = true;
    });
  }

  void _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? _today,
      firstDate: DateTime(2000), // old items may be long expired
      lastDate: DateTime(_today.year + 100),
    );
    if (value != null) {
      setState(() {
        _dateTime = value;
        _dateTouched = true;
      });
    }
  }

  bool get _canConfirm =>
      _nameController.text.trim().isNotEmpty && _dateTime != null;

  Future<void> _save({bool addAnother = false}) async {
    final String name = _nameController.text.trim();
    final String catKey = _categoryKey ?? 'others';
    final item = Ingredient(catKey, name, _dateTime!, _quantity);

    await _idb.loadData();
    final idx = _editing == null ? -1 : _idb.indexOf(_editing!);
    if (idx != -1) {
      _idb.items[idx] = item;
    } else {
      _idb.items.add(item);
    }
    await _idb.updateData();

    // Learn shelf life only from new items: when editing, the remaining
    // days are not the product's shelf life.
    if (!_isEdit) {
      final days = _dateTime!.difference(_today).inDays;
      await FoodCatalog.remember(
        FoodSuggestion(catKey, name, days > 0 ? days : 1),
        barcode: _pendingBarcode,
      );
    }
    ReviewService.onItemSaved();
    if (!mounted) return;

    if (addAnother) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(S.of(context).itemAdded(name)),
            duration: const Duration(seconds: 2),
          ),
        );
      setState(() {
        _nameController.clear();
        _dateTime = _defaultDate;
        _dateTouched = false;
        _quantity = 1;
        _pendingBarcode = null;
      });
    } else {
      Navigator.pop(context, true);
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          _isEdit
              ? S.of(context).editIngredients
              : S.of(context).addIngredients,
        ),
        actions: [
          if (_isEdit)
            IconButton(
              tooltip: S.of(context).delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => Navigator.pop(context, 'delete'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              children: [
                _nameField(),
                const SizedBox(height: 16),
                _categoryChips(),
                const SizedBox(height: 12),
                if (!_isEdit) _suggestions(),
                const SizedBox(height: 16),
                _quantityRow(),
                const SizedBox(height: 16),
                _label(S.of(context).expireDate),
                const SizedBox(height: 8),
                _dateChips(),
              ],
            ),
          ),
          _bottomBar(),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: context.c.textMuted,
    ),
  );

  Widget _nameField() => TextField(
    controller: _nameController,
    onChanged: _onNameChanged,
    textInputAction: TextInputAction.done,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    decoration: InputDecoration(
      hintText: S.of(context).ingredientNameHint,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14, right: 8),
        child: Text(
          getCategoryIcon(_categoryKey ?? ''),
          style: const TextStyle(fontSize: 22),
        ),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: _lookingUp
          ? const Padding(
              padding: EdgeInsets.all(14),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : IconButton(
              tooltip: S.of(context).scanBarcode,
              icon: const Icon(Icons.qr_code_scanner, color: AppColors.primary),
              onPressed: _scan,
            ),
    ),
  );

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) => ChoiceChip(
    label: Text(label),
    selected: selected,
    onSelected: (_) => onTap(),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: selected ? Colors.white : context.c.text,
    ),
    side: BorderSide(color: selected ? AppColors.primary : context.c.border),
  );

  // One scrolling row (saves vertical space for date & quantity); the
  // selected chip is scrolled into view whenever it changes.
  final _selectedChipKey = GlobalKey();
  String? _scrolledTo;

  Widget _categoryChips() {
    if (_scrolledTo != _categoryKey) {
      _scrolledTo = _categoryKey;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _selectedChipKey.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            alignment: 0.5,
            duration: const Duration(milliseconds: 250),
          );
        }
      });
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final key in _cdb.categoryKeys)
            Padding(
              key: _categoryKey == key ? _selectedChipKey : null,
              padding: const EdgeInsets.only(right: 8),
              child: _chip(
                label:
                    '${getCategoryIcon(key)} ${_cdb.categoryMap[key] ?? key}',
                selected: _categoryKey == key,
                onTap: () => setState(() => _categoryKey = key),
              ),
            ),
        ],
      ),
    );
  }

  /// While typing: matches across all categories. Otherwise: the selected
  /// category's recent + common items.
  Widget _suggestions() {
    final query = _nameController.text;
    final t = query.trim().toLowerCase();
    // After picking (name equals a suggestion) keep showing the category's
    // list with the pick highlighted, instead of collapsing to one chip.
    final typed =
        t.isNotEmpty &&
        !FoodCatalog.suggestions(
          query: t,
        ).any((s) => s.name.toLowerCase() == t);
    final items = typed
        ? FoodCatalog.suggestions(query: query).take(12).toList()
        : FoodCatalog.suggestions(categoryKey: _categoryKey).take(8).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(S.of(context).quickPick),
            const SizedBox(height: 10),
            if (items.isEmpty)
              Text(
                S.of(context).noMatches,
                style: TextStyle(color: context.c.textMuted, fontSize: 13),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in items)
                    ActionChip(
                      avatar: typed
                          ? Text(getCategoryIcon(s.categoryKey))
                          : null,
                      label: Text(s.name),
                      onPressed: () => _applySuggestion(s),
                      backgroundColor: s.name == query.trim()
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : context.c.background,
                      side: BorderSide.none,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _dateChips() {
    final selectedDays = _dateTime?.difference(_today).inDays;
    final isCustom = _dateTime != null && !_quickDays.contains(selectedDays);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final d in _quickDays)
              _chip(
                label: S.of(context).daysChip(d),
                selected: selectedDays == d,
                onTap: () => setState(() {
                  _dateTime = _today.add(Duration(days: d));
                  _dateTouched = true;
                }),
              ),
            _chip(
              label: '📅 ${S.of(context).customDate}',
              selected: isCustom,
              onTap: _pickDate,
            ),
            _chip(
              label: '📷 ${S.of(context).readDate}',
              selected: false,
              onTap: _readDateFromPhoto,
            ),
          ],
        ),
        if (_dateTime != null) ...[
          const SizedBox(height: 10),
          Text(
            '${Ingredient.formatDate(_dateTime!)}  ·  ${_daysText(selectedDays!)}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: statusTextColor(
                context,
                Ingredient(_categoryKey ?? '', '', _dateTime!, 1).status,
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _daysText(int d) {
    if (d < 0) return S.of(context).expiredDaysAgo(-d);
    if (d == 0) return S.of(context).expiresToday;
    if (d == 1) return S.of(context).expiresTomorrow;
    return S.of(context).daysLeft(d);
  }

  Widget _quantityRow() => Row(
    children: [
      _label(S.of(context).quantity),
      const Spacer(),
      IconButton.filledTonal(
        onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
        icon: const Icon(Icons.remove),
      ),
      SizedBox(
        width: 48,
        child: Text(
          '$_quantity',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      IconButton.filledTonal(
        onPressed: () => setState(() => _quantity++),
        icon: const Icon(Icons.add),
      ),
    ],
  );

  Widget _bottomBar() => Container(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
    decoration: BoxDecoration(
      color: context.c.surface,
      border: Border(top: BorderSide(color: context.c.border)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: _canConfirm ? _save : null,
          child: Text(_isEdit ? S.of(context).save : S.of(context).add),
        ),
        if (!_isEdit)
          TextButton(
            onPressed: _canConfirm ? () => _save(addAnother: true) : null,
            child: Text(S.of(context).saveAndNext),
          ),
      ],
    ),
  );
}
