/// Centralized keys for local preferences and secure storage.
abstract final class StorageKeys {
  // ---------------------------------------------------------------------------
  // SECURE STORAGE KEYS (Sensitive Tokens & Credentials)
  // ---------------------------------------------------------------------------
  static const String accessToken = 'tt_access_token';
  static const String refreshToken = 'tt_refresh_token';
  static const String userPin = 'tt_user_pin';
  static const String loginData = 'tt_login_data';

  // ---------------------------------------------------------------------------
  // PREFERENCES KEYS (User Settings, Device & UI State)
  // ---------------------------------------------------------------------------
  // User Session
  static const String userId = 'tt_user_id';
  static const String userRole = 'tt_user_role';
  static const String userProfile = 'tt_user_profile';
  static const String userName = 'tt_user_name';
  static const String userPhone = 'tt_user_phone';
  static const String userEmail = 'tt_user_email';
  static const String isLoggedIn = 'tt_is_logged_in';
  static const String rememberMe = 'tt_remember_me';

  // App & System State
  static const String themeMode = 'tt_theme_mode'; // 'system', 'light', 'dark'
  static const String appLocale = 'tt_app_locale'; // 'en', 'sw'
  static const String hasCompletedOnboarding = 'tt_has_completed_onboarding';
  static const String isFirstLaunch = 'tt_is_first_launch';

  // Tea Collection Operations
  static const String activeCollectionCentre = 'tt_active_collection_centre';
  static const String activeScaleDeviceId = 'tt_active_scale_device_id';
  static const String activeScaleDeviceName = 'tt_active_scale_device_name';
  static const String lastSyncTimestamp = 'tt_last_sync_timestamp';
}
