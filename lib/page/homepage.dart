import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/data.dart';
import '../database/ingredient.dart';
import '../generated/l10n.dart';
import '../util/list_tile.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = InputDataBase();
  final _cdb = CategoryDataBase();
  bool _showFab = true;

  // Search & filter state
  bool _searchOpen = false;
  String _searchQuery = '';
  String _activeFilter = 'all'; // 'all' | 'expiringSoon' | 'expired' | cat key
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    // Check if INGREDIENTS_LIST key exists to distinguish first-run vs empty list
    final box = Hive.box('mybox');
    if (box.get('INGREDIENTS_LIST') == null) {
      await _myBox.createInitialData();
    }
    await _myBox.loadData();
    await _cdb.loadData();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _deleteItem(int filteredIndex) {
    final item = _filteredList[filteredIndex];
    final origIndex = _myBox.ingredientsList.indexOf(item);
    if (origIndex == -1) return;

    // Save a copy for undo
    final removedItem = List.from(item as List);

    setState(() {
      _myBox.ingredientsList.removeAt(origIndex);
    });
    _myBox.updateData();

    // Show SnackBar with undo action
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(S.of(context).itemDeleted(removedItem[1])),
          action: SnackBarAction(
            label: S.of(context).undo,
            onPressed: () {
              setState(() {
                _myBox.ingredientsList.insert(origIndex, removedItem);
              });
              _myBox.updateData();
            },
          ),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(12),
        ),
      );
  }

  // ── Filtering ──────────────────────────────────────────────────────────────
  List get _filteredList {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final threeDays = today.add(const Duration(days: 3));

    return _myBox.ingredientsList.where((item) {
      final String catKey = item[0] as String;
      final String name = item[1] as String;
      final String expStr = item[2] as String;

      // Search filter
      if (_searchQuery.isNotEmpty &&
          !name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }

      // Status filter
      if (_activeFilter != 'all') {
        DateTime? exp;
        try {
          exp = DateTime.parse(expStr.replaceAll('/', '-'));
        } catch (_) {}

        if (_activeFilter == 'expired') {
          if (exp == null ||
              !DateTime(exp.year, exp.month, exp.day).isBefore(today)) {
            return false;
          }
        } else if (_activeFilter == 'expiringSoon') {
          if (exp == null) return false;
          final expDay = DateTime(exp.year, exp.month, exp.day);
          if (expDay.isBefore(today) || !expDay.isBefore(threeDays)) {
            return false;
          }
        } else {
          // Category filter
          if (catKey != _activeFilter) return false;
        }
      }

      return true;
    }).toList();
  }

  // ── Stats ──────────────────────────────────────────────────────────────────
  Map<String, int> get _stats => _myBox.getStats();

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (n) {
        setState(() {
          if (n.direction == ScrollDirection.reverse) _showFab = false;
          if (n.direction == ScrollDirection.forward) _showFab = true;
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        appBar: _buildAppBar(),
        body: Column(
          children: [
            if (_searchOpen) _buildSearchBar(),
            _buildSummaryRow(),
            _buildFilterChips(),
            Expanded(child: _buildList()),
          ],
        ),
        floatingActionButton: _showFab
            ? FloatingActionButton.extended(
                backgroundColor: Colors.blueGrey,
                onPressed: () async {
                  await Navigator.pushNamed(context, '/add');
                  await _loadAll();
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(S.of(context).add,
                    style: const TextStyle(color: Colors.white)),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────────────────
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        S.of(context).foodlist,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(_searchOpen ? Icons.search_off : Icons.search,
              color: Colors.white),
          onPressed: () {
            setState(() {
              _searchOpen = !_searchOpen;
              if (!_searchOpen) {
                _searchQuery = '';
                _searchController.clear();
              } else {
                _searchFocusNode.requestFocus();
              }
            });
          },
        ),
      ],
    );
  }

  // ── Search bar ─────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: S.of(context).searchHint,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: Colors.white.withOpacity(0.15),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ── Summary row ────────────────────────────────────────────────────────────
  Widget _buildSummaryRow() {
    final stats = _stats;
    return Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      child: Row(
        children: [
          _summaryCard(
            stats['expired'] ?? 0,
            S.of(context).summaryExpired,
            const Color(0xFFD32F2F),
          ),
          const SizedBox(width: 8),
          _summaryCard(
            stats['expiringSoon'] ?? 0,
            S.of(context).summaryExpiringSoon,
            const Color(0xFFF57C00),
          ),
          const SizedBox(width: 8),
          _summaryCard(
            stats['fresh'] ?? 0,
            S.of(context).summaryFresh,
            const Color(0xFF388E3C),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(int count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: count > 0 ? color : Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Filter chips ───────────────────────────────────────────────────────────
  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterChip('all', S.of(context).filterAll, Icons.list_alt),
            const SizedBox(width: 6),
            _filterChip('expiringSoon', S.of(context).filterExpiringSoon,
                Icons.warning_amber_outlined),
            const SizedBox(width: 6),
            _filterChip('expired', S.of(context).filterExpired,
                Icons.error_outline),
            const SizedBox(width: 6),
            // Category chips
            ..._cdb.categoryKeys.map((key) {
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _filterChip(
                    key,
                    '${getCategoryIcon(key)} ${_cdb.categoryMap[key] ?? key}',
                    null),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String filterKey, String label, IconData? icon) {
    final bool selected = _activeFilter == filterKey;
    return GestureDetector(
      onTap: () => setState(() => _activeFilter = filterKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.blueGrey : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.blueGrey : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14,
                  color: selected ? Colors.white : Colors.grey.shade600),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── List ───────────────────────────────────────────────────────────────────
  Widget _buildList() {
    final items = _filteredList;

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🧊', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              S.of(context).noIngredients,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).noIngredientsHint,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 100),
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              verticalOffset: 40,
              child: FadeInAnimation(
                child: ListRifTile(
                  categoryKey: item[0] as String,
                  name: item[1] as String,
                  expdate: item[2] as String,
                  quantity: item[3] is int ? item[3] as int : 1,
                  deleteFunction: (_) => _deleteItem(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
