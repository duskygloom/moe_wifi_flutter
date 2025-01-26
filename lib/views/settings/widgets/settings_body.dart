import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/views/settings/widgets/settings_form.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    const content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SettingsForm(),
        ),
        SizedBox(height: 40),
      ],
    );
    return MediaQuery.sizeOf(context).height < 600
        ? const SingleChildScrollView(
            child: content,
          )
        : content;
  }
}
