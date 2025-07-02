import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moe_wifi/core/widgets/appbar.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';
import 'package:moe_wifi/models/moe.dart';
import 'package:moe_wifi/views/settings/widgets/text_suggestion.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  // controllers
  final routeController = TextEditingController(text: LocalStorage.route);
  final timeoutController =
      TextEditingController(text: LocalStorage.timeoutInMillis.toString());
  final ipController = TextEditingController(text: LocalStorage.ip);
  final macController = TextEditingController(text: LocalStorage.mac);
  final codeController = TextEditingController(text: LocalStorage.sessCode);
  // focus nodes
  final routeFocus = FocusNode();
  final timeoutFocus = FocusNode();
  final ipFocus = FocusNode();
  final macFocus = FocusNode();
  final codeFocus = FocusNode();

  Map<String, String> urlParams = {};

  @override
  void initState() {
    super.initState();
    refresh().then((_) {});
  }

  Future<void> refresh() async {
    try {
      final url = await Moe.authUrl('http://1.254.254.254');
      final params = Uri.parse(url).queryParameters;
      if (LocalStorage.ip.isEmpty && params.containsKey('ip')) {
        urlParams['ip'] = params['ip']!;
      }
      if (LocalStorage.mac.isEmpty && params.containsKey('mac')) {
        urlParams['mac'] = params['mac']!;
      }
      if (LocalStorage.sessCode.isEmpty && params.containsKey('sc')) {
        urlParams['sc'] = params['sc']!;
      }
      setState(() {});
    } catch (e) {
      // do nothing
    }
  }

  @override
  void dispose() {
    // controllers
    routeController.dispose();
    timeoutController.dispose();
    ipController.dispose();
    macController.dispose();
    codeController.dispose();
    // focus nodes
    routeFocus.dispose();
    timeoutFocus.dispose();
    ipFocus.dispose();
    macFocus.dispose();
    codeFocus.dispose();
    super.dispose();
  }

  void saveFunction() {
    LocalStorage.route = routeController.text;
    LocalStorage.timeoutInMillis = int.tryParse(timeoutController.text) ?? 5000;
    LocalStorage.ip = ipController.text;
    LocalStorage.mac = macController.text;
    LocalStorage.sessCode = codeController.text;
  }

  @override
  Widget build(BuildContext context) {
    final widgets = [
      LoadingButton(
        text: 'Save',
        onTap: () async {
          saveFunction();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings saved.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    ];

    const routes = [
      'http://1.254.254.254',
      'http://detectportal.firefox.com',
      'http://connectivitycheck.gstatic.com',
    ];

    const double margin = 10;
    final size = MediaQuery.sizeOf(context);
    final bottomNavigationHeight =
        size.width > 600 ? 0 : kBottomNavigationBarHeight;
    final appbarHeight = Appbar.size.height;
    final minHeight =
        size.height - appbarHeight - bottomNavigationHeight - 4 * margin - 4;

    return RefreshIndicator(
      onRefresh: () async {
        await refresh();
        setState(() {});
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
        }),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextSuggestion(
                    controller: routeController,
                    suggestions: routes,
                    labelText: 'Route',
                    focusNode: routeFocus,
                    action: TextInputAction.next,
                    onEnterPress: () async {
                      timeoutFocus.requestFocus();
                    },
                  ),
                  TextInput(
                    labelText: 'Timeout (ms)',
                    controller: timeoutController,
                    focusNode: timeoutFocus,
                    action: TextInputAction.next,
                    onEnterPress: () async {
                      ipFocus.requestFocus();
                    },
                  ),
                  TextInput(
                    labelText: 'IP',
                    controller: ipController,
                    hintText: urlParams['ip'],
                    focusNode: ipFocus,
                    action: TextInputAction.next,
                    onEnterPress: () async {
                      macFocus.requestFocus();
                    },
                  ),
                  TextInput(
                    labelText: 'MAC',
                    controller: macController,
                    hintText: urlParams['mac'],
                    focusNode: macFocus,
                    action: TextInputAction.next,
                    onEnterPress: () async {
                      codeFocus.requestFocus();
                    },
                  ),
                  TextInput(
                    labelText: 'Code',
                    controller: codeController,
                    hintText: urlParams['sc'],
                    focusNode: codeFocus,
                    action: TextInputAction.done,
                    onEnterPress: () async {
                      saveFunction();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings saved.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const SizedBox(),
                  MediaQuery.sizeOf(context).width > 400
                      ? Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widgets,
                        )
                      : Column(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widgets,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
