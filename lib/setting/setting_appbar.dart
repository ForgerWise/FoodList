import 'package:flutter/material.dart';

class SettingAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  const SettingAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(
          bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
      backgroundColor: Colors.blueGrey,
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 24)),
      centerTitle: true,
    );
  }
}
