import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper over SharedPreferences with typed accessors and JSON helpers.
class PreferencesService {
  SharedPreferences? _prefs;

  PreferencesService([this._prefs]);

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get _instance {
    if (_prefs == null) {
      throw StateError(
        'PreferencesService is not initialized. Call await StorageManager.init() first.',
      );
    }
    return _prefs!;
  }

  // ---------------------------------------------------------------------------
  // STRINGS
  // ---------------------------------------------------------------------------
  String? getString(String key, {String? defaultValue}) {
    return _instance.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _instance.setString(key, value);
  }

  // ---------------------------------------------------------------------------
  // BOOLEANS
  // ---------------------------------------------------------------------------
  bool getBool(String key, {bool defaultValue = false}) {
    return _instance.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _instance.setBool(key, value);
  }

  Future<bool> toggleBool(String key, {bool defaultValue = false}) async {
    final toggled = !getBool(key, defaultValue: defaultValue);
    await setBool(key, toggled);
    return toggled;
  }

  // ---------------------------------------------------------------------------
  // NUMBERS
  // ---------------------------------------------------------------------------
  int? getInt(String key, {int? defaultValue}) {
    return _instance.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _instance.setInt(key, value);
  }

  Future<int> incrementInt(String key, {int by = 1, int initial = 0}) async {
    final updated = (getInt(key) ?? initial) + by;
    await setInt(key, updated);
    return updated;
  }

  double? getDouble(String key, {double? defaultValue}) {
    return _instance.getDouble(key) ?? defaultValue;
  }

  Future<bool> setDouble(String key, double value) {
    return _instance.setDouble(key, value);
  }

  // ---------------------------------------------------------------------------
  // STRING LISTS
  // ---------------------------------------------------------------------------
  List<String> getStringList(String key, {List<String>? defaultValue}) {
    return _instance.getStringList(key) ?? defaultValue ?? <String>[];
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _instance.setStringList(key, value);
  }

  // ---------------------------------------------------------------------------
  // JSON OBJECTS
  // ---------------------------------------------------------------------------
  Future<bool> setObject<T>(
    String key,
    T value,
    Map<String, dynamic> Function(T item) toJson,
  ) async {
    try {
      return await setString(key, jsonEncode(toJson(value)));
    } catch (e) {
      debugPrint('Error saving object to Preferences ($key): $e');
      return false;
    }
  }

  T? getObject<T>(String key, T Function(Map<String, dynamic> json) fromJson) {
    try {
      final jsonString = getString(key);
      if (jsonString == null || jsonString.isEmpty) return null;
      return fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error parsing object from Preferences ($key): $e');
      return null;
    }
  }

  Future<bool> setObjectList<T>(
    String key,
    List<T> list,
    Map<String, dynamic> Function(T item) toJson,
  ) async {
    try {
      return await setString(key, jsonEncode(list.map(toJson).toList()));
    } catch (e) {
      debugPrint('Error saving object list to Preferences ($key): $e');
      return false;
    }
  }

  List<T> getObjectList<T>(
    String key,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    try {
      final jsonString = getString(key);
      if (jsonString == null || jsonString.isEmpty) return <T>[];
      return (jsonDecode(jsonString) as List<dynamic>)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error parsing object list from Preferences ($key): $e');
      return <T>[];
    }
  }

  // ---------------------------------------------------------------------------
  // HOUSEKEEPING
  // ---------------------------------------------------------------------------
  bool containsKey(String key) => _instance.containsKey(key);

  Future<bool> remove(String key) => _instance.remove(key);

  Future<bool> clear() => _instance.clear();

  Set<String> getAllKeys() => _instance.getKeys();
}
