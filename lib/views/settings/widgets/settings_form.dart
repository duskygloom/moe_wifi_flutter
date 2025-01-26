import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/models/local_storage.dart';
import 'package:moe_wifi_gui/core/widgets/loading_button.dart';
import 'package:moe_wifi_gui/core/widgets/text_input.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  final configs = {
    'ip': TextEditingController(),
    'mac': TextEditingController(),
  };

  @override
  void dispose() {
    for (final controller in configs.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> applySettings() async {
    if (!formKey.currentState!.validate()) return;
    for (final config in configs.keys) {
      final value = configs[config]!.text;
      if (value.isNotEmpty) {
        LocalStorage.putConfig(config: config, value: value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var widgets = [
      LoadingButton(
        text: 'Apply',
        onTap: applySettings,
      ),
      const SizedBox(width: 10, height: 16),
      LoadingButton(
        text: 'Reset',
        icon: const Icon(Icons.restore_rounded),
        color: CustomTheme.activeColor,
        width: 40,
        borderRadius: 12,
        onTap: () async {
          for (final config in configs.keys) {
            LocalStorage.deleteConfig(config);
          }
        },
      ),
    ];
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'IP address',
            controller: configs['ip'] ?? TextEditingController(),
            isFocused: true,
            onEnterPress: applySettings,
          ),
          const SizedBox(height: 10),
          TextInput(
            hintText: 'MAC address',
            controller: configs['mac'] ?? TextEditingController(),
            onEnterPress: applySettings,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          )
        ],
      ),
    );
  }
}
