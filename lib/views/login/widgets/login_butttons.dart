import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/models/moe.dart';
import 'package:moe_wifi/models/refresh_callback.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  Future<String> loginFunction() async {
    final currentUser = LocalStorage.currentUser;
    if (currentUser == '') {
      return 'No user selected.';
    } else {
      final password = LocalStorage.getPassword(currentUser);
      if (password == '') {
        return 'No such user exists.';
      } else {
        return await Moe.login(currentUser, password).timeout(
            Duration(milliseconds: LocalStorage.timeoutInMillis),
            onTimeout: () => 'Timed out.');
      }
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
              final route = LocalStorage.route.isEmpty
                  ? 'http://1.254.254.254'
                  : LocalStorage.route;
              await refreshCallback(route);
              final message = await loginFunction().onError((e, trace) {
                if (e is ClientException) {
                  return 'Not connected to network.';
                } else {
                  return 'Encountered an unhandled exception.';
                }
              });
              // say something about the process
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
