import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/views/users/widgets/users_body.dart';

class UsersPage {
  static final refreshKey = GlobalKey<RefreshIndicatorState>();

  static Widget get body => UsersBody(refreshKey: refreshKey);

  static AppBar appbar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Users', style: CustomTheme.titleTextTheme),
    );
  }
}
