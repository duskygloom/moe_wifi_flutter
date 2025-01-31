import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/models/local_storage.dart';
import 'package:moe_wifi_gui/models/moe.dart';
import 'package:moe_wifi_gui/models/refresh_callback.dart';
import 'package:moe_wifi_gui/models/session.dart';
import 'package:moe_wifi_gui/views/logout/widgets/session_card.dart';

class LogoutBody extends StatefulWidget {
  const LogoutBody({super.key});

  @override
  State<LogoutBody> createState() => _LogoutBodyState();
}

class _LogoutBodyState extends State<LogoutBody> {
  List<Session> sessions = [];

  Future<void> refresh(BuildContext context) async {
    try {
      await refreshCallback();
      final currentUser = LocalStorage.getConfig('currentUser') ?? '';
      if (currentUser == '') {
        throw Exception('No user selected.');
      }
      final password = LocalStorage.getPassword(currentUser) ?? '';
      sessions = await Moe.getSessions(currentUser, password).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Timed out.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return [];
        },
      );
      setState(() {});
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh(context);
      },
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
                  refreshFunction: () async => await refresh(context),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
