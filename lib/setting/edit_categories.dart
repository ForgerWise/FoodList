import 'package:flutter/material.dart';

import '../database/ingredient.dart';
import '../generated/l10n.dart';
import '../util/countdown_button.dart';

class EditCategoriesPage extends StatefulWidget {
  const EditCategoriesPage({Key? key}) : super(key: key);

  @override
  EditCategoriesPageState createState() => EditCategoriesPageState();
}

class EditCategoriesPageState extends State<EditCategoriesPage> {
  final CategoryDataBase _cdb = CategoryDataBase();
  List<String> _catKeys = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await _cdb.loadData();
    setState(() {
      _catKeys = List<String>.from(_cdb.categoryKeys);
      _isLoading = false;
    });
  }

  // ── Reorder ────────────────────────────────────────────────────────────────
  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > _catKeys.length) newIndex = _catKeys.length;
    if (newIndex > oldIndex) newIndex -= 1;
    setState(() {
      _cdb.reorderCategory(oldIndex, newIndex);
      _catKeys = List<String>.from(_cdb.categoryKeys);
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          S.of(context).editResetCategories,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore, color: Colors.red),
            tooltip: S.of(context).reset,
            onPressed: () => _showResetDialog(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Drag hint banner
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert,
                          size: 16, color: Colors.blueGrey.shade600),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).dragToReorderHint,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey.shade600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    padding:
                        const EdgeInsets.fromLTRB(12, 8, 12, 100),
                    buildDefaultDragHandles: false,
                    onReorder: _onReorder,
                    children: [
                      for (int i = 0; i < _catKeys.length; i++)
                        _buildCategoryCard(i),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        onPressed: () => _showCategorySheet(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          S.of(context).addCategory,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // ── Category card ──────────────────────────────────────────────────────────
  Widget _buildCategoryCard(int index) {
    final key = _catKeys[index];
    final icon = getCategoryIcon(key);
    final label = _cdb.categoryMap[key] ?? key;
    return Padding(
      key: ValueKey(key),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(icon,
                    style: const TextStyle(fontSize: 24))),
          ),
          title: Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined,
                    color: Colors.blueGrey.shade400, size: 20),
                onPressed: () => _showCategorySheet(
                  context,
                  editKey: key,
                  currentName: label,
                  currentIcon: icon,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 20),
                onPressed: () => _showDeleteDialog(context, key),
              ),
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.drag_handle,
                      color: Colors.grey.shade400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Bottom sheet: Add / Edit category ────────────────────────────────────
  void _showCategorySheet(
    BuildContext context, {
    String? editKey,
    String? currentName,
    String? currentIcon,
  }) {
    String selectedEmoji = currentIcon ?? '🏷️';
    final nameController = TextEditingController(text: currentName);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  editKey != null
                      ? S.of(ctx).editCategory
                      : S.of(ctx).addCategory,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Name field
                TextField(
                  controller: nameController,
                  autofocus: true,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: S.of(ctx).categoryName,
                    labelStyle:
                        TextStyle(color: Colors.blueGrey.shade400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueGrey, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Emoji section label
                Row(
                  children: [
                    Text(
                      S.of(ctx).icon,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Preview selected emoji
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        selectedEmoji,
                        key: ValueKey(selectedEmoji),
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Emoji grid
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kEmojiPresets.map((emoji) {
                    final isSelected = selectedEmoji == emoji;
                    return GestureDetector(
                      onTap: () =>
                          setSheet(() => selectedEmoji = emoji),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueGrey.withOpacity(0.15)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(
                                  color: Colors.blueGrey, width: 2)
                              : Border.all(
                                  color: Colors.grey.shade200),
                        ),
                        child: Center(
                          child: Text(emoji,
                              style: const TextStyle(fontSize: 24)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Confirm button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding:
                          const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final name = nameController.text.trim();
                      if (name.isEmpty) return;
                      setState(() {
                        if (editKey != null) {
                          _cdb.renameCategory(editKey, name);
                          // After rename, key changes — get the new key
                          final newKey = _cdb.categoryKeys.firstWhere(
                            (k) => _cdb.categoryMap[k] == name,
                            orElse: () => editKey,
                          );
                          _cdb.setCategoryIcon(newKey, selectedEmoji);
                        } else {
                          _cdb.addCategory(name,
                              icon: selectedEmoji);
                        }
                        _catKeys =
                            List<String>.from(_cdb.categoryKeys);
                      });
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      S.of(context).save,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Delete dialog ──────────────────────────────────────────────────────────
  void _showDeleteDialog(BuildContext context, String catKey) {
    final catName = _cdb.categoryMap[catKey] ?? catKey;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.delete_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(S.of(ctx).confirmDelete),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(ctx).confirmCategoryDelete),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: Colors.red.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Text(getCategoryIcon(catKey),
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(catName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(ctx).cancel,
                style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            onPressed: () {
              setState(() {
                _cdb.removeCategory(catKey);
                _catKeys = List<String>.from(_cdb.categoryKeys);
              });
              Navigator.pop(ctx);
            },
            child: Text(S.of(ctx).confirm,
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Reset dialog ───────────────────────────────────────────────────────────
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.restore, color: Colors.orange),
            const SizedBox(width: 8),
            Text(S.of(ctx).confirmReset),
          ],
        ),
        content: Text(S.of(ctx).categoriesResetHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(ctx).cancel,
                style: TextStyle(color: Colors.grey.shade600)),
          ),
          CountdownButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _cdb.resetIngredients();
                _catKeys = List<String>.from(_cdb.categoryKeys);
              });
            },
          ),
        ],
      ),
    );
  }
}
