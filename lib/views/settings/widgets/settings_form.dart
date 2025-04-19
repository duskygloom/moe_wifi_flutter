import 'package:flutter/material.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';
import 'package:searchfield/searchfield.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  final routeController = TextEditingController(text: LocalStorage.route);
  late TextEditingController timeoutController;
  final ipController = TextEditingController(text: LocalStorage.ip);
  final macController = TextEditingController(text: LocalStorage.mac);
  final codeController = TextEditingController(text: LocalStorage.sessCode);

  @override
  void initState() {
    super.initState();
    final timeoutText = LocalStorage.timeoutInMillis.toString();
    timeoutController = TextEditingController(text: timeoutText);
  }

  @override
  void dispose() {
    routeController.dispose();
    ipController.dispose();
    macController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void saveFunction() {
    LocalStorage.route = routeController.text;
    LocalStorage.ip = ipController.text;
    LocalStorage.mac = macController.text;
    LocalStorage.sessCode = codeController.text;
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

    final routeMap = {
      for (var element in routes) element: SearchFieldListItem<String>(element)
    };

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: SearchField<String>(
              controller: routeController,
              suggestions: routeMap.values.toList(),
              selectedValue: routeMap[LocalStorage.route],
              onSubmit: (value) {
                ipFocus.requestFocus();
              },
              textInputAction: TextInputAction.next,
              searchInputDecoration: SearchInputDecoration(
                label: const Text('Route'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextInput(
            labelText: 'Timeout (ms)',
            controller: timeoutController,
          ),
          const SizedBox(height: 10),
          TextInput(
            labelText: 'IP',
            controller: ipController,
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
