import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' as dom;

class Session {
  final String name;
  final int number;
  final String accountID;
  final String ratePlan;
  final DateTime startTime;
  final String upload;
  final String download;

  Session({
    required this.name,
    required this.number,
    required this.accountID,
    required this.ratePlan,
    required this.startTime,
    required this.upload,
    required this.download,
  });

  static Session fromRowElement(dom.Element row) {
    final table = row.getElementsByTagName('td');
    final tableText = List.generate(table.length, (index) {
      final text = table[index].text.trim();
      return text;
    });
    final startTime = DateTime.parse(tableText[4]);
    final onclick =
        row.getElementsByTagName('input').first.attributes['onclick'];
    final number = _parseInt(onclick ?? '');
    return Session(
      name: tableText[0],
      number: number,
      accountID: tableText[1],
      ratePlan: tableText[2],
      startTime: startTime,
      upload: tableText[6],
      download: tableText[7],
    );
  }

  String get startDateString {
    String s = '';
    s += startTime.day.toString().padLeft(2, '0');
    s += "/${startTime.month.toString().padLeft(2, '0')}";
    s += "/${startTime.year.toString().padLeft(4, '0')}";
    return s;
  }

  String get startTimeString {
    String s = '';
    s += startTime.hour.toString().padLeft(2, '0');
    s += ":${startTime.minute.toString().padLeft(2, '0')}";
    s += ":${startTime.second.toString().padLeft(2, '0')}";
    return s;
  }

  static bool _isDigit(String c) {
    if (c.length != 1) {
      throw Exception('Argument should be a character.');
    }
    return c.compareTo('0') >= 0 && c.compareTo('9') <= 0;
  }

  static int _parseInt(String text) {
    int n = 0;
    for (var i = 0; i < text.length; ++i) {
      if (_isDigit(text[i])) {
        n = 10 * n + text.codeUnitAt(i) - '0'.codeUnitAt(0);
      }
    }
    return n;
  }

  @override
  String toString() =>
      '🕑 $startTimeString\n📅 $startDateString\n⬆️ $upload\n⬇️ $download';

  void printSession() {
    if (kDebugMode) {
      print('Name: $name');
      print('Rate plan: $ratePlan');
      print('Account ID: $accountID');
      print('Start time: $startTime');
      print('Uploaded: $upload');
      print('Downloaded: $download');
    }
  }
}
