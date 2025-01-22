import 'package:flutter/material.dart';
import 'package:foodlist/generated/l10n.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import '../database/ingredient.dart';
import 'edit_subcategory_detail.dart';

class EditCategoryDetailPage extends StatefulWidget {
  const EditCategoryDetailPage({super.key});

  @override
  _EditCategoryDetailPageState createState() => _EditCategoryDetailPageState();
}

class _EditCategoryDetailPageState extends State<EditCategoryDetailPage> {
  final CategoryDataBase cdb = CategoryDataBase();
  List<String> catKeys = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await cdb.loadData();
    setState(() {
      catKeys = cdb.categoryKeys;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).editCategory),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > catKeys.length) {
              newIndex = catKeys.length;
            }
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            cdb.reorderCategory(oldIndex, newIndex);
            catKeys = cdb.categoryKeys;
          });
        },
        children: [
          for (int index = 0; index < catKeys.length; index++)
            Column(
              key: ValueKey(catKeys[index]),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditSubcategoryDetailPage(catKey: catKeys[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _showDeleteDialog(context, catKeys[index]);
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(cdb.categoryMap[catKeys[index]]!),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, catKeys[index]);
                          },
                        ),
                        ReorderableDragStartListener(
                          index: index,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.drag_handle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String catKey) {
    String catName = cdb.categoryMap[catKey]!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirmDelete),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).confirmCategoryDelete),
              const SizedBox(height: 8),
              Text(catName),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () {
                setState(() {
                  cdb.removeCategory(catKey);
                  catKeys = cdb.categoryKeys;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String catKey) {
    final TextEditingController controller =
        TextEditingController(text: cdb.categoryMap[catKey]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).editCategory),
          content: TextField(
            controller: controller,
            decoration:
                InputDecoration(hintText: S.of(context).enterNewCategoryName),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).save),
              onPressed: () {
                setState(() {
                  cdb.renameCategory(catKey, controller.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).addCategory),
          content: TextField(
            controller: controller,
            decoration:
                InputDecoration(hintText: S.of(context).enterNewCategoryName),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).save),
              onPressed: () {
                setState(() {
                  cdb.addCategory(controller.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
