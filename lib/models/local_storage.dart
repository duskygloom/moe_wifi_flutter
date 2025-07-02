import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LocalStorage {
  static final _users = Hive.box(name: 'users');
  static final _config = Hive.box(name: 'config');

  /* configs */

  static String _getConfig(String config) {
    final value = _config.get(config);
    return value != null ? value.toString() : '';
  }

  static void _putConfig(String config, String value) {
    _config.put(config, value);
  }

  static String get currentUser => _getConfig('currentUser'); // current user

  static set currentUser(String username) =>
      _putConfig('currentUser', username);

  static String get route => _getConfig('route'); // route
  static set route(String route) => _putConfig('route', route);

  static int get timeoutInMillis =>
      int.tryParse(_getConfig('timeout')) ?? 5000; // timeout
  static set timeoutInMillis(int timeout) =>
      _putConfig('timeout', timeout.toString());

  static String get cookie => _getConfig('cookie'); // cookie
  static set cookie(String cookie) => _putConfig('cookie', cookie);

  static String get ip => _getConfig('ip'); // ip
  static set ip(String ip) => _putConfig('ip', ip);

  static String get mac => _getConfig('mac'); // mac
  static set mac(String mac) => _putConfig('mac', mac);

  static String get sessCode => _getConfig('sessCode'); // session code
  static set sessCode(String code) => _putConfig('sessCode', code);

  /* users */

  static String getPassword(String phoneNumber) {
    return _users.get(phoneNumber) != null
        ? _users.get(phoneNumber).toString()
        : '';
  }

  static void addUser({required String phoneNumber, required String password}) {
    _users.put(phoneNumber, password);
  }

  static void deleteUser(String phone) {
    _users.delete(phone);
    if (currentUser == phone) {
      currentUser = '';
    }
  }

  /* length and keys */

  static int get usersLength => _users.length;
  static int get configLength => _config.length;

  static List<String> get users => _users.keys.toList();
  static List<String> get configs => _config.keys.toList();
}
