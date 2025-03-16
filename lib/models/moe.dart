import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/models/session.dart';

class Moe {
  static const baseURL = 'http://122.252.242.93';

  static String get route =>
      LocalStorage.getConfig('route') ?? 'http://1.254.254.254';

  static const endpoints = {
    'login': '$baseURL/userportal/newlogin.do',
    'logout': '$baseURL/userportal/logout.do',
    'home': '$baseURL/userportal/home.do'
  };

  static String get cookie => LocalStorage.getConfig('cookie') ?? '';

  static const String useragent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0';

  static Future<http.Response> request({
    required String method,
    required String url,
    bool sendCookies = true,
    bool followRedirects = false,
    Map<String, dynamic>? query,
  }) async {
    var uri = Uri.parse(url);
    if (query != null) {
      uri = uri.replace(queryParameters: query);
    }
    var request = http.Request(method, uri)..followRedirects = followRedirects;
    if (sendCookies) request.headers['cookie'] = Moe.cookie;
    request.headers['user-agent'] = Moe.useragent;
    final stream = await request.send();
    return http.Response.fromStream(stream);
  }

  static Future<String> _authURL() async {
    // if ip, mac and sc are in localstorage, use them
    final configIP = LocalStorage.getConfig('ip') ?? '';
    final configMAC = LocalStorage.getConfig('mac') ?? '';
    final configCode = LocalStorage.getConfig('code') ?? '';
    if (configIP.isNotEmpty && configMAC.isNotEmpty && configCode.isNotEmpty) {
      return Uri.http(baseURL, '/userportal/', {
        'requestURI': '$route/?',
        'ip': configIP,
        'mac': configMAC,
        'nas': 'santiniketan',
        'requestip': route,
        'sc': configCode,
        'interface': 'cpeth1',
      }).toString();
    }
    // else get URL from redirection
    final response = await Moe.request(
      method: 'GET',
      url: route,
      followRedirects: true,
    );
    final soup = html.parse(response.body);
    for (final tag in soup.getElementsByTagName('meta')) {
      final attributes = tag.attributes;
      if (attributes['http-equiv'] == 'Refresh') {
        const prefix = '1;URL=';
        final content = attributes['content'] ?? '';
        if (content.startsWith(prefix)) {
          return content.substring(prefix.length);
        }
      }
    }
    // not found
    throw Exception('Failed to fetch auth URL from route: ${Moe.route}');
  }

  static Future<void> refreshCookie() async {
    final authURL = await _authURL();
    if (kDebugMode) {
      print('URL: $authURL');
    }
    final response = await Moe.request(
      method: 'GET',
      url: authURL,
      sendCookies: false,
    );
    final String cookie = response.headers['set-cookie'] ?? '';
    LocalStorage.putConfig(config: 'cookie', value: cookie);
  }

  static Future<String> login(String phone, String password) async {
    final response = await Moe.request(
      method: 'POST',
      url: endpoints['login'] ?? '',
      query: {
        'username': phone,
        'password': password,
        'phone': '0',
        'type': '2',
        'jsonresponse': '1',
        'checkbox': 'check',
      },
    );
    final json = jsonDecode(response.body);
    final errorMessage = json['errorMessage'];
    if (errorMessage == null) {
      return json['errorKey'] ?? 'No error message.';
    } else if (json['errorKey'] == 'success') {
      return 'Successfully connected.';
    }
    return errorMessage.toString().endsWith('.')
        ? errorMessage.toString()
        : '$errorMessage.';
  }

  static Future<void> logout() async {
    await Moe.request(method: 'POST', url: endpoints['logout'] ?? '');
  }

  static Future<List<Session>> getSessions(
      String phone, String password) async {
    await Moe.request(
      method: 'POST',
      url: endpoints['login'] ?? '',
      query: {
        'generatePassword': 'true',
        'phone': '0',
        'type': '1',
        'username': phone,
        'password': password,
        'submit': 'continue',
      },
    );
    final response = await Moe.request(
      method: 'GET',
      url: endpoints['home'] ?? '',
      query: {'from': 'Home'},
    );
    final doc = html.parse(response.body);
    final table = doc.querySelector('table#row');
    List<Session> sessions = [];
    if (table == null) {
      if (doc.querySelector('head title')?.innerHtml == 'Enable') {
        throw Exception('Session expired.');
      }
      return sessions;
    } else {
      for (final row in table.querySelectorAll('tbody tr')) {
        sessions.add(Session.fromRowElement(row));
        // sessions.last.printSession();
      }
    }
    return sessions;
  }

  static Future<void> terminateSession(int session) async {
    await Moe.request(
      method: 'GET',
      url: endpoints['logout'] ?? '',
      query: {
        'from': 'curses',
        'sesno': session.toString(),
      },
    );
  }
}
