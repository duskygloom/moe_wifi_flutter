import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/models/moe.dart';

Future<void> refreshCallback(String route) async {
  await Moe.refreshCookie(route).timeout(
    Duration(milliseconds: LocalStorage.timeoutInMillis),
    onTimeout: () {
      throw Exception('Timed out.');
    },
  ).onError(
    (e, trace) {
      if (e is ClientException) {
        throw Exception('Not connected to network.');
      } else if (kDebugMode) {
        throw e.toString();
      } else {
        throw Exception('Something went wrong.');
      }
    },
  );
}
