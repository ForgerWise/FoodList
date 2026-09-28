import 'package:flutter/material.dart';
import '../util/theme.dart';

import '../database/category.dart';
import '../database/data.dart';
import '../generated/l10n.dart';
import '../util/app_scaffold.dart';
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
  // onReorderItem already gives the post-removal index.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      _cdb.reorderCategory(oldIndex, newIndex);
      _catKeys = List<String>.from(_cdb.categoryKeys);
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(S.of(context).editResetCategories),
        actions: [
          IconButton(
            icon: Icon(Icons.restore, color: context.c.textMuted),
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
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert, size: 16, color: context.c.accent),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).dragToReorderHint,
                        style: TextStyle(fontSize: 12, color: context.c.accent),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    buildDefaultDragHandles: false,
                    onReorderItem: _onReorder,
                    children: [
                      for (int i = 0; i < _catKeys.length; i++)
                        _buildCategoryCard(i),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
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
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 24)),
            ),
          ),
          title: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onTap: () => _showCategorySheet(
            context,
            editKey: key,
            currentName: label,
            currentIcon: icon,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: S.of(context).delete,
                icon: Icon(
                  Icons.delete_outline,
                  color: context.c.textMuted,
                  size: 20,
                ),
                onPressed: () => _showDeleteDialog(context, key),
              ),
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.drag_handle, color: context.c.textMuted),
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
        builder: (ctx, setSheet) => AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: SafeArea(
            top: false,
            child: Container(
              decoration: BoxDecoration(
                color: context.c.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
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
                        color: context.c.border,
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name field
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: S.of(ctx).categoryName,
                      labelStyle: TextStyle(color: context.c.accent),
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
                          color: context.c.accent,
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
                        onTap: () => setSheet(() => selectedEmoji = emoji),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : context.c.border,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? Border.all(color: AppColors.primary, width: 2)
                                : Border.all(color: context.c.border),
                          ),
                          child: Center(
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
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
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        final name = nameController.text.trim();
                        if (name.isEmpty) return;
                        setState(() {
                          if (editKey != null) {
                            _cdb.renameCategory(editKey, name);
                            _cdb.setCategoryIcon(editKey, selectedEmoji);
                          } else {
                            _cdb.addCategory(name, icon: selectedEmoji);
                          }
                          _catKeys = List<String>.from(_cdb.categoryKeys);
                        });
                        Navigator.pop(ctx);
                      },
                      child: Text(
                        S.of(context).save,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.delete_outline, color: AppColors.expired),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.expired.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.expired.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    getCategoryIcon(catKey),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    catName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(ctx).cancel,
              style: TextStyle(color: context.c.textMuted),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expired,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              _cdb.removeCategory(catKey);
              // Keep its items reachable instead of orphaning them.
              final target = _cdb.categoryMap.containsKey('others')
                  ? 'others'
                  : _cdb.categoryKeys.firstOrNull;
              if (target != null) {
                await InputDataBase().moveCategory(catKey, target);
              }
              if (!mounted) return;
              setState(() => _catKeys = List<String>.from(_cdb.categoryKeys));
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(
              S.of(ctx).confirm,
              style: const TextStyle(color: Colors.white),
            ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.restore, color: AppColors.soon),
            const SizedBox(width: 8),
            Text(S.of(ctx).confirmReset),
          ],
        ),
        content: Text(S.of(ctx).categoriesResetHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              S.of(ctx).cancel,
              style: TextStyle(color: context.c.textMuted),
            ),
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
