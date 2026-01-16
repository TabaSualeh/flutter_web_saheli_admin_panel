import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel {
  AppModel._internal();

  static final AppModel _instance = AppModel._internal();

  static AppModel get instance => _instance;

  // SharedPreferences? _prefs;

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setStringInPref(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setStringsInPref(Map<String, String> values) async {
    _prefs = await SharedPreferences.getInstance();
    var isOk = 0;
    values.forEach((key, value) async {
      var isValueSet = await _prefs.setString(key, value);
      if (isValueSet) isOk++;
    });
    return isOk == values.length;
  }

  String getStringFromPref(String key) {
    String value = _prefs.getString(key) ?? '';
    return value;
  }

  Future<bool> setIntInPref(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  Future<bool> setIntsInPref(Map<String, int> values) async {
    var isOk = 0;
    values.forEach((key, value) async {
      var isValueSet = await _prefs.setInt(key, value);
      if (isValueSet) isOk++;
    });
    return isOk == values.length;
  }

  int getIntFromPref(String key) {
    int value = _prefs.getInt(key) ?? 0;
    return value;
  }

  Future<bool> setBoolInPref(String key, bool value) async {
    return await _prefs.setBool(key, value) ?? false;
  }

  Future<bool?> getBoolFromPref(String key) async {
    bool? value = _prefs.getBool(key);
    return value;
  }

  Future clearDataFromPref(List<String> keys) async {
    for (var key in keys) {
      _prefs.remove(key);
    }
  }

  String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final msgDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (msgDate == today) {
      return DateFormat("hh:mm a").format(dateTime);
    } else if (msgDate == yesterday) {
      return "Yesterday at ${DateFormat("hh:mm a").format(dateTime)}";
    } else {
      return DateFormat("dd MMM yyyy, hh:mm a").format(dateTime);
    }
  }

  String formatSmartDate(DateTime dateTime) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (targetDate == today) return "Today";
    if (targetDate == yesterday) return "Yesterday";

    return DateFormat("dd MMM yyyy").format(dateTime);
  }

  String formatSmartDateNullable(DateTime? dateTime) {
    if (dateTime == null) return "——";

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (target == today) return "Today";
    if (target == yesterday) return "Yesterday";

    return DateFormat("dd MMM yyyy").format(dateTime);
  }
}
