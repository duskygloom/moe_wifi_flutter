import 'package:flutter/material.dart';
import 'package:moe_wifi/views/logout/pages/logout_page.dart';
import 'package:moe_wifi/views/login/pages/login_page.dart';
import 'package:moe_wifi/views/settings/pages/settings_page.dart';
import 'package:moe_wifi/views/users/pages/users_page.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        LoginPage.appbar(context),
        LogoutPage.appbar(context),
        UsersPage.appbar(context),
        SettingsPage.appbar(context),
      ],
    );
  }

  static Size get size => AppBar().preferredSize;

  @override
  Size get preferredSize => size;
}
