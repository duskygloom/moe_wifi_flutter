import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/core/widgets/appbar.dart';
import 'package:moe_wifi/models/local_storage.dart';

import 'package:moe_wifi/views/users/widgets/list_display.dart';

class UsersBody extends StatefulWidget {
  const UsersBody({super.key, required this.refreshKey});

  final GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  State<UsersBody> createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  var keys = LocalStorage.users;

  @override
  Widget build(BuildContext context) {
    var keys = LocalStorage.users;
    const double margin = 10;
    final size = MediaQuery.sizeOf(context);
    final bottomNavigationHeight =
        size.width > 600 ? 0 : kBottomNavigationBarHeight;
    final appbarHeight = Appbar.size.height;
    final minHeight =
        size.height - appbarHeight - bottomNavigationHeight - 4 * margin - 4;

    Future<void> refresh(BuildContext context) {
      setState(() {
        keys = LocalStorage.users;
      });
      return Future.delayed(const Duration(seconds: 1));
    }

    return RefreshIndicator(
      key: widget.refreshKey,
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
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                margin: const EdgeInsets.all(margin),
                padding: const EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                constraints: BoxConstraints(
                  maxWidth: 600,
                  minHeight: minHeight,
                ),
                child: LocalStorage.usersLength > 0
                    ? Column(
                        children: List<Widget>.generate(
                            2 * LocalStorage.usersLength - 1, (index) {
                        if (index % 2 == 0) {
                          return ListDisplay(
                            phone: keys[index ~/ 2],
                            refreshFunction: () async => refresh(context),
                          );
                        }
                        return const Divider(indent: 4, endIndent: 4);
                      }))
                    : Center(
                        child: Text(
                          '-',
                          style:
                              CustomTheme.titleTextTheme.copyWith(fontSize: 40),
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
