import 'package:flutter/material.dart';
import 'package:foodlist/setting/setting_appbar.dart';

import '../database/ingredient.dart';
import '../generated/l10n.dart';
import '../util/countdown_button.dart';
import 'edit_category_detail.dart';

class EditCategoriesPage extends StatefulWidget {
  const EditCategoriesPage({Key? key}) : super(key: key);

  @override
  EditCategoriesPageState createState() => EditCategoriesPageState();
}

class EditCategoriesPageState extends State<EditCategoriesPage> {
  final CategoryDataBase cdb = CategoryDataBase();

  @override
  void initState() {
    super.initState();
    cdb.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppbar(title: S.of(context).editResetCategories),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // * Edit Button (currently disabled)
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EditCategoryDetailPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: Text(S.of(context).edit,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // * Reset Button (red, with confirmation dialog)
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => _showConfirmationDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                      ),
                      child: Text(S.of(context).reset,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // * Confirmation dialog for reset button
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirmReset),
          content: Text(S.of(context).categoriesResetHint),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            CountdownButton(
              onPressed: () {
                Navigator.of(context).pop();
                final cdb = CategoryDataBase();
                cdb.resetIngredients();
              },
            ),
          ],
        );
      },
    );
  }
}
