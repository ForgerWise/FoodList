// This file is kept for backward compatibility but subcategories have been
// removed in the redesign. The page is no longer accessible from the UI.
import 'package:flutter/material.dart';

class EditSubcategoryDetailPage extends StatelessWidget {
  final String catKey;
  const EditSubcategoryDetailPage({Key? key, required this.catKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.shrink());
  }
}
