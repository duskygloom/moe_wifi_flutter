import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/views/settings/widgets/settings_form.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    const contentWidth = 800;
    final appWidth = MediaQuery.sizeOf(context).width;
    final appHeight = MediaQuery.sizeOf(context).height;
    final totalPadding = appWidth > contentWidth ? appWidth - contentWidth : 40;

    var content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: totalPadding / 2,
        vertical: 20,
      ),
      child: const SettingsForm(),
    );

    if (appWidth <= CustomTheme.mobileWidth && appHeight < 472) {
      return SingleChildScrollView(child: content);
    } else if (appHeight < 392) {
      return SingleChildScrollView(child: content);
    } else {
      return content;
    }
  }
}
