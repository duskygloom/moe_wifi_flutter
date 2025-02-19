import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/views/login/widgets/login_body.dart';

class LoginPage {
  static Widget get body => const LoginBody();

  static AppBar appbar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Login', style: CustomTheme.titleTextTheme),
    );
  }
}
