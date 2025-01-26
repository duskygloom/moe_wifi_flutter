import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/views/login/widgets/login_body.dart';

class LoginPage {
  static Widget get body => const LoginBody();

  static AppBar get appbar {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Login', style: CustomTheme.titleTextTheme),
    );
  }
}
