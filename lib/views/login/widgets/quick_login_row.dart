import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/core/widgets/loading_button.dart';
import 'package:moe_wifi_gui/models/local_storage.dart';
import 'package:moe_wifi_gui/models/moe.dart';
import 'package:moe_wifi_gui/models/refresh_callback.dart';

class QuickLoginRow extends StatelessWidget {
  const QuickLoginRow({super.key});

  Future<void> loginFunction(BuildContext context) async {
    final currentUser = LocalStorage.getConfig('currentUser') ?? '';
    var message = '';
    if (currentUser == '') {
      message = 'No user selected.';
    } else {
      final password = LocalStorage.getPassword(currentUser) ?? '';
      if (password == '') {
        message = 'No such user exists.';
      } else {
        message = await Moe.login(currentUser, password)
            .timeout(const Duration(seconds: 5), onTimeout: () => 'Timed out.');
      }
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingButton(
            text: 'Login',
            icon: MediaQuery.sizeOf(context).width > 400
                ? const Icon(Icons.login_rounded)
                : null,
            color: CustomTheme.activeColor,
            onTap: () async {
              await refreshCallback().onError((e, trace) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              });
              if (context.mounted) {
                await loginFunction(context).onError((e, trace) {
                  if (e is ClientException && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Not connected to network.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
