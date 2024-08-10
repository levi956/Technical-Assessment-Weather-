import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  static Future<void> clear() async {
    await preferences.clear();
  }

  static Future<void> initalize() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setInt({
    required String key,
    required int value,
  }) {
    return preferences.setInt(key, value);
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) {
    return preferences.setString(key, value);
  }

  static Future<bool> setBool({
    required String key,
    required bool value,
  }) {
    return preferences.setBool(key, value);
  }

  static String? getString(String key) {
    return preferences.getString(key);
  }

  // ignore: boolean_prefixes
  static bool? getBool(String key) {
    return preferences.getBool(key);
  }

  static int? getInt(String key) {
    return preferences.getInt(key);
  }

  static Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  static Future<bool> setModel<T extends Cachable>({
    required String key,
    required T model,
  }) async {
    return preferences.setString(key, jsonEncode(model.toJson()));
  }

  static T? getModel<T extends Cachable>({
    required String key,
    required T Function(Map<String, dynamic> json) creator,
  }) {
    final value = preferences.getString(key);
    if (value == null) {
      return null;
    }
    return creator(Map.from(jsonDecode(value)));
  }

  static List<String>? getListString({
    required String key,
  }) {
    final list = preferences.getStringList(key);
    if (list == null) {
      return null;
    }
    return list;
  }

  static Future<bool> setListString({
    required String key,
    required List<String> list,
  }) async {
    return await preferences.setStringList(key, list);
  }

  static void setList<T extends Cachable>({
    required String key,
    required List<T> list,
  }) {
    final l = list.map((e) => jsonEncode(e.toJson())).toList();
    preferences.setStringList(key, l);
  }

  static List<T>? getList<T extends Cachable>({
    required String key,
    required T Function(Map<String, dynamic> json) creator,
  }) {
    final list = preferences.getStringList(key);
    if (list == null) {
      return null;
    }
    return list.map((e) => creator(Map.from(jsonDecode(e)))).toList();
  }
}

abstract class Cachable {
  Map<String, dynamic> toJson();
}
