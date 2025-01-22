import 'package:flutter/material.dart';
import 'package:foodlist/database/sub_category.dart';
import 'package:foodlist/generated/l10n.dart';
import 'package:foodlist/setting/setting_appbar.dart';
import '../database/ingredient.dart';

class EditSubcategoryDetailPage extends StatefulWidget {
  final String catKey;
  const EditSubcategoryDetailPage({Key? key, required this.catKey})
      : super(key: key);

  @override
  EditSubcategoryDetailPageState createState() =>
      EditSubcategoryDetailPageState();
}

class EditSubcategoryDetailPageState extends State<EditSubcategoryDetailPage> {
  bool _isLoading = true;
  final CategoryDataBase cdb = CategoryDataBase();

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await cdb.loadData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    List<SubCategory> subCategories = cdb.subCategoryMap[widget.catKey] ?? [];
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).editSubcategory),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > subCategories.length) {
              newIndex = subCategories.length;
            }
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            cdb.reorderSubCategory(widget.catKey, oldIndex, newIndex);
            subCategories = cdb.subCategoryMap[widget.catKey] ?? [];
          });
        },
        children: [
          for (int index = 0; index < subCategories.length; index++)
            Column(
              key: ValueKey(subCategories[index].id),
              children: [
                ListTile(
                  title: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _showDeleteDialog(
                                context, widget.catKey, subCategories[index]);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(subCategories[index].name),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(
                              context, widget.catKey, subCategories[index]);
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

  void _showDeleteDialog(
      BuildContext context, String catKey, SubCategory subCat) {
    String subcatName = subCat.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirmDelete),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).confirmsubcategorydelete),
              const SizedBox(height: 8),
              Text(subcatName),
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
                  cdb.removeSubCategory(catKey, subCat.id);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
      BuildContext context, String catKey, SubCategory subCat) {
    final TextEditingController controller =
        TextEditingController(text: subCat.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).editSubategory),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: S.of(context).enterNewSubcategoryName),
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
                  cdb.renameSubCategory(catKey, subCat.id, controller.text);
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
          title: Text(S.of(context).addSubcategory),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: S.of(context).enterNewSubcategoryName),
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
                  cdb.addSubCategory(widget.catKey, controller.text);
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
