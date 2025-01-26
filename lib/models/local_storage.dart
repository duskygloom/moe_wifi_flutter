import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LocalStorage {
  static final _users = Hive.box(name: 'users');
  static final _config = Hive.box(name: 'config');

  /// Returns password corresponding to the phone
  /// number, if the phone number does not exist,
  /// returns null.
  static String? getPassword(String phoneNumber) {
    return _users.get(phoneNumber);
  }

  static void putPassword(
      {required String phoneNumber, required String password}) {
    _users.put(phoneNumber, password);
  }

  static String? getConfig(String config) {
    return _config.get(config);
  }

  static void putConfig({required String config, required String value}) {
    _config.put(config, value);
  }

  static int get length => _users.length;
  static int get configLength => _config.length;

  static List<String> get users => _users.keys.toList();
  static List<String> get configs => _config.keys.toList();

  static void deleteUser(String phone) {
    _users.delete(phone);
    if (getConfig('currentUser') == phone) {
      deleteConfig('currentUser');
    }
  }

  static void deleteConfig(String config) {
    _config.delete(config);
  }
}
