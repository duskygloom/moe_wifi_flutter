import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/views/settings/widgets/settings_body.dart';

class SettingsPage {
  static Widget get body => const SettingsBody();

  static AppBar get appbar {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('Settings', style: CustomTheme.titleTextTheme),
    );
  }
}
