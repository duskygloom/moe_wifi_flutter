import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/views/logout/widgets/logout_body.dart';

class LogoutPage {
  static Widget get body => const LogoutBody();

  static AppBar appbar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Logout', style: CustomTheme.titleTextTheme),
    );
  }
}
