import 'package:flutter/material.dart';

import '../database/ingredient.dart';
import '../generated/l10n.dart';

class EditCategoriesPage extends StatelessWidget {
  EditCategoriesPage({Key? key}) : super(key: key);
  final snackBar = SnackBar(
    content: Text(S.current.editCategoriesNotSupportedHint),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        backgroundColor: Colors.blueGrey,
        title: Text(S.of(context).editResetCategories,
            style: const TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: Center(
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
                  // * Show a snackbar when pressed
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text(S.of(context).edit,
                      style: const TextStyle(color: Colors.black)),
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(S.of(context).cancel,
                  style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // * Reset the ingredients
                final CDB = CategoryDataBase();
                CDB.resetIngredients();
              },
              child: Text(S.of(context).confirm,
                  style: TextStyle(
                      color: Colors.red[400], fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
