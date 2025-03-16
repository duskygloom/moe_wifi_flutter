import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/views/settings/widgets/settings_body.dart';

class SettingsPage {
  static Widget get body => const SettingsBody();

  static AppBar appbar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Settings', style: CustomTheme.titleTextTheme),
    );
  }
}
