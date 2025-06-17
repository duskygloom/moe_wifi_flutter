import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/models/moe.dart';
import 'package:moe_wifi/models/refresh_callback.dart';
import 'package:moe_wifi/models/session.dart';
import 'package:moe_wifi/views/logout/widgets/session_card.dart';

class LogoutBody extends StatefulWidget {
  const LogoutBody({super.key});

  @override
  State<LogoutBody> createState() => _LogoutBodyState();
}

class _LogoutBodyState extends State<LogoutBody> {
  List<Session> sessions = [];

  Future<String> refresh() async {
    try {
      await refreshCallback('http://1.254.254.254');
      final currentUser = LocalStorage.currentUser;
      if (currentUser == '') {
        return 'No user selected.';
      }
      final password = LocalStorage.getPassword(currentUser);
      if (password == '') {
        return 'No such user exists.';
      }
      var message = '';
      sessions = await Moe.getSessions(currentUser, password).timeout(
        Duration(milliseconds: LocalStorage.timeoutInMillis),
        onTimeout: () {
          message = 'Timeout.';
          return [];
        },
      );
      setState(() {});
      return message;
    } catch (e) {
      return 'Encountered an unhandled exception.';
    }
  }

  @override
  Widget build(BuildContext context) {
    refreshFunction() async {
      final r = await refresh();
      if (r != '') {
        // something happened
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(r),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }

    return RefreshIndicator(
      onRefresh: refreshFunction,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.invertedStylus,
          },
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return SessionCard(
                  session: index < sessions.length ? sessions[index] : null,
                  refreshFunction: refreshFunction,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
