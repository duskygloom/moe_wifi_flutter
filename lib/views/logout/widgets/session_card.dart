import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/models/moe.dart';
import 'package:moe_wifi/models/session.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    this.session,
    required this.refreshFunction,
  });

  final Session? session;
  final Future<void> Function() refreshFunction;

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    if (session != null) {
      stackChildren.add(
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () async {
              if (session != null) {
                await Moe.terminateSession(session!.number);
                await refreshFunction();
              }
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      );
    }
    stackChildren.add(
      Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Container(
            child: session == null
                ? Text(
                    '-',
                    style: CustomTheme.titleTextTheme.copyWith(fontSize: 40),
                  )
                : Table(
                    columnWidths: const {
                      0: MaxColumnWidth(
                        FlexColumnWidth(1),
                        FixedColumnWidth(80),
                      ),
                      1: MaxColumnWidth(
                        FlexColumnWidth(1),
                        FixedColumnWidth(200),
                      ),
                    },
                    children: [
                      TableRow(children: [
                        const Icon(Icons.schedule),
                        Text(
                          session!.startTimeString,
                          style: CustomTheme.titleTextTheme,
                        ),
                      ]),
                      TableRow(children: [
                        const Icon(Icons.calendar_month),
                        Text(
                          session!.startDateString,
                          style: CustomTheme.titleTextTheme,
                        ),
                      ]),
                      TableRow(children: [
                        const Icon(Icons.upload),
                        Text(
                          session!.upload,
                          style: CustomTheme.titleTextTheme,
                        ),
                      ]),
                      TableRow(children: [
                        const Icon(Icons.download),
                        Text(
                          session!.download,
                          style: CustomTheme.titleTextTheme,
                        ),
                      ]),
                    ],
                  ),
            // Text(
            //     session.toString(),
            //     style: CustomTheme.titleTextTheme,
            //   ),
          ),
        ),
      ),
    );
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Card(
          child: Stack(
            children: stackChildren,
          ),
        ),
      ),
    );
  }
}

class SessionRow extends StatelessWidget {
  const SessionRow({super.key, required this.icon, required this.value});

  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Icon(icon),
        ),
        const SizedBox(width: 12),
        Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Text(
              value,
              style: CustomTheme.titleTextTheme,
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
