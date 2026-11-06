import 'package:flutter/material.dart';

import 'preferences_service.dart';
import 'secure_storage_service.dart';
import 'storage_keys.dart';

/// Unified storage entry point for TeaTrack.
///
/// Combines [PreferencesService] for app/UI state and [SecureStorageService]
/// for sensitive values.
///
/// ```dart
/// await StorageManager.init(); // once, in main() before runApp
///
/// StorageManager.prefs.setString('key', 'value');
/// await StorageManager.secure.saveAuthTokens(accessToken: '...');
/// final locale = StorageManager.appLocale;
/// ```
class StorageManager {
  StorageManager._();

  static PreferencesService? _preferencesService;
  static SecureStorageService? _secureStorageService;
  static bool _isInitialized = false;

  static Future<void> init({
    PreferencesService? customPrefs,
    SecureStorageService? customSecure,
  }) async {
    if (_isInitialized && customPrefs == null && customSecure == null) return;

    _preferencesService = customPrefs ?? PreferencesService();
    await _preferencesService!.init();

    _secureStorageService = customSecure ?? SecureStorageService();
    _isInitialized = true;
  }

  static PreferencesService get prefs {
    _ensureInitialized();
    return _preferencesService!;
  }

  static SecureStorageService get secure {
    _ensureInitialized();
    return _secureStorageService!;
  }

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'StorageManager is not initialized! Call `await StorageManager.init()` in main.dart before runApp().',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // SESSION
  // ---------------------------------------------------------------------------
  static Future<void> saveSession({
    required String accessToken,
    String? refreshToken,
    required String userId,
    required String userRole,
    Map<String, dynamic>? profileData,
  }) async {
    await secure.saveAuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    await prefs.setString(StorageKeys.userId, userId);
    await prefs.setString(StorageKeys.userRole, userRole);
    await prefs.setBool(StorageKeys.isLoggedIn, true);

    if (profileData != null) {
      await prefs.setObject(StorageKeys.userProfile, profileData, (d) => d);
      final name = profileData['displayName'];
      final phone = profileData['phoneNumber'];
      final email = profileData['email'];
      if (name != null) {
        await prefs.setString(StorageKeys.userName, name.toString());
      }
      if (phone != null) {
        await prefs.setString(StorageKeys.userPhone, phone.toString());
      }
      if (email != null) {
        await prefs.setString(StorageKeys.userEmail, email.toString());
      }
    }
  }

  static Future<String?> getAccessToken() => secure.getAccessToken();

  static Future<String?> getRefreshToken() => secure.getRefreshToken();

  static String? get userId => prefs.getString(StorageKeys.userId);

  static String? get userRole => prefs.getString(StorageKeys.userRole);

  static String? get userName => prefs.getString(StorageKeys.userName);

  static Map<String, dynamic>? get userProfile =>
      prefs.getObject(StorageKeys.userProfile, (json) => json);

  static bool get isLoggedIn => prefs.getBool(StorageKeys.isLoggedIn);

  /// Ends the session but keeps the local database, so unsynced collections
  /// survive a logout.
  static Future<void> clearUserSession() async {
    await secure.clearAuthTokens();
    await secure.delete(StorageKeys.loginData);
    await secure.delete(StorageKeys.userPin);

    await prefs.remove(StorageKeys.userId);
    await prefs.remove(StorageKeys.userRole);
    await prefs.remove(StorageKeys.userProfile);
    await prefs.remove(StorageKeys.userName);
    await prefs.remove(StorageKeys.userPhone);
    await prefs.remove(StorageKeys.userEmail);
    await prefs.setBool(StorageKeys.isLoggedIn, false);
  }

  // ---------------------------------------------------------------------------
  // APP PREFERENCES
  // ---------------------------------------------------------------------------
  static ThemeMode get themeMode {
    return switch (prefs.getString(StorageKeys.themeMode)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static Future<bool> setThemeMode(ThemeMode mode) {
    return prefs.setString(StorageKeys.themeMode, mode.name);
  }

  static Locale get appLocale {
    return Locale(
      prefs.getString(StorageKeys.appLocale, defaultValue: 'en') ?? 'en',
    );
  }

  static Future<bool> setAppLocale(String languageCode) {
    return prefs.setString(StorageKeys.appLocale, languageCode);
  }

  static bool get hasCompletedOnboarding =>
      prefs.getBool(StorageKeys.hasCompletedOnboarding);

  static Future<bool> setOnboardingCompleted() =>
      prefs.setBool(StorageKeys.hasCompletedOnboarding, true);

  static bool get isFirstLaunch =>
      prefs.getBool(StorageKeys.isFirstLaunch, defaultValue: true);

  static Future<bool> setFirstLaunchCompleted() =>
      prefs.setBool(StorageKeys.isFirstLaunch, false);

  // ---------------------------------------------------------------------------
  // TEA COLLECTION OPERATIONS
  // ---------------------------------------------------------------------------
  static String? get activeCollectionCentre =>
      prefs.getString(StorageKeys.activeCollectionCentre);

  static Future<bool> setActiveCollectionCentre(String centreId) =>
      prefs.setString(StorageKeys.activeCollectionCentre, centreId);

  static String? get activeScaleDeviceId =>
      prefs.getString(StorageKeys.activeScaleDeviceId);

  static String? get activeScaleDeviceName =>
      prefs.getString(StorageKeys.activeScaleDeviceName);

  static Future<void> setActiveScaleDevice({
    required String deviceId,
    required String deviceName,
  }) async {
    await prefs.setString(StorageKeys.activeScaleDeviceId, deviceId);
    await prefs.setString(StorageKeys.activeScaleDeviceName, deviceName);
  }

  static DateTime? get lastSyncAt {
    final millis = prefs.getInt(StorageKeys.lastSyncTimestamp);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  static Future<bool> setLastSyncAt(DateTime time) => prefs.setInt(
        StorageKeys.lastSyncTimestamp,
        time.millisecondsSinceEpoch,
      );

  // ---------------------------------------------------------------------------
  // FACTORY RESET
  // ---------------------------------------------------------------------------
  static Future<void> clearAll() async {
    await secure.deleteAll();
    await prefs.clear();
  }
}
