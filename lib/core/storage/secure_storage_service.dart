import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_keys.dart';

/// Wrapper over FlutterSecureStorage for tokens and credentials.
///
/// Android uses EncryptedSharedPreferences and resets on keystore errors;
/// iOS uses the Keychain with `first_unlock` accessibility so background
/// sync can still read tokens after the first unlock.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
                resetOnError: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      debugPrint('SecureStorageService write error ($key): $e');
      rethrow;
    }
  }

  Future<String?> read(String key, {String? defaultValue}) async {
    try {
      return await _storage.read(key: key) ?? defaultValue;
    } catch (e) {
      debugPrint('SecureStorageService read error ($key): $e');
      return defaultValue;
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      debugPrint('SecureStorageService containsKey error ($key): $e');
      return false;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      debugPrint('SecureStorageService delete error ($key): $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      debugPrint('SecureStorageService deleteAll error: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // JSON OBJECTS
  // ---------------------------------------------------------------------------
  Future<void> writeObject<T>(
    String key,
    T value,
    Map<String, dynamic> Function(T item) toJson,
  ) async {
    try {
      await write(key, jsonEncode(toJson(value)));
    } catch (e) {
      debugPrint('SecureStorageService writeObject error ($key): $e');
    }
  }

  Future<T?> readObject<T>(
    String key,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final jsonString = await read(key);
      if (jsonString == null || jsonString.isEmpty) return null;
      return fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
    } catch (e) {
      debugPrint('SecureStorageService readObject error ($key): $e');
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // AUTH TOKENS
  // ---------------------------------------------------------------------------
  Future<void> saveAuthTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await write(StorageKeys.accessToken, accessToken);
    if (refreshToken != null) {
      await write(StorageKeys.refreshToken, refreshToken);
    }
  }

  Future<String?> getAccessToken() => read(StorageKeys.accessToken);

  Future<String?> getRefreshToken() => read(StorageKeys.refreshToken);

  Future<bool> hasValidToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAuthTokens() async {
    await delete(StorageKeys.accessToken);
    await delete(StorageKeys.refreshToken);
  }
}
