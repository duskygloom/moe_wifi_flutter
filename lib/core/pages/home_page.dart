import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/core/widgets/appbar.dart';
import 'package:moe_wifi/core/widgets/sidebar.dart';
import 'package:moe_wifi/views/logout/pages/logout_page.dart';
import 'package:moe_wifi/views/login/pages/login_page.dart';
import 'package:moe_wifi/views/settings/pages/settings_page.dart';
import 'package:moe_wifi/views/users/pages/users_page.dart';
import 'package:moe_wifi/core/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    var body = IndexedStack(
      index: selected,
      children: [
        LoginPage.body,
        LogoutPage.body,
        UsersPage.body,
        SettingsPage.body,
      ],
    );
    var topbar = Appbar(index: selected);
    var navigationBar = BottomBar(
        selected: selected,
        onDestinationSelected: (index) {
          setState(() {
            selected = index;
          });
        });
    var sidebar = Sidebar(
        selected: selected,
        onDestinationSelected: (index) {
          setState(() {
            selected = index;
          });
        });
    return Scaffold(
      appBar: topbar,
      body: MediaQuery.sizeOf(context).width > CustomTheme.mobileWidth
          ? Row(children: [
              Expanded(child: body),
              sidebar,
            ])
          : body,
      bottomNavigationBar:
          MediaQuery.sizeOf(context).width > CustomTheme.mobileWidth
              ? null
              : navigationBar,
    );
  }
}
