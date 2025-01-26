import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/widgets/appbar.dart';
import 'package:moe_wifi_gui/core/widgets/sidebar.dart';
import 'package:moe_wifi_gui/views/logout/pages/logout_page.dart';
import 'package:moe_wifi_gui/views/login/pages/login_page.dart';
import 'package:moe_wifi_gui/views/settings/pages/settings_page.dart';
import 'package:moe_wifi_gui/views/users/pages/users_page.dart';
import 'package:moe_wifi_gui/core/widgets/bottom_bar.dart';

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
      body: MediaQuery.sizeOf(context).width > 600
          ? Row(
              children: [
                Expanded(child: body),
                sidebar,
              ],
            )
          : body,
      bottomNavigationBar:
          MediaQuery.sizeOf(context).width > 600 ? null : navigationBar,
    );
  }
}
