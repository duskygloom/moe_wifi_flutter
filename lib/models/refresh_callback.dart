import 'package:http/http.dart';
import 'package:moe_wifi/models/moe.dart';

Future<void> refreshCallback() async {
  await Moe.refreshCookie().timeout(
    const Duration(seconds: 5),
    onTimeout: () {
      throw Exception('Timed out');
    },
  ).onError(
    (e, trace) {
      if (e is ClientException) {
        throw Exception('Not connected to network.');
      }
    },
  );
}
