import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../storage/storage_manager.dart';

/// Holds and persists the app [Locale].
class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider({Locale? initialLocale})
      : _locale = initialLocale ?? _safeInitialLocale();

  static Locale _safeInitialLocale() {
    try {
      final saved = StorageManager.appLocale;
      final isSupported = AppLocalizations.supportedLocales
          .any((l) => l.languageCode == saved.languageCode);
      return isSupported ? saved : const Locale('en');
    } catch (_) {
      return const Locale('en');
    }
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    try {
      StorageManager.setAppLocale(locale.languageCode);
    } catch (_) {}
    notifyListeners();
  }
}
