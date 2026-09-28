import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../database/data.dart';
import '../database/category.dart';
import '../generated/l10n.dart';
import '../util/app_scaffold.dart';
import '../util/list_tile.dart';
import '../util/onboarding.dart';
import '../util/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = InputDataBase();
  final _cdb = CategoryDataBase();
  bool _showFab = true;

  bool _searchOpen = false;
  String _searchQuery = '';
  ExpiryStatus? _statusFilter;
  String? _categoryFilter;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAll().then((_) {
      if (mounted) showOnboardingIfNeeded(context);
    });
  }

  Future<void> _loadAll() async {
    await _db.loadData();
    await _cdb.loadData();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAdd([Ingredient? editing]) async {
    final result = await Navigator.pushNamed(
      context,
      '/add',
      arguments: editing,
    );
    await _loadAll();
    if (result == 'delete' && editing != null && mounted) {
      final i = _db.indexOf(editing);
      if (i != -1) _deleteItem(_db.items[i]); // same path as swipe → Undo works
    }
  }

  void _deleteItem(Ingredient item, {String? message}) {
    final origIndex = _db.items.indexOf(item);
    if (origIndex == -1) return;

    setState(() => _db.items.removeAt(origIndex));
    _db.updateData();

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message ?? S.of(context).itemDeleted(item.name)),
          action: SnackBarAction(
            label: S.of(context).undo,
            onPressed: () {
              setState(() => _db.items.insert(origIndex, item));
              _db.updateData();
            },
          ),
          duration: const Duration(seconds: 4),
        ),
      );
  }

  /// "Used one": quantity − 1, or remove (with Undo) when it was the last.
  void _consumeOne(Ingredient item) {
    if (item.quantity <= 1) {
      _deleteItem(item, message: S.of(context).usedUp(item.name));
      return;
    }
    final i = _db.items.indexOf(item);
    if (i == -1) return;
    final less = Ingredient(
      item.categoryKey,
      item.name,
      item.expiry,
      item.quantity - 1,
    );
    setState(() => _db.items[i] = less);
    _db.updateData();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(S.of(context).leftCount(item.name, less.quantity)),
          action: SnackBarAction(
            label: S.of(context).undo,
            onPressed: () {
              final j = _db.items.indexOf(less);
              if (j == -1) return;
              setState(() => _db.items[j] = item);
              _db.updateData();
            },
          ),
          duration: const Duration(seconds: 4),
        ),
      );
  }

  // ── Filtering ──────────────────────────────────────────────────────────────
  List<Ingredient> get _filteredList {
    final q = _searchQuery.toLowerCase();
    return _db.items.where((item) {
      if (q.isNotEmpty && !item.name.toLowerCase().contains(q)) return false;
      if (_categoryFilter != null && item.categoryKey != _categoryFilter) {
        return false;
      }
      if (_statusFilter != null && item.status != _statusFilter) return false;
      return true;
    }).toList();
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (n) {
        final show = n.direction == ScrollDirection.forward
            ? true
            : n.direction == ScrollDirection.reverse
            ? false
            : _showFab;
        if (show != _showFab) setState(() => _showFab = show);
        return false;
      },
      child: AppScaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildSummaryRow(),
            _buildCategoryChips(),
            Expanded(child: _buildList()),
          ],
        ),
        floatingActionButton: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: _showFab ? Offset.zero : const Offset(0, 2),
          child: FloatingActionButton.extended(
            onPressed: _openAdd,
            icon: const Icon(Icons.add),
            label: Text(
              S.of(context).add,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _searchOpen
          ? TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: S.of(context).searchHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
              ),
            )
          : Text(S.of(context).foodlist),
      actions: [
        IconButton(
          icon: Icon(_searchOpen ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            _searchOpen = !_searchOpen;
            if (!_searchOpen) {
              _searchQuery = '';
              _searchController.clear();
            }
          }),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Summary cards (also the status filter) ─────────────────────────────────
  Widget _buildSummaryRow() {
    final stats = _db.getStats();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          _summaryCard(
            ExpiryStatus.expired,
            stats[ExpiryStatus.expired]!,
            S.of(context).summaryExpired,
            AppColors.expired,
          ),
          const SizedBox(width: 8),
          _summaryCard(
            ExpiryStatus.soon,
            stats[ExpiryStatus.soon]!,
            S.of(context).summaryExpiringSoon,
            AppColors.soon,
          ),
          const SizedBox(width: 8),
          _summaryCard(
            ExpiryStatus.fresh,
            stats[ExpiryStatus.fresh]!,
            S.of(context).summaryFresh,
            AppColors.fresh,
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(ExpiryStatus key, int count, String label, Color color) {
    final selected = _statusFilter == key;
    final textColor = statusTextColor(context, key);
    return Expanded(
      child: Material(
        color: selected ? color.withValues(alpha: 0.14) : context.c.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _statusFilter = selected ? null : key),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? color : context.c.border,
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: count > 0 ? textColor : context.c.textMuted,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? textColor : context.c.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Category chips: only categories that currently have items ─────────────
  Widget _buildCategoryChips() {
    final used = _db.items.map((e) => e.categoryKey).toSet();
    final keys = _cdb.categoryKeys.where(used.contains).toList();
    // The filtered category may have just lost its last item.
    if (_categoryFilter != null &&
        (keys.length < 2 || !keys.contains(_categoryFilter))) {
      _categoryFilter = null;
    }
    if (keys.length < 2) return const SizedBox.shrink();
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        scrollDirection: Axis.horizontal,
        itemCount: keys.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final key = keys[i];
          final selected = _categoryFilter == key;
          return ChoiceChip(
            label: Text(
              '${getCategoryIcon(key)} ${_cdb.categoryMap[key] ?? key}',
            ),
            selected: selected,
            onSelected: (_) =>
                setState(() => _categoryFilter = selected ? null : key),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : context.c.text,
            ),
          );
        },
      ),
    );
  }

  // ── List ───────────────────────────────────────────────────────────────────
  Widget _buildList() {
    final items = _filteredList;

    if (items.isEmpty && _db.items.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).nothingMatches,
              style: TextStyle(fontSize: 16, color: context.c.textMuted),
            ),
            TextButton(
              onPressed: () => setState(() {
                _statusFilter = null;
                _categoryFilter = null;
                _searchOpen = false;
                _searchQuery = '';
                _searchController.clear();
              }),
              child: Text(S.of(context).clearFilters),
            ),
          ],
        ),
      );
    }

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🧊', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                S.of(context).noIngredients,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.c.text,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                S.of(context).noIngredientsHint,
                style: TextStyle(fontSize: 14, color: context.c.textMuted),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 4, bottom: 100),
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 250),
            child: SlideAnimation(
              verticalOffset: 24,
              child: FadeInAnimation(
                child: IngredientTile(
                  key: ObjectKey(item),
                  item: item,
                  onTap: () => _openAdd(item),
                  deleteFunction: (_) => _deleteItem(item),
                  consumeFunction: (_) => _consumeOne(item),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
