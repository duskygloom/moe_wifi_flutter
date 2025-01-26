import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/views/logout/widgets/logout_body.dart';

class LogoutPage {
  static Widget get body => const LogoutBody();

  static AppBar get appbar {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Logout', style: CustomTheme.titleTextTheme),
    );
  }
}
