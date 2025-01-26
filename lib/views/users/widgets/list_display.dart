import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moe_wifi_gui/models/local_storage.dart';

class ListDisplay extends StatelessWidget {
  const ListDisplay({super.key, this.phone, this.refreshFunction});

  final String? phone;
  final Future<void> Function()? refreshFunction;

  @override
  Widget build(BuildContext context) {
    if (phone == null) {
      return Container(
          padding: const EdgeInsets.only(left: 8, right: 2),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    '-',
                    maxLines: 1,
                    style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Text(
                    '-',
                    maxLines: 1,
                    style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                  )),
            ],
          ));
    }

    final currentUser = LocalStorage.getConfig('currentUser');
    final password = LocalStorage.getPassword(phone ?? '') ?? '';
    final hiddenPassword = '*' * password.length;

    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 2),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  phone ?? '',
                  maxLines: 1,
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                )),
            const SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: Text(
                  hiddenPassword,
                  maxLines: 1,
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                )),
            IconButton(
              onPressed: () async {
                LocalStorage.putConfig(
                  config: 'currentUser',
                  value: phone ?? '',
                );
                if (refreshFunction != null) {
                  await refreshFunction!();
                }
              },
              icon: Icon(
                Icons.check_rounded,
                color: currentUser == phone ? Colors.green : null,
              ),
            ),
            IconButton(
              onPressed: () async {
                LocalStorage.deleteUser(phone ?? '');
                if (refreshFunction != null) {
                  await refreshFunction!();
                }
              },
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ));
  }
}
