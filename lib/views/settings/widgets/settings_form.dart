import 'package:flutter/material.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  final routeController =
      TextEditingController(text: LocalStorage.getConfig('route'));
  final ipController =
      TextEditingController(text: LocalStorage.getConfig('ip'));
  final macController =
      TextEditingController(text: LocalStorage.getConfig('mac'));
  final codeController =
      TextEditingController(text: LocalStorage.getConfig('code'));

  @override
  void dispose() {
    routeController.dispose();
    ipController.dispose();
    macController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void saveFunction() {
    LocalStorage.putConfig(config: 'route', value: routeController.text);
    LocalStorage.putConfig(config: 'ip', value: ipController.text);
    LocalStorage.putConfig(config: 'mac', value: macController.text);
    LocalStorage.putConfig(config: 'code', value: codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    final ipFocus = FocusNode();
    final macFocus = FocusNode();
    final codeFocus = FocusNode();

    final widgets = [
      LoadingButton(
        text: 'Save',
        onTap: () async {
          saveFunction();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Settings saved.'),
            behavior: SnackBarBehavior.floating,
          ));
        },
      ),
    ];

    const routes = [
      'http://1.254.254.254',
      'http://detectportal.firefox.com',
      'http://connectivitycheck.gstatic.com',
    ];

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownMenu(
            label: const Text('Route'),
            controller: routeController,
            width: 600,
            onSelected: (value) {
              ipFocus.requestFocus();
            },
            dropdownMenuEntries: routes.map((route) {
              return DropdownMenuEntry(label: route, value: route);
            }).toList(),
          ),
          const SizedBox(height: 10),
          TextInput(
            labelText: 'IP',
            controller: ipController,
            isObscure: true,
            focusNode: ipFocus,
            action: TextInputAction.next,
            onEnterPress: () async {
              macFocus.requestFocus();
            },
          ),
          const SizedBox(height: 10),
          TextInput(
            labelText: 'MAC',
            controller: macController,
            isObscure: true,
            focusNode: macFocus,
            action: TextInputAction.next,
            onEnterPress: () async {
              codeFocus.requestFocus();
            },
          ),
          const SizedBox(height: 10),
          TextInput(
            labelText: 'Code',
            controller: codeController,
            isObscure: true,
            focusNode: codeFocus,
            action: TextInputAction.done,
            onEnterPress: () async {
              saveFunction();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Settings saved.'),
                behavior: SnackBarBehavior.floating,
              ));
            },
          ),
          const SizedBox(height: 20),
          MediaQuery.sizeOf(context).width > 400
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                ),
        ],
      ),
    );
  }
}
