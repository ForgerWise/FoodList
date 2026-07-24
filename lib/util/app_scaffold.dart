import 'package:flutter/material.dart';

/// A Scaffold whose body avoids horizontal cutouts and the bottom system area.
///
/// App bars already consume the top system inset. Material navigation bars
/// manage their own bottom SafeArea, so the application shell keeps using the
/// regular [Scaffold].
class AppScaffold extends Scaffold {
  AppScaffold({
    super.key,
    super.backgroundColor,
    super.appBar,
    Widget? body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
  }) : super(body: body == null ? null : SafeArea(top: false, child: body));
}
